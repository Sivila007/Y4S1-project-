import '../models/notification.dart';

final List<AppNotification> mockNotifications = [
  AppNotification(
    id: 'notif_001',
    title: 'New Movie Recommendation',
    message:
        'Based on your viewing history, we think you\'ll love "Inception" - a mind-bending sci-fi thriller.',
    type: NotificationType.movieRecommendation,
    createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
    isRead: false,
    imageUrl: 'https://image.tmdb.org/t/p/w500/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg',
    actionData: {'movieId': 'movie_001'},
  ),
  AppNotification(
    id: 'notif_002',
    title: 'New Release Alert',
    message:
        'Dune: Part Two is now available to stream! Don\'t miss the epic continuation.',
    type: NotificationType.newRelease,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    isRead: false,
    imageUrl: 'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
    actionData: {'movieId': 'movie_002'},
  ),
  AppNotification(
    id: 'notif_003',
    title: 'Watchlist Update',
    message:
        'Avatar: The Way of Water from your watchlist is now available in 4K.',
    type: NotificationType.watchlistUpdate,
    createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    isRead: true,
    imageUrl: 'https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg',
    actionData: {'movieId': 'movie_003'},
  ),
  AppNotification(
    id: 'notif_004',
    title: 'Limited Time Offer',
    message:
        'Get 30% off your next month\'s subscription! Offer expires in 24 hours.',
    type: NotificationType.promotion,
    createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    isRead: false,
    actionData: {'promoCode': 'SAVE30'},
  ),
  AppNotification(
    id: 'notif_005',
    title: 'Watch Reminder',
    message:
        'Don\'t forget to continue watching "The Batman" - you left off at 45 minutes.',
    type: NotificationType.reminder,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    isRead: true,
    imageUrl: 'https://image.tmdb.org/t/p/w500/b0PlSFdDwbyK0cf5RxwDpaOJQvQ.jpg',
    actionData: {'movieId': 'movie_004', 'timestamp': 2700},
  ),
  AppNotification(
    id: 'notif_006',
    title: 'App Update Available',
    message: 'Version 2.1.0 is now available with new features and bug fixes.',
    type: NotificationType.systemUpdate,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    isRead: true,
  ),
  AppNotification(
    id: 'notif_007',
    title: 'Weekly Picks',
    message:
        'Check out our editor\'s picks for this week featuring the best thriller movies.',
    type: NotificationType.movieRecommendation,
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    isRead: true,
  ),
  AppNotification(
    id: 'notif_008',
    title: 'Download Complete',
    message:
        'Top Gun: Maverick has been downloaded and is ready for offline viewing.',
    type: NotificationType.systemUpdate,
    createdAt: DateTime.now().subtract(const Duration(days: 4)),
    isRead: true,
    imageUrl: 'https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg',
    actionData: {'movieId': 'movie_005'},
  ),
];
