import 'package:flutter/material.dart';
import 'select_zone_screen.dart';
import 'mini_games_screen.dart';
import 'puzzle_game_screen.dart'; // Import the Puzzle Game Screen
import '/utils/sound_manager.dart'; // Import SoundManager

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isSoundOn = true; // Track whether sound is on or off

  @override
  void initState() {
    super.initState();
    SoundManager.initialize(); // Initialize SoundManager
    SoundManager.playMusic(); // Play background music initially
  }

  void toggleSound() {
    setState(() {
      isSoundOn = !isSoundOn;
    });
    
    if (isSoundOn) {
      SoundManager.playMusic(); // Play music if sound is on
    } else {
      SoundManager.stopMusic(); // Stop music if sound is off
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image covering the full screen
          Image.asset(
            'assets/background.png',
            fit: BoxFit.cover, // Ensures the image fills the screen
          ),
          // Content on top of the background
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title with better visibility
                  Text(
                    'Jungle Safari',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.7),
                          offset: Offset(3.0, 3.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),

                  // Start Game Button with new color
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectZoneScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                      textStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      backgroundColor: Color(0xFF1DB954), // Vibrant Green
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text('Start Learning'),
                  ),

                  SizedBox(height: 20),

                  // Mini Games Button with new color
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MiniGamesScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.videogame_asset, size: 28),
                    label: Text(
                      'Mini Games 🎮',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                      backgroundColor: Color(0xFF4A90E2), // Cool Blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Puzzle Game Button with new color
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PuzzleGameScreen(zone: "Animals"),
                        ),
                      );
                    },
                    icon: Icon(Icons.extension, size: 28),
                    label: Text(
                      'Puzzle Game 🧩',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                      backgroundColor: Color(0xFFF5A623), // Warm Orange
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Sound Control Button with new color
                  ElevatedButton.icon(
                    onPressed: toggleSound,
                    icon: Icon(
                      isSoundOn ? Icons.volume_up : Icons.volume_off,
                      size: 28,
                    ),
                    label: Text(
                      isSoundOn ? 'Sound On' : 'Sound Off',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                      backgroundColor: Color(0xFF9B59B6), // Purple
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
