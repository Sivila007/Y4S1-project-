class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? bio;
  final DateTime joinDate;
  final UserStats stats;
  final UserPreferences preferences;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.bio,
    required this.joinDate,
    required this.stats,
    required this.preferences,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? bio,
    DateTime? joinDate,
    UserStats? stats,
    UserPreferences? preferences,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      joinDate: joinDate ?? this.joinDate,
      stats: stats ?? this.stats,
      preferences: preferences ?? this.preferences,
    );
  }
}

class UserStats {
  final int moviesWatched;
  final int watchlistItems;
  final int reviewsWritten;
  final double averageRating;
  final int totalWatchTime; // in minutes

  const UserStats({
    required this.moviesWatched,
    required this.watchlistItems,
    required this.reviewsWritten,
    required this.averageRating,
    required this.totalWatchTime,
  });

  UserStats copyWith({
    int? moviesWatched,
    int? watchlistItems,
    int? reviewsWritten,
    double? averageRating,
    int? totalWatchTime,
  }) {
    return UserStats(
      moviesWatched: moviesWatched ?? this.moviesWatched,
      watchlistItems: watchlistItems ?? this.watchlistItems,
      reviewsWritten: reviewsWritten ?? this.reviewsWritten,
      averageRating: averageRating ?? this.averageRating,
      totalWatchTime: totalWatchTime ?? this.totalWatchTime,
    );
  }
}

class UserPreferences {
  final bool notificationsEnabled;
  final bool autoPlayTrailers;
  final String preferredLanguage;
  final String preferredQuality;

  const UserPreferences({
    required this.notificationsEnabled,
    required this.autoPlayTrailers,
    required this.preferredLanguage,
    required this.preferredQuality,
  });

  UserPreferences copyWith({
    bool? notificationsEnabled,
    bool? autoPlayTrailers,
    String? preferredLanguage,
    String? preferredQuality,
  }) {
    return UserPreferences(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      autoPlayTrailers: autoPlayTrailers ?? this.autoPlayTrailers,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      preferredQuality: preferredQuality ?? this.preferredQuality,
    );
  }
}
