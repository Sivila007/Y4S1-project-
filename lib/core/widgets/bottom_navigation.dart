import 'package:camovies/core/constants/route_contants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final selectedColor =
        isDark ? theme.colorScheme.primary : const Color(0xFF6750A4);
    final unselectedColor =
        isDark ? theme.colorScheme.onSurface.withOpacity(0.7) : Colors.black54;
    final indicatorColor =
        isDark ? theme.colorScheme.primaryContainer : const Color(0xFFEEE6FF);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return TextStyle(
                color: selectedColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              );
            }
            return TextStyle(
              color: unselectedColor,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            );
          }),
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return IconThemeData(
                color: selectedColor,
                size: 24,
              );
            }
            return IconThemeData(
              color: unselectedColor,
              size: 24,
            );
          }),
        ),
        child: NavigationBar(
          height: 65,
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                context.go(RouteConstants.home);
              case 1:
                context.go('/search');
              case 2:
                context.go('/watchlist');
              case 3:
                context.go(RouteConstants.profile);
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          indicatorShape: const CircleBorder(),
          indicatorColor: indicatorColor,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              selectedIcon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark_outline_rounded),
              selectedIcon: Icon(Icons.bookmark_rounded),
              label: 'Watchlist',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
