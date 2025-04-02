import 'package:flutter/material.dart';
import 'learning_screen.dart';

class SelectZoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Get screen size

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Learning Zone'),
        backgroundColor: Colors.green.shade200, // Adjusted app bar color
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.greenAccent, // Light Green
              Colors.lightBlueAccent, // Light Blue
              Colors.orangeAccent, // Orange
              Colors.pinkAccent, // Soft Orange
            ],
          ),
        ),
        child: GridView.builder(
          padding: EdgeInsets.all(size.width * 0.04),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two cards in a row
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1, // Ensures equal height & width
          ),
          itemCount: _zones.length,
          itemBuilder: (context, index) {
            return _buildZoneCard(
                context, _zones[index]['title']!, _zones[index]['imagePath']!, size);
          },
        ),
      ),
    );
  }

  Widget _buildZoneCard(BuildContext context, String title, String imagePath, Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LearningScreen(zone: title)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        color: Colors.white.withOpacity(0.9),
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.3, // 30% of screen width
                height: size.width * 0.3, // Keep images square
                decoration: BoxDecoration(
                color: Colors.lightGreen.shade100,
                borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: size.width * 0.02,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// List of zones
final List<Map<String, String>> _zones = [
  {'title': 'Animals', 'imagePath': 'assets/animal.jpg'},
  {'title': 'Flowers', 'imagePath': 'assets/Flower.jpg'},
  {'title': 'Vegetables', 'imagePath': 'assets/Vegetable.jpg'},
  {'title': 'Trees', 'imagePath': 'assets/tree.jpg'},
  {'title': 'Plants', 'imagePath': 'assets/plant.png'},
  {'title': 'Colors', 'imagePath': 'assets/Colors.jpg'},
  {'title': 'Birds', 'imagePath': 'assets/Bird.jpg'},
];
