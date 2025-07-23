import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerService with ChangeNotifier {
  late VideoPlayerController controller;
  double playbackSpeed = 1.0;
  bool isInitialized = false;
  bool isBuffering = false;
  bool hasError = false;
  String? errorMessage;

  Future<void> initialize(String url) async {
    try {
      controller = VideoPlayerController.networkUrl(Uri.parse(url));
      await controller.initialize();
      isInitialized = true;
      controller.addListener(_onControllerUpdate);
      notifyListeners();
    } catch (e) {
      hasError = true;
      errorMessage = 'Failed to load video.';
      notifyListeners();
    }
  }

  void _onControllerUpdate() {
    isBuffering = controller.value.isBuffering;
    notifyListeners();
  }

  void setSpeed(double speed) {
    playbackSpeed = speed;
    controller.setPlaybackSpeed(speed);
    notifyListeners();
  }

  void play() {
    controller.play();
    notifyListeners();
  }

  void pause() {
    controller.pause();
    notifyListeners();
  }

  void seekTo(Duration position) {
    controller.seekTo(position);
    notifyListeners();
  }

  void dispose() {
    controller.removeListener(_onControllerUpdate);
    controller.dispose();
    super.dispose();
  }
}
