enum NotificationType {
  movieRecommendation,
  newRelease,
  watchlistUpdate,
  systemUpdate,
  promotion,
  reminder,
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime createdAt;
  final bool isRead;
  final String? imageUrl;
  final Map<String, dynamic>? actionData;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.imageUrl,
    this.actionData,
  });

  AppNotification copyWith({
    String? id,
    String? title,
    String? message,
    NotificationType? type,
    DateTime? createdAt,
    bool? isRead,
    String? imageUrl,
    Map<String, dynamic>? actionData,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      imageUrl: imageUrl ?? this.imageUrl,
      actionData: actionData ?? this.actionData,
    );
  }

  // Helper methods
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  String get typeDisplayName {
    switch (type) {
      case NotificationType.movieRecommendation:
        return 'Movie Recommendation';
      case NotificationType.newRelease:
        return 'New Release';
      case NotificationType.watchlistUpdate:
        return 'Watchlist Update';
      case NotificationType.systemUpdate:
        return 'System Update';
      case NotificationType.promotion:
        return 'Promotion';
      case NotificationType.reminder:
        return 'Reminder';
    }
  }
}
