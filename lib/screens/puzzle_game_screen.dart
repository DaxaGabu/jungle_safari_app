import 'package:flutter/material.dart';
import 'dart:math';
import 'exit_screen.dart'; // Import Exit Screen

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
  Set<String> correctlyPlacedItems = {}; // ✅ Tracks placed images

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
      {'name': 'Elephant', 'image': 'assets/Animal/elephant.jpg'},
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
    'Flowers': [
      {"name": "Hibiscus", "image": "assets/flowers/hibiscus.jpg"},
      {"name": "Jasmine", "image": "assets/flowers/Jasmine.jpg"},
      {"name": "Lotus", "image": "assets/flowers/Lotus.jpg"},
      {"name": "Marigolds", "image": "assets/flowers/Marigolds.jpg"},
      {"name": "Parijat", "image": "assets/flowers/Parijat.jpg"},
      {"name": "Rose", "image": "assets/flowers/Rose.jpg"},
      {"name": "Saffron", "image": "assets/flowers/saffron.jpg"},
    ],
    'Trees': [
    {"name": "Amaltas", "image": "assets/Trees/Amaltas.jpg"},
    {"name": "Arjuna", "image": "assets/Trees/Arjuna.jpg"},
    {"name": "Bael", "image": "assets/Trees/Bael.jpg"},
    {"name": "Banyan", "image": "assets/Trees/Banyan.jpg"},
    {"name": "Neem", "image": "assets/Trees/Neem.jpg"},
    {"name": "Peepal", "image": "assets/Trees/Peepal.jpg"},
    {"name": "Sal", "image": "assets/Trees/Sal.jpg"},
    {"name": "Sandalwood", "image": "assets/Trees/Sandalwood.jpg"}
  ],
  'Vegetables': [
    {"name": "Ash Gourd", "image": "assets/Vegetables/Ash_gourd.jpg"},
    {"name": "Bitter Gourd", "image": "assets/Vegetables/Bitter_Gourd.jpg"},
    {"name": "Bottle Gourd", "image": "assets/Vegetables/Bottle_Gourd.jpg"},
    {"name": "Carrot", "image": "assets/Vegetables/Carrot.jpg"},
    {"name": "Moringa", "image": "assets/Vegetables/Moringa.jpg"},
    {"name": "Pumpkin", "image": "assets/Vegetables/Pumpkin.jpg"}
  ],
  'Birds': [
    {"name": "Eagle", "image": "assets/Birds/Eagle.jpg"},
    {"name": "Flamingo", "image": "assets/Birds/Flamingo.jpg"},
    {"name": "Hornbill", "image": "assets/Birds/Hornbill.jpg"},
    {"name": "Kingfisher", "image": "assets/Birds/Kingfisher.jpg"},
    {"name": "Owl", "image": "assets/Birds/Owl.jpg"},
    {"name": "Parrot", "image": "assets/Birds/Parrot.jpg"},
    {"name": "Peacock", "image": "assets/Birds/peacock.jpg"},
    {"name": "Sarus", "image": "assets/Birds/Sarus.jpg"}
    ],
    'Colors' : [
      {"name": "blue", "image": "assets/color/blue.jpg"},
      {"name": "Green", "image": "assets/color/Green.jpg"},
      {"name": "gray", "image": "assets/color/gray.jpg"},
      {"name": "orange", "image": "assets/color/orange.jpg"},
      {"name": "Red", "image": "assets/color/Red.jpg"},
      {"name": "yellow", "image": "assets/color/yellow.jpg"}
    ],
    };
  }

  void _loadLevel() {
    if (learningContent.containsKey(widget.zone)) {
      List<String> allItems =
          learningContent[widget.zone]!.map((item) => item['name']!).toList();
      int itemCount = min(currentLevel + 2, allItems.length);
      correctOrder = allItems.sublist(0, itemCount);
      correctlyPlacedItems.clear(); // ✅ Reset placed images
      _shufflePuzzle();
    } else {
      correctOrder = [];
    }
  }

  void _shufflePuzzle() {
    setState(() {
      shuffledOrder = correctOrder.toList()..shuffle(Random());
      boxColors.clear();
    });
  }

  void _onDragAccept(String item, int index) {
    setState(() {
      if (correctOrder[index] == item) {
        shuffledOrder[index] = item;
        boxColors[index] = Colors.green;
        correctlyPlacedItems.add(item); // ✅ Mark as correctly placed
        score++;

        if (_isPuzzleSolved()) {
          _showSuccessDialog();
        }
      } else {
        boxColors[index] = Colors.red;
      }
    });
  }

  bool _isPuzzleSolved() {
    return correctlyPlacedItems.length == correctOrder.length;
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
            colors: [
              Colors.greenAccent,
              Colors.lightBlueAccent,
              Colors.orangeAccent,
              Colors.pinkAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Drag and Drop the Images Correctly!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
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
                      child: correctlyPlacedItems.contains(correctOrder[index])
                          ? Image.asset(images[correctOrder[index]]!, fit: BoxFit.cover)
                          : Center(
                              child: Text(
                                correctOrder[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: shuffledOrder
                  .where((item) => !correctlyPlacedItems.contains(item)) // ✅ Only show draggable items
                  .map((item) {
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
      appBar: AppBar(title: Text('Performance & Results'), backgroundColor: Colors.green),
      body: Center(
        child: Text('Your Score: $score', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
