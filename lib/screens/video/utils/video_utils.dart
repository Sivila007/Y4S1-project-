String formatDuration(Duration d) {
  final hours = d.inHours;
  final min = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final sec = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  if (hours > 0) {
    return '$hours:$min:$sec';
  } else {
    return '$min:$sec';
  }
}
