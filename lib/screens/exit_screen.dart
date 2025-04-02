import 'package:flutter/material.dart';
import 'start_screen.dart'; // Import your StartScreen

class ExitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exit')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to exit?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Just close the exit screen
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the start screen when the user decides to exit
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartScreen()),
                    );
                  },
                  child: Text('Exit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
