import 'package:flutter/material.dart';

class VideoProgressBar extends StatelessWidget {
  final double percent;
  const VideoProgressBar({Key? key, required this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: LinearProgressIndicator(
        value: percent,
        minHeight: 3,
        backgroundColor: Colors.white10,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
      ),
    );
  }
}
