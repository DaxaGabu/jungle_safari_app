import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'utils/sound_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SoundManager.initialize();
  runApp(JungleSafariApp());
}

class JungleSafariApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jungle Safari',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'JungleFont',
      ),
      home: SplashScreen(),
    );
  }
}
