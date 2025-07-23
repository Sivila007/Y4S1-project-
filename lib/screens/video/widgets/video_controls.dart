import 'package:flutter/material.dart';

class VideoControls extends StatelessWidget {
  final bool isPlaying;
  final bool isEnded;
  final bool isFullscreen;
  final Duration position;
  final Duration duration;
  final double playbackSpeed;
  final VoidCallback onPlayPause;
  final VoidCallback onReplay;
  final VoidCallback onSkipForward;
  final VoidCallback onSkipBackward;
  final VoidCallback onFullscreen;
  final ValueChanged<double> onSeek;
  final ValueChanged<double> onSpeed;

  const VideoControls({
    Key? key,
    required this.isPlaying,
    required this.isEnded,
    required this.isFullscreen,
    required this.position,
    required this.duration,
    required this.playbackSpeed,
    required this.onPlayPause,
    required this.onReplay,
    required this.onSkipForward,
    required this.onSkipBackward,
    required this.onFullscreen,
    required this.onSeek,
    required this.onSpeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isEnded)
          Center(
            child: IconButton(
              icon: const Icon(Icons.replay_rounded,
                  color: Colors.white, size: 48),
              onPressed: onReplay,
            ),
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.replay_10_rounded,
                    color: Colors.white, size: 32),
                onPressed: onSkipBackward,
              ),
              IconButton(
                icon: Icon(
                  isPlaying
                      ? Icons.pause_circle_filled_rounded
                      : Icons.play_circle_filled_rounded,
                  color: Colors.white,
                  size: 48,
                ),
                onPressed: onPlayPause,
              ),
              IconButton(
                icon: const Icon(Icons.forward_10_rounded,
                    color: Colors.white, size: 32),
                onPressed: onSkipForward,
              ),
              const SizedBox(width: 16),
              PopupMenuButton<double>(
                initialValue: playbackSpeed,
                onSelected: onSpeed,
                color: Colors.black87,
                itemBuilder: (context) => [
                  for (final s in [0.25, 0.5, 1.0, 1.5, 2.0])
                    PopupMenuItem(
                      value: s,
                      child: Text('${s}x',
                          style: const TextStyle(color: Colors.white)),
                    ),
                ],
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('${playbackSpeed}x',
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  isFullscreen
                      ? Icons.fullscreen_exit_rounded
                      : Icons.fullscreen_rounded,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: onFullscreen,
              ),
            ],
          ),
        // Seek bar and time
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(_format(position),
                  style: const TextStyle(color: Colors.white, fontSize: 13)),
              Expanded(
                child: Slider(
                  value: position.inSeconds.toDouble(),
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: onSeek,
                  activeColor: Colors.indigo,
                  inactiveColor: Colors.white24,
                ),
              ),
              Text(_format(duration),
                  style: const TextStyle(color: Colors.white, fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }

  String _format(Duration d) {
    final hours = d.inHours;
    final min = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final sec = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (hours > 0) {
      return '$hours:$min:$sec';
    } else {
      return '$min:$sec';
    }
  }
}
