import 'package:flutter/material.dart';

class NotificationEmptyState extends StatelessWidget {
  final bool showUnreadOnly;
  final VoidCallback? onShowAll;

  const NotificationEmptyState({
    Key? key,
    required this.showUnreadOnly,
    this.onShowAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated icon
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              tween: Tween(begin: 0, end: 1),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 0.8 + (0.2 * value),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  showUnreadOnly
                      ? Icons.mark_email_read_rounded
                      : Icons.notifications_none_rounded,
                  size: 64,
                  color: theme.colorScheme.primary.withOpacity(0.7),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Title
            Text(
              showUnreadOnly ? 'All Caught Up!' : 'No Notifications',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Subtitle
            Text(
              showUnreadOnly
                  ? 'You\'ve read all your notifications.\nGreat job staying updated!'
                  : 'You don\'t have any notifications yet.\nWe\'ll notify you when something interesting happens.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Action button
            if (showUnreadOnly && onShowAll != null)
              ElevatedButton.icon(
                onPressed: onShowAll,
                icon: const Icon(Icons.visibility_rounded),
                label: const Text('Show All Notifications'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

            // Tips section
            if (!showUnreadOnly) ...[
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.tips_and_updates_rounded,
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Stay Updated',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enable notifications to get updates about:\n• New movie releases\n• Personalized recommendations\n• Watchlist updates',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
