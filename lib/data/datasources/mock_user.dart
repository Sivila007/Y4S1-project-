import '../models/user.dart';

final User mockUser = User(
  id: 'user_001',
  name: 'Meng Mich',
  email: 'mengmich@gmail.com',
  avatarUrl:
      'https://www.thiings.co/_next/image?url=https%3A%2F%2Flftz25oez4aqbxpq.public.blob.vercel-storage.com%2Fimage-qT0qCttwF0fSi4qeWZj6vo2Za76keg.png&w=320&q=75',
  bio:
      'Movie enthusiast and aspiring filmmaker. Love exploring different genres and discovering hidden gems.',
  joinDate: DateTime(2023, 6, 15),
  stats: const UserStats(
    moviesWatched: 247,
    watchlistItems: 32,
    reviewsWritten: 18,
    averageRating: 4.2,
    totalWatchTime: 18540, // ~309 hours
  ),
  preferences: const UserPreferences(
    notificationsEnabled: true,
    autoPlayTrailers: false,
    preferredLanguage: 'English',
    preferredQuality: '1080p',
  ),
);
