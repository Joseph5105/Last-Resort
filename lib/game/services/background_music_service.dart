import 'package:audioplayers/audioplayers.dart';

class BackgroundMusicService {
  static final BackgroundMusicService _instance = BackgroundMusicService._internal();
  factory BackgroundMusicService() => _instance;
  BackgroundMusicService._internal();

  final AudioPlayer _bgmPlayer = AudioPlayer();
  bool _isInitialized = false;

  final List<String> tracks = [
    'audio/tradingScreen1.wav',
    'audio/tradingScreen2.wav',
  ];
  int currentTrack = 0;

  Future<void> playBgm() async {
    if (!_isInitialized) {
      await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
      _isInitialized = true;
    }
    await _bgmPlayer.play(AssetSource(tracks[currentTrack]));
  }

  Future<void> stopBgm() async => await _bgmPlayer.stop();
  Future<void> pauseBgm() async => await _bgmPlayer.pause();

  Future<void> nextTrack() async {
    currentTrack = (currentTrack + 1) % tracks.length;
    await playBgm();
  }
}
