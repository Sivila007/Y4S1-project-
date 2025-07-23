import 'package:flutter/material.dart';

class CastList extends StatelessWidget {
  final List<String> cast;
  const CastList({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, // Increased height to prevent overflow
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final name = cast[index];
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(milliseconds: 400 + index * 100),
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 24 * (1 - value)),
                child: child,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.indigo.shade100,
                  child: Text(
                    name.isNotEmpty ? name[0] : '?',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 60,
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 11, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
