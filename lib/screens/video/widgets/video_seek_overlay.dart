import 'package:flutter/material.dart';

class VideoSeekOverlay extends StatelessWidget {
  final bool show;
  final bool forward;
  final int seconds;
  const VideoSeekOverlay(
      {Key? key, required this.show, required this.forward, this.seconds = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();
    return Center(
      child: AnimatedScale(
        scale: show ? 1.0 : 0.8,
        duration: const Duration(milliseconds: 200),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black87.withOpacity(0.7),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                  forward
                      ? Icons.fast_forward_rounded
                      : Icons.fast_rewind_rounded,
                  color: Colors.white,
                  size: 32),
              const SizedBox(width: 8),
              Text(
                (forward ? '+' : '-') + '$seconds s',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
