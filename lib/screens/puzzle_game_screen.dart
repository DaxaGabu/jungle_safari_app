import 'package:flutter/material.dart';
import 'dart:math';
import 'exit_screen.dart'; // Import the Exit Screen

class PuzzleGameScreen extends StatefulWidget {
  final String zone;
  PuzzleGameScreen({required this.zone});

  @override
  _PuzzleGameScreenState createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen> {
  List<String> correctOrder = [];
  List<String> shuffledOrder = [];
  late Map<String, List<Map<String, String>>> learningContent;
  Map<int, Color> boxColors = {};
  int currentLevel = 1;
  int maxLevel = 5;
  int score = 0;

  final List<List<Color>> levelBackgrounds = [
    [Colors.greenAccent, Colors.teal],
    [Colors.orange, Colors.deepOrange],
    [Colors.purple, Colors.pink],
    [Colors.blueAccent, Colors.indigo],
    [Colors.yellow, Colors.amber]
  ];

  @override
  void initState() {
    super.initState();
    _initializeContent();
    _loadLevel();
  }

  void _initializeContent() {
    learningContent = {
      'Animals': [
        {'name': 'Lion', 'image': 'assets/Animal/line.jpg'},
        {'name': 'Tiger', 'image': 'assets/Animal/tigers.jpg'},
        {'name': 'Elephant', 'image': 'assets/Animal/Elephant.jpg'},
        {'name': 'Crocodile', 'image': 'assets/Animal/crocodil.jpg'},
        {'name': 'Rhinoceros', 'image': 'assets/Animal/Rhinoceros.jpg'},
        {'name': 'Deer', 'image': 'assets/Animal/deer.jpg'},
      ],
      'Plants': [
        {'name': 'Aloe Vera', 'image': 'assets/plants/Aloe_vera.jpg'},
        {'name': 'Ashwagandha', 'image': 'assets/plants/Ashwagandha.jpg'},
        {'name': 'Neem', 'image': 'assets/plants/Neem.jpg'},
        {'name': 'Tulsi', 'image': 'assets/plants/tulsi.jpg'},
        {'name': 'Bamboo', 'image': 'assets/plants/Bamboo.jpg'},
        {'name': 'Sandalwood', 'image': 'assets/plants/sandalwood.jpg'},
      ],
      // Add the other categories similarly...
    };
  }

  void _loadLevel() {
    if (learningContent.containsKey(widget.zone)) {
      List<String> allItems = List.from(learningContent[widget.zone]!.map((item) => item['name']!));
      int itemCount = min(currentLevel + 2, allItems.length);
      correctOrder = allItems.sublist(0, itemCount);
      _shufflePuzzle();
    } else {
      correctOrder = [];
    }
  }

  void _shufflePuzzle() {
    setState(() {
      shuffledOrder = List.from(correctOrder)..shuffle(Random());
      boxColors.clear();
    });
  }

  void _onDragAccept(String item, int index) {
    setState(() {
      if (correctOrder[index] == item) {
        shuffledOrder[index] = item;
        boxColors[index] = Colors.green;
        score++; // Increase score when correct item is dropped
        if (_isPuzzleSolved()) {
          _showSuccessDialog();
        }
      } else {
        boxColors[index] = Colors.red;
      }
    });
  }

  bool _isPuzzleSolved() {
    return shuffledOrder.join() == correctOrder.join();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("🎉 Level Completed!"),
        content: Text("Great job! Ready for the next level?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _nextLevel();
            },
            child: Text("Next Level"),
          ),
        ],
      ),
    );
  }

  void _nextLevel() {
    if (currentLevel < maxLevel) {
      setState(() {
        currentLevel++;
        _loadLevel();
      });
    } else {
      _showGameCompletedDialog();
    }
  }

  void _showGameCompletedDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PerformanceScreen(score: score),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> images = {
      for (var item in learningContent[widget.zone]!) item['name']!: item['image']!
    };

    return Scaffold(
      appBar: AppBar(
        title: Text("Puzzle Game 🧩 - Level $currentLevel"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Navigate to ExitScreen when pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExitScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: levelBackgrounds[(currentLevel - 1) % levelBackgrounds.length],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Drag and Drop the Images Correctly!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(correctOrder.length, (index) {
                return DragTarget<String>( 
                  onAccept: (data) => _onDragAccept(data, index),
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(12),
                        color: boxColors[index] ?? Colors.grey[300],
                      ),
                      child: shuffledOrder[index] != correctOrder[index]
                          ? Center(
                              child: Text(
                                correctOrder[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            )
                          : Image.asset(images[shuffledOrder[index]]!, fit: BoxFit.cover),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: correctOrder.map((item) {
                return Draggable<String>(
                  data: item,
                  feedback: Material(
                    child: Image.asset(images[item]!, width: 80, height: 80),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.2,
                    child: Image.asset(images[item]!, width: 80, height: 80),
                  ),
                  child: Image.asset(images[item]!, width: 80, height: 80),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _shufflePuzzle,
              icon: Icon(Icons.shuffle),
              label: Text("Shuffle 🔀"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}

class PerformanceScreen extends StatelessWidget {
  final int score;

  PerformanceScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance & Results'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your Score: $score',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20),
              Text(
                score > 5 ? 'Great Job! 🎉' : 'Keep Practicing! 💪',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Colors.blue,
                ),
                child: Text('Back to Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
