import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _isAnswerCorrect = false;
  bool _answered = false; // To prevent multiple taps

  final List<Map<String, Object>> _questions = [
    {
      'question': 'What is the king of the jungle?',
      'answers': [
        {'text': 'Lion', 'score': 1},
        {'text': 'Tiger', 'score': 0},
        {'text': 'Elephant', 'score': 0},
      ],
    },
    {
      'question': 'Which animal is the largest land mammal?',
      'answers': [
        {'text': 'Elephant', 'score': 1},
        {'text': 'Giraffe', 'score': 0},
        {'text': 'Rhino', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int index, int score) {
    if (_answered) return; // Prevent multiple taps

    setState(() {
      _selectedAnswerIndex = index;
      _isAnswerCorrect = (score == 1);
      _answered = true; // Mark as answered
      if (_isAnswerCorrect) {
        _score += score;
      }
    });

    // Wait 1 second and go to next question
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _questionIndex++;
        _selectedAnswerIndex = null;
        _answered = false; // Allow answering again
      });
    });
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
      _selectedAnswerIndex = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Time 🦁'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 122, 169, 191), Colors.lightGreenAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: _questionIndex < _questions.length
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Progress Indicator
                    LinearProgressIndicator(
                      value: (_questionIndex + 1) / _questions.length,
                      backgroundColor: const Color.fromARGB(255, 195, 126, 126),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    SizedBox(height: 20),

                    // Question Card
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 8,
                      color: const Color.fromARGB(255, 207, 121, 121).withOpacity(0.9),
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.04),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _questions[_questionIndex]['question'] as String,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Answer Buttons
                    ...(_questions[_questionIndex]['answers'] as List<Map<String, Object>>)
                        .asMap()
                        .entries
                        .map((entry) {
                          int index = entry.key;
                          Map<String, Object> answer = entry.value;
                          bool isSelected = index == _selectedAnswerIndex;
                          bool isCorrect = answer['score'] as int == 1;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _answerQuestion(index, answer['score'] as int),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
                                  textStyle: TextStyle(
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: isSelected
                                      ? (isCorrect ? Colors.green : Colors.red) // Green for correct, Red for wrong
                                      : Colors.orange.shade600,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(answer['text'] as String),
                                    if (isSelected)
                                      Icon(
                                        isCorrect ? Icons.check : Icons.close, // ✔️ for correct, ❌ for wrong
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                        .toList(),
                  ],
                )
              // Result Screen
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Quiz Completed! 🎉',
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Your Score: $_score / ${_questions.length}',
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 54, 100, 169),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _restartQuiz,
                        icon: Icon(Icons.refresh, size: 24),
                        label: Text('Retry Quiz'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02,
                              horizontal: size.width * 0.1),
                          textStyle: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
