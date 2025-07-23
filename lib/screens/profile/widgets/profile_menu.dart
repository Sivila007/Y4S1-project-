import 'package:flutter/material.dart';
import '../../notification/view/notification_screen.dart';
import 'package:go_router/go_router.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(20),
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
        children: [
          _buildMenuSection(
            context,
            title: 'My Library',
            items: [
              _MenuItem(
                icon: Icons.favorite_rounded,
                title: 'Favorites',
                subtitle: 'Your favorite movies',
                onTap: () => _showComingSoon(context),
              ),
              _MenuItem(
                icon: Icons.bookmark_rounded,
                title: 'Watchlist',
                subtitle: 'Movies to watch later',
                onTap: () => _showComingSoon(context),
              ),
              _MenuItem(
                icon: Icons.history_rounded,
                title: 'Watch History',
                subtitle: 'Recently watched',
                onTap: () => _showComingSoon(context),
              ),
              _MenuItem(
                icon: Icons.download_rounded,
                title: 'Downloads',
                subtitle: 'Offline content',
                onTap: () => _showComingSoon(context),
              ),
            ],
          ),
          const Divider(height: 1),
          _buildMenuSection(
            context,
            title: 'Account',
            items: [
              _MenuItem(
                icon: Icons.person_rounded,
                title: 'Edit Profile',
                subtitle: 'Update your information',
                onTap: () => _showComingSoon(context),
              ),
              _MenuItem(
                icon: Icons.notifications_rounded,
                title: 'Notifications',
                subtitle: 'Manage notifications',
                onTap: () => _navigateToNotifications(context),
              ),
              _MenuItem(
                icon: Icons.security_rounded,
                title: 'Privacy & Security',
                subtitle: 'Account security settings',
                onTap: () => _showComingSoon(context),
              ),
              _MenuItem(
                icon: Icons.payment_rounded,
                title: 'Subscription',
                subtitle: 'Manage your plan',
                onTap: () => _showComingSoon(context),
              ),
              _MenuItem(
                icon: Icons.settings_rounded,
                title: 'Settings',
                subtitle: 'App preferences and more',
                onTap: () => _navigateToSettings(context),
              ),
            ],
          ),
          const Divider(height: 1),
          _buildMenuSection(
            context,
            title: 'Support',
            items: [
              _MenuItem(
                icon: Icons.help_rounded,
                title: 'Help Center',
                subtitle: 'Get help and support',
                onTap: () => _showComingSoon(context),
              ),
              _MenuItem(
                icon: Icons.feedback_rounded,
                title: 'Send Feedback',
                subtitle: 'Help us improve',
                onTap: () => _showComingSoon(context),
              ),
              _MenuItem(
                icon: Icons.info_rounded,
                title: 'About',
                subtitle: 'App version and info',
                onTap: () => _showAbout(context),
              ),
            ],
          ),
          const Divider(height: 1),
          _buildMenuSection(
            context,
            items: [
              _MenuItem(
                icon: Icons.logout_rounded,
                title: 'Sign Out',
                subtitle: 'Sign out of your account',
                textColor: Colors.red,
                onTap: () => _showSignOutDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(
    BuildContext context, {
    String? title,
    required List<_MenuItem> items,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
        ...items.map((item) => _buildMenuItem(context, item)),
        if (title != null) const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, _MenuItem item) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (item.textColor ?? theme.colorScheme.primary)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  item.icon,
                  color: item.textColor ?? theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: item.textColor,
                      ),
                    ),
                    if (item.subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurface.withOpacity(0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Coming Soon!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _navigateToNotifications(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NotificationScreen(),
      ),
    );
  }

  void _navigateToSettings(BuildContext context) {
    context.push('/setting');
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About CamMovie'),
        content: const Text(
          'CamMovie v1.0.0\n\nA modern movie streaming app built with Flutter.\n\n© 2024 CamMovie. All rights reserved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement sign out logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signed out successfully')),
              );
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? textColor;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.textColor,
    required this.onTap,
  });
}
