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
      'info': 'Lions (Panthera leo) are big cats found in Africa and India.\nThey live in groups called prides and are known for their strength and loud roar.',
      'sanctuary': 'Gir Forest, India – Only place with Asiatic lions.\nSerengeti, Tanzania – Huge lion population.\nMasai Mara, Kenya – Best safari experience.'
    },
     'Tiger': {
      'info': 'Tigers (Panthera tigris) are the largest wild cats, known for their orange coat with black stripes. They are solitary hunters and excellent swimmers. Found mainly in Asia, they live in forests and grasslands.',
       'sanctuary': 'Ranthambore, India – Best for Bengal tigers.\nSundarbans, India & Bangladesh – Home to swimming tigers.\nJim Corbett, India – India’s first tiger reserve.\nBandhavgarh, India – High chance of tiger sightings.\nSiberia, Russia – Land of the rare Siberian tiger.',
    },

    'Elephant': {
      'info': 'Elephants are the largest land animals, known for their intelligence, strong memory, and social bonds. They are found in Africa and Asia, living in forests and grasslands.',
    
      'sanctuary': 'Kaziranga, India – Home to wild Asian elephants.\nJim Corbett, India – Famous for elephant herds.\nAmboseli, Kenya – Best place for African elephants.\nChobe, Botswana – Highest elephant population.\nUdawalawe, Sri Lanka – Great for elephant safaris.',
    },
      'Crocodile': {
      'info': 'Crocodiles are large, powerful reptiles found in rivers, lakes, and wetlands. They are known for their strong jaws and stealthy hunting. They have existed for millions of years and are found in Africa, Asia, Australia, and the Americas.',
      'sanctuary': 'Sundarbans, India & Bangladesh – Home to saltwater crocodiles.\nKaziranga, India – Habitat for the rare gharial.\nEverglades, USA – American crocodiles and alligators live here.\nNile River, Africa – Home to the deadly Nile crocodile.\nAustralia’s Northern Territory – Saltwater crocodiles in the wild.',
    },

      'Rhinoceros': {
      'info': 'Rhinoceroses (Rhinos) are large herbivores with thick skin and one or two horns. Found in Africa and Asia, they live in grasslands and forests.',
       'sanctuary': 'Kaziranga, India – One-horned rhinos.\nChitwan, Nepal – Protected rhino reserve.\nKruger, South Africa – Black & white rhinos.\nSerengeti, Tanzania – Rare black rhinos.\nSumatra, Indonesia – Endangered Sumatran rhinos.',
    },
      'Deer': {
      'info': 'Deer are gentle, fast-running animals with antlers (in males). They live in forests, grasslands, and mountains across the world.',
      'sanctuary': 'Kanha, India – Barasingha (swamp deer).\nSundarbans, India – Spotted deer.\nYellowstone, USA – Home to elk and mule deer.\nScottish Highlands, UK – Red deer habitat.\nHokkaido, Japan – Sika deer roaming freely.',
    },
////Palnt 
      'Aloe Vera': {
      'info': 'Aloe Vera is a succulent plant known for its thick, fleshy leaves filled with gel. It is widely used for skincare and medicinal purposes.',
      'ayurveda': 'Aloe Vera is used in Ayurveda for treating burns, wounds, and digestive issues. It helps detoxify the body and boosts immunity.',
      'sanctuary': 'Commonly grown in India, Mexico, and Africa. Best cultivated in warm, dry climates.',
    },
    'Ashwagandha': {
      'info': 'Ashwagandha (Withania somnifera) is an adaptogenic herb known for reducing stress and boosting vitality.',
      'ayurveda': 'Used in Ayurveda to improve strength, endurance, reduce anxiety, and boost immunity.',
      'sanctuary': 'Grown in India, the Middle East, and parts of Africa.',
    },
   
    'Tulsi': {
      'info': 'Tulsi is a sacred plant in India, known for its strong aroma and medicinal benefits.',
      'ayurveda': 'Used in Ayurveda for respiratory issues, stress relief, and boosting immunity.',
      'sanctuary': 'Widely cultivated across India and Southeast Asia.',
    },
    'Bamboo': {
      'info': 'Bamboo is a fast-growing grass species known for its versatile use in construction, furniture, and paper production.',
      'ayurveda': 'Used in Ayurveda for treating respiratory issues, improving digestion, and strengthening bones.',
      'sanctuary': 'Found in India, China, Southeast Asia, and tropical regions worldwide.',
    },
    'Sandalwood': {
      'info': 'Sandalwood is a fragrant tree known for its essential oil and use in religious rituals.',
      'ayurveda': 'Sandalwood is used in Ayurveda for skin care, stress relief, and as a natural coolant for the body.',
      'sanctuary': 'Grown in India, Australia, and Indonesia.',
    },

    //Flowers
     
  "Hibiscus": {
    "info": "Hibiscus is a vibrant flowering plant known for its large, colorful blossoms and numerous medicinal benefits.",
    "ayurveda": "Hibiscus is used in Ayurveda for improving hair health, regulating blood pressure, and aiding digestion.",
    "sanctuary": "Commonly found in India, China, and tropical regions worldwide.",
  },
  "Jasmine": {
    "info": "Jasmine is a fragrant flower known for its pleasant aroma and use in perfumes and teas.",
    "ayurveda": "Used in Ayurveda for reducing stress, improving sleep, and promoting healthy skin.",
    "sanctuary": "Native to tropical and warm temperate regions, including India and Southeast Asia.",
  },
  "Lotus": {
    "info": "Lotus is a sacred aquatic plant known for its spiritual significance and medicinal properties.",
    "ayurveda": "Lotus is used in Ayurveda for cooling the body, improving digestion, and boosting immunity.",
    "sanctuary": "Commonly found in India, China, and Southeast Asia in freshwater habitats.",
  },
  "Marigolds": {
    "info": "Marigolds are bright orange or yellow flowers widely used in decorations and herbal medicine.",
    "ayurveda": "Used in Ayurveda for skin treatments, anti-inflammatory benefits, and wound healing.",
    "sanctuary": "Cultivated in India, Mexico, and many temperate regions.",
  },
  "Parijat": {
    "info": "Parijat, also known as Night-flowering Jasmine, is a fragrant flower with significant medicinal value.",
    "ayurveda": "Used in Ayurveda for treating fever, arthritis, and respiratory ailments.",
    "sanctuary": "Found in India, Nepal, and Southeast Asia.",
  },
  "Rose": {
    "info": "Rose is a well-known flower valued for its fragrance and ornamental beauty.",
    "ayurveda": "Used in Ayurveda for skincare, stress relief, and digestive health.",
    "sanctuary": "Grown worldwide, including India, Europe, and the Middle East.",
  },
  "Saffron": {
    "info": "Saffron is a valuable spice derived from the flower Crocus sativus, known for its vivid red stigmas.",
    "ayurveda": "Used in Ayurveda for improving complexion, boosting mood, and enhancing digestion.",
    "sanctuary": "Cultivated in India (Kashmir), Iran, and Mediterranean regions.",
  },
   //vegetable s
  "Ash Gourd": {
    "info": "Ash Gourd, also known as Winter Melon, is a hydrating vegetable rich in fiber and nutrients.",
    "benefit": "Used in Ayurveda for cooling the body, improving digestion, and detoxifying the system.",
    "sanctuary": "Commonly grown in India, China, and Southeast Asia.",
  },
  "Bitter Gourd": {
    "info": "Bitter Gourd, also known as Bitter Melon, is a vegetable known for its strong bitter taste and medicinal properties.",
    "benefit": "Used in Ayurveda for controlling diabetes, boosting immunity, and improving digestion.",
    "sanctuary": "Cultivated in tropical and subtropical regions like India, China, and Africa.",
  },
  "Bottle Gourd": {
    "info": "Bottle Gourd is a water-rich vegetable known for its light and nutritious properties.",
    "benefit": "Helps in weight loss, improves digestion, and keeps the body cool.",
    "sanctuary": "Widely grown in India, Southeast Asia, and Africa.",
  },
  "Carrot": {
    "info": "Carrot is a root vegetable known for its rich vitamin A content and crunchy texture.",
    "benefit": "Improves vision, boosts immunity, and supports skin health.",
    "sanctuary": "Grown worldwide, especially in India, China, and Europe.",
  },
  "Moringa": {
    "info": "Moringa, also known as Drumstick, is a highly nutritious vegetable with medicinal properties.",
    "benefit": "Rich in antioxidants, supports immunity, and improves bone health.",
    "sanctuary": "Common in India, Africa, and Southeast Asia.",
  },
  "Pumpkin": {
    "info": "Pumpkin is a nutrient-rich vegetable known for its sweet taste and multiple health benefits.",
    "benefit": "Boosts immunity, improves digestion, and supports heart health.",
    "sanctuary": "Widely cultivated in India, North America, and Europe.",
  },
  "Spinach": {
    "info": "Spinach is a leafy green vegetable packed with iron, vitamins, and antioxidants.",
    "benefit": "Boosts energy, improves bone health, and supports immunity.",
    "sanctuary": "Grown in temperate regions worldwide, including India, China, and the USA.",
  },
   //Tree

  "Amaltas": {
    "info": "Amaltas (Golden Shower Tree) is a beautiful tree with bright yellow flowers, often used in traditional medicine.",
    "benefit": "Used in Ayurveda for treating fever, constipation, and skin disorders.",
    "sanctuary": "Found in tropical and subtropical forests across India, Sri Lanka, and Southeast Asia.",

  },
  "Arjuna": {
    "info": "Arjuna (Terminalia arjuna) is a medicinal tree known for its strong bark and health benefits.",
    "benefit": "Used in Ayurveda for heart health, blood pressure regulation, and improving circulation.",
    "sanctuary": "Common in Indian forests, especially in the Western Ghats and sub-Himalayan regions.",

  },
  "Bael": {
    "info": "Bael (Aegle marmelos) is a sacred tree with fragrant fruits, widely used in traditional medicine.",
    "benefit": "Its fruit and leaves help in digestion, diabetes control, and boosting immunity.",
    "sanctuary": "Found in dry forests of India, Sri Lanka, and Southeast Asia.",
   
  },
  "Banyan": {
    "info": "The Banyan tree is a massive, sacred tree known for its aerial roots and longevity.",
    "benefit": "Used in Ayurveda for treating diabetes, skin infections, and inflammation.",
    "sanctuary": "Found in tropical regions of India, Nepal, and Sri Lanka.",

  },
  "Neem": {
    "info": "Neem (Azadirachta indica) is a medicinal tree known for its antibacterial and antifungal properties.",
    "benefit": "Used for skin care, dental hygiene, and treating infections in Ayurveda.",
    "sanctuary": "Common in India, Bangladesh, and Africa.",
  },
  "Peepal": {
    "info": "Peepal (Sacred Fig) is a sacred tree in Indian culture, known for its heart-shaped leaves.",
    "benefit": "Used in Ayurveda for respiratory issues, digestive problems, and stress relief.",
    "sanctuary": "Common in India, Nepal, and Southeast Asia.",
  },
  "Sal": {
    "info": "Sal (Shorea robusta) is a tall hardwood tree used for timber and traditional medicine.",
    "benefit": "Its resin and leaves are used in Ayurveda for skin disorders and wound healing.",
    "sanctuary": "Found in dense forests of India, Nepal, and Bhutan.",
  },
  
// bried

  "Eagle": {
    "info": "Eagles are powerful birds of prey known for their sharp vision, strong talons, and majestic flight.",
    "sanctuary": "Found in wildlife sanctuaries like Bharatpur Bird Sanctuary (India), Yellowstone National Park (USA), and Kruger National Park (South Africa).",
  },
  "Flamingo": {
    "info": "Flamingos are tall, pink-colored wading birds known for their long legs and unique feeding habits.",
    "sanctuary": "Common in Rann of Kutch (India), Everglades National Park (USA), and Lake Nakuru (Kenya).",
  
  },
  "Hornbill": {
    "info": "Hornbills are large birds with curved, colorful beaks and are important seed dispersers in forests.",
    "sanctuary": "Found in forests like Namdapha National Park (India), Borneo Rainforest (Malaysia), and Kinabatangan Wildlife Sanctuary.",
  
  },
  "Kingfisher": {
    "info": "Kingfishers are small, brightly colored birds known for their excellent diving and fishing skills.",
    "sanctuary": "Commonly found in Bharatpur Bird Sanctuary (India), Sundarbans (India/Bangladesh), and Amazon Rainforest.",
    
  },
  "Owl": {
    "info": "Owls are nocturnal birds of prey with excellent night vision and silent flight.",
    "sanctuary": "Found in forests like Jim Corbett National Park (India), Yellowstone National Park (USA), and African Savannah.",
  
  },
  "Parrot": {
    "info": "Parrots are intelligent, colorful birds known for their ability to mimic sounds and words.",
    "sanctuary": "Common in Amazon Rainforest, Western Ghats (India), and New Guinea.",
 
  },
  "Peacock": {
    "info": "Peacocks are vibrant birds famous for their colorful tail feathers and elegant courtship displays.",
    "sanctuary": "Common in Keoladeo National Park (India), Yala National Park (Sri Lanka), and tropical forests.",

  },
  "Sarus": {
    "info": "The Sarus Crane is the tallest flying bird, known for its long legs and graceful flight.",
    "sanctuary": "Found in Bharatpur Bird Sanctuary (India), Keoladeo National Park (India), and wetlands in Australia and Southeast Asia.",
   
  }
  };

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    List<Map<String, dynamic>> generatedQuestions = [];
    itemDetails.forEach((key, details) {
      if (details.containsKey('info')) {
        generatedQuestions.add({
          'question': 'What is $key known for?',
          'correctAnswer': details['info']!,
          'options': _generateOptions(details['info']!),
        });
      }
      if (details.containsKey('sanctuary')) {
        generatedQuestions.add({
          'question': 'Where is $key commonly found?',
          'correctAnswer': details['sanctuary']!,
          'options': _generateOptions(details['sanctuary']!),
        });
      }
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
    options.addAll(possibleAnswers.take(3));
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
    if (_correctAnswers >= 2) {
      // Show a congratulatory message before going to the next level
      _showCongratulationDialog();
    } else {
      _showGameOverDialog();
    }
  }

  void _showCongratulationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🎉 Congratulations!'),
        content: Text('You have completed Level $_level.\nFinal Score: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _nextLevel();
            },
            child: Text('Proceed to Next Level'),
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
        title: Text('❌ Game Over!'),
        content: Text('You needed at least 2 correct answers to advance.\nFinal Score: $_score'),
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
        backgroundColor: Colors.deepPurple[50],
        appBar: AppBar(title: Text('Mini Game - Quiz')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.deepPurple[100], // Updated background color
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Mini Game - Quiz (Level $_level)'),
        centerTitle: true,
      ),
      body: Padding(
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: _answerColor, // Feedback color
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
    );
  }
}
