import 'package:flutter/material.dart';
import 'start_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Responsive background image
              Image.asset(
                'assets/background.png', // Ensure the image exists in assets
                fit: BoxFit.cover,
              ),
              // Loading indicator at the bottom
              Positioned(
                bottom: constraints.maxHeight * 0.1, // 10% from bottom
                left: 0,
                right: 0,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
