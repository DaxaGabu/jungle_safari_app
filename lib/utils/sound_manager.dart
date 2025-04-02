import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isPlaying = false;

  static void initialize() {
    _player.setReleaseMode(ReleaseMode.loop);
  }

  static void playMusic() async {
    if (!_isPlaying) {
      await _player.play(AssetSource('sounds/background_music.mp3'));
      _isPlaying = true;
    }
  }

  static void stopMusic() async {
    if (_isPlaying) {
      await _player.stop();
      _isPlaying = false;
    }
  }

}