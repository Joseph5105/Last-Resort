import 'package:audioplayers/audioplayers.dart';

class MarketMusicService {
  static final MarketMusicService _instance = MarketMusicService._internal();
  factory MarketMusicService() => _instance;
  MarketMusicService._internal();

  final AudioPlayer _bgmPlayer = AudioPlayer();
  bool _isInitialized = false;

  final List<String> tracks = [
    'audio/marketMusic.wav',
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
