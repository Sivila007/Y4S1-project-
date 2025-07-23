import 'package:camovies/core/constants/route_contants.dart';
import 'package:camovies/screens/home/view/home_screen.dart';
import 'package:camovies/screens/onboarding/view/onboarding_screen.dart';
import 'package:camovies/screens/profile/view/profile_screen.dart';
import 'package:camovies/screens/setting/view/language_screen.dart';
import 'package:camovies/screens/setting/view/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:camovies/core/widgets/shell_route.dart';
import 'package:camovies/screens/auth/view/auth_screen.dart';
import 'package:camovies/screens/splash/view/splash_screen.dart';
import 'package:camovies/screens/detail/view/movie_detail_screen.dart';
import 'package:camovies/screens/video/view/video_play_screen.dart';
import 'package:camovies/screens/search/view/search_screen.dart';
import 'package:camovies/screens/watchlist/view/watchlist_screen.dart';
import 'package:camovies/screens/notification/view/notification_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteConstants.splash,
  routes: [
    // Non-shell routes (outside bottom navigation)
    GoRoute(
      path: RouteConstants.splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteConstants.auth,
      name: 'auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: RouteConstants.onboarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: RouteConstants.movieDetail,
      name: 'movieDetail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return MovieDetailScreen(movieId: id);
      },
      routes: [
        GoRoute(
          path: 'play',
          name: 'moviePlay',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return VideoPlayScreen(movieId: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/notifications',
      name: 'notifications',
      builder: (context, state) => const NotificationScreen(),
    ),
    // Shell route (with bottom navigation)
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        // Determine current index based on location
        int index = switch (state.matchedLocation) {
          RouteConstants.home => 0,
          '/search' => 1,
          '/watchlist' => 2,
          RouteConstants.profile => 3,
          _ => 0,
        };

        return AppShell(
          currentIndex: index,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: RouteConstants.home,
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/search',
          name: 'search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: '/watchlist',
          name: 'watchlist',
          builder: (context, state) => const WatchlistScreen(),
        ),
        GoRoute(
          path: RouteConstants.profile,
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    // Standalone setting screen (accessible from profile)
    GoRoute(
      path: RouteConstants.setting,
      name: 'setting',
      builder: (context, state) => const SettingScreen(),
      routes: [
        GoRoute(
          path: RouteConstants.language,
          name: 'language',
          builder: (context, state) => LanguageScreen(
            key: state.pageKey,
          ),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: 27${state.error}27'),
    ),
  ),
);
