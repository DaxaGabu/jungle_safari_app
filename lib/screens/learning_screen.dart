import 'package:flutter/material.dart';
import 'detail_screen.dart';


class LearningScreen extends StatelessWidget {
  final String zone;
  LearningScreen({required this.zone});

  final Map<String, List<Map<String, String>>> learningContent = {
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 2 : 3; // 2 columns on small screens, 3 on large
    double childAspectRatio = screenWidth < 600 ? 0.85 : 0.9; // Adjust height ratio

    return Scaffold(
      appBar: AppBar(
        title: Text('$zone Learning'),
        backgroundColor: const Color.fromARGB(255, 147, 221, 151),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.greenAccent, // Light Green
              Colors.lightBlueAccent, // Light Blue
              Colors.orangeAccent, // Orange
              Colors.pinkAccent, // Pink
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: learningContent[zone]?.length ?? 0,
          itemBuilder: (context, index) {
            var item = learningContent[zone]![index];
            return _buildItemCard(context, item, screenWidth);
          },
        ),
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, Map<String, String> item, double screenWidth) {
    double imageSize = screenWidth * 0.20; // Adjust image size relative to screen width
    double textSize = screenWidth * 0.04; // Adaptive text size

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(name: item['name']!, imagePath: item['image']!),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item['image']!,
                height: imageSize, // Responsive image size
                width: imageSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.lightGreen.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item['name']!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
