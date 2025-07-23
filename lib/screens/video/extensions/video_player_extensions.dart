import 'package:video_player/video_player.dart';

extension VideoPlayerControllerX on VideoPlayerController {
  bool get isEnded =>
      value.position >= value.duration && value.duration != Duration.zero;
  bool get isPlaying => value.isPlaying;
  bool get isBuffering => value.isBuffering;
  bool get hasError => value.hasError;
}
