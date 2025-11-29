import 'package:audioplayers/audioplayers.dart';

class MainGameMusicService {
  static final MainGameMusicService _instance = MainGameMusicService._internal();
  factory MainGameMusicService() => _instance;
  MainGameMusicService._internal();

  final AudioPlayer _bgmPlayer = AudioPlayer();
  bool _isInitialized = false;

  final List<String> tracks = [
    'audio/mainGameMusic.wav',
  ];
  int currentTrack = 0;

  double volume = 0.5;

  Future<void> playBgm() async {
    if (!_isInitialized) {
      await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
      _isInitialized = true;
    }
    await _bgmPlayer.setVolume(volume);
    await _bgmPlayer.play(AssetSource(tracks[currentTrack]));
  }

  Future<void> stopBgm() async => await _bgmPlayer.stop();
  Future<void> pauseBgm() async => await _bgmPlayer.pause();

  Future<void> nextTrack() async {
    currentTrack = (currentTrack + 1) % tracks.length;
    await playBgm();
  }
}
