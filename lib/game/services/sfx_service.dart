import 'package:audioplayers/audioplayers.dart';

class SfxService {
  static final SfxService _instance = SfxService._internal();
  factory SfxService() => _instance;
  SfxService._internal();

  Future<void> playSfx(String assetPath, {Duration? maxDuration, double? volume}) async {
    try {
      final player = AudioPlayer();
      await player.setReleaseMode(ReleaseMode.stop);

      // Set volume if specified (0.0 to 1.0)
      if (volume != null) {
        await player.setVolume(volume);
      }

      await player.play(AssetSource(assetPath));

      // Stop after maxDuration if provided
      if (maxDuration != null) {
        Future.delayed(maxDuration, () async {
          await player.stop();
          await player.dispose();
        });
      } else {
        player.onPlayerComplete.listen((_) => player.dispose());
      }
    } catch (e) {
      print("SFX error: $e");
    }
  }

  // Updated buy sound
  Future<void> sell() async => playSfx(
    'audio/cashRegister.wav',
    maxDuration: const Duration(seconds: 1),
    volume: 0.25,
  );

  // Other SFX remain the same
  Future<void> click() async => playSfx('audio/mouseClick.mp3');
  Future<void> paidDebt() async => playSfx('audio/paidDebt.wav');
  Future<void> buy() async => playSfx('audio/smallCoin2.wav');
  Future<void> error() async => playSfx('audio/accessDenied.wav');
  Future<void> login() async => playSfx('audio/computerStartup.mp3');
  Future<void> notification() async => playSfx('audio/notification.mp3');
  Future<void> gunshot() async => playSfx('audio/gunshot.wav');
  Future<void> sharkCharge() async => playSfx('audio/shark.wav');



}