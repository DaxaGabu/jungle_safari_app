import 'dart:math';
import 'package:flutter/material.dart';

class MiniGamesScreen extends StatefulWidget {
  @override
  _MiniGameState createState() => _MiniGameState();
}

class _MiniGameState extends State<MiniGamesScreen> {
  final Random _random = Random();
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _level = 1;
  int _correctAnswers = 0;
  Color _answerColor = Colors.transparent;
  List<Map<String, dynamic>> _questions = [];

  final Map<String, Map<String, String>> itemDetails = {
    'Lion': {
      'info': 'Big cat with a loud roar.',
      'sanctuary': 'Lives in Gir Forest, India.',
    },
    'Elephant': {
      'info': 'Largest land animal with a trunk.',
      'sanctuary': 'Found in Kaziranga, India.',
    },
    'Tiger': {
      'info': 'Striped big cat that hunts alone.',
      'sanctuary': 'Seen in Ranthambore, India.',
    },
    'Peacock': {
      'info': 'Bird with colorful tail feathers.',
      'sanctuary': 'India’s national bird.',
    },
    'Rose': {
      'info': 'A fragrant flower with soft petals.',
      'sanctuary': 'Grown in gardens worldwide.',
    },
    'Bamboo': {
      'info': 'A fast-growing plant used for furniture.',
      'sanctuary': 'Found in forests of India and China.',
    },
    'Carrot': {
      'info': 'A crunchy orange vegetable.',
      'sanctuary': 'Grown on farms worldwide.',
    },
    'Neem': {
      'info': 'A tree known for its medicinal leaves.',
      'sanctuary': 'Common in India and Africa.',
    }, 
  };

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    List<Map<String, dynamic>> generatedQuestions = [];
    itemDetails.forEach((key, details) {
      generatedQuestions.add({
        'question': 'What is a $key known for?',
        'correctAnswer': details['info']!,
        'options': _generateOptions(details['info']!),
      });
      generatedQuestions.add({
        'question': 'Where is $key found?',
        'correctAnswer': details['sanctuary']!,
        'options': _generateOptions(details['sanctuary']!),
      });
    });

    generatedQuestions.shuffle();
    setState(() {
      _questions = generatedQuestions.take(10).toList();
    });
  }

  List<String> _generateOptions(String correctAnswer) {
    List<String> options = [correctAnswer];
    List<String> possibleAnswers = itemDetails.values
        .expand((details) => details.values)
        .where((value) => value != correctAnswer)
        .toList();

    possibleAnswers.shuffle();
    options.addAll(possibleAnswers.take(2)); // Only 3 answer choices
    options.shuffle();
    return options;
  }

  void _checkAnswer(String selectedAnswer) {
    bool isCorrect = _questions[_currentQuestionIndex]['correctAnswer'] == selectedAnswer;

    setState(() {
      _answerColor = isCorrect ? Colors.green : Colors.red;
      if (isCorrect) {
        _score += 10;
        _correctAnswers++;
      }
    });

    Future.delayed(Duration(milliseconds: 500), () {
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _answerColor = Colors.transparent;
        });
      } else {
        _evaluateLevel();
      }
    });
  }

  void _evaluateLevel() {
    if (_correctAnswers >= 3) {
      _showCongratulationDialog();
    } else {
      _showGameOverDialog();
    }
  }

  void _showCongratulationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🎉 Great Job!'),
        content: Text('You passed Level $_level!\nScore: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _nextLevel();
            },
            child: Text('Next Level'),
          ),
        ],
      ),
    );
  }

  void _nextLevel() {
    setState(() {
      _level++;
      _currentQuestionIndex = 0;
      _correctAnswers = 0;
      _answerColor = Colors.transparent;
      _generateQuestions();
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('❌ Try Again!'),
        content: Text('You needed 3 correct answers to pass.\nScore: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _restartGame();
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _restartGame() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _level = 1;
      _correctAnswers = 0;
      _answerColor = Colors.transparent;
      _generateQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Mini Game - Quiz (Level $_level)'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.greenAccent, // Light Green
              Colors.lightBlueAccent, // Light Blue
              Colors.orangeAccent, // Orange
              Colors.pinkAccent, // Soft Orange
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _questions.length,
                color: Colors.deepPurple,
                backgroundColor: Colors.purple[100],
              ),
              SizedBox(height: 20),
              Text(
                'Score: $_score  |  Level: $_level',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: _answerColor,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Question ${_currentQuestionIndex + 1}/${_questions.length}\n\n${currentQuestion['question']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ...currentQuestion['options'].map<Widget>((option) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _checkAnswer(option),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      option,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }).toList(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
