import 'package:flutter/material.dart';
import '../../../data/models/user.dart';

class UserStatsWidget extends StatefulWidget {
  final UserStats stats;

  const UserStatsWidget({
    Key? key,
    required this.stats,
  }) : super(key: key);

  @override
  State<UserStatsWidget> createState() => _UserStatsWidgetState();
}

class _UserStatsWidgetState extends State<UserStatsWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _animations = List.generate(4, (index) {
      return Tween<double>(
        begin: 0,
        end: 1,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.15,
            (index * 0.15) + 0.4,
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Movie Stats',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: _animations[0],
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animations[0].value,
                      child: _StatCard(
                        icon: Icons.movie_rounded,
                        title: 'Movies Watched',
                        value: widget.stats.moviesWatched.toString(),
                        color: const Color(0xFF667EEA),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AnimatedBuilder(
                  animation: _animations[1],
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animations[1].value,
                      child: _StatCard(
                        icon: Icons.bookmark_rounded,
                        title: 'Watchlist',
                        value: widget.stats.watchlistItems.toString(),
                        color: const Color(0xFFFF6B6B),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: _animations[2],
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animations[2].value,
                      child: _StatCard(
                        icon: Icons.rate_review_rounded,
                        title: 'Reviews',
                        value: widget.stats.reviewsWritten.toString(),
                        color: const Color(0xFF4ECDC4),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AnimatedBuilder(
                  animation: _animations[3],
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animations[3].value,
                      child: _StatCard(
                        icon: Icons.access_time_rounded,
                        title: 'Watch Time',
                        value: _formatWatchTime(widget.stats.totalWatchTime),
                        color: const Color(0xFFFFBA08),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Average Rating
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Average Rating',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${widget.stats.averageRating.toStringAsFixed(1)} / 5.0',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatWatchTime(int minutes) {
    final hours = minutes ~/ 60;
    if (hours >= 24) {
      final days = hours ~/ 24;
      return '${days}d';
    }
    return '${hours}h';
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
