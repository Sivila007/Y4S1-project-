import 'package:flutter/material.dart';
import '../../../data/datasources/mock_notifications.dart';
import '../../../data/models/notification.dart';
import '../widgets/notification_item.dart';
import '../widgets/notification_empty_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  List<AppNotification> _notifications = mockNotifications;
  bool _showUnreadOnly = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<AppNotification> get _filteredNotifications {
    if (_showUnreadOnly) {
      return _notifications.where((notif) => !notif.isRead).toList();
    }
    return _notifications;
  }

  int get _unreadCount {
    return _notifications.where((notif) => !notif.isRead).length;
  }

  void _markAsRead(String notificationId) {
    setState(() {
      final index =
          _notifications.indexWhere((notif) => notif.id == notificationId);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(isRead: true);
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      _notifications =
          _notifications.map((notif) => notif.copyWith(isRead: true)).toList();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('All notifications marked as read'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _deleteNotification(String notificationId) {
    setState(() {
      _notifications.removeWhere((notif) => notif.id == notificationId);
    });
  }

  void _clearAllNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text(
            'Are you sure you want to clear all notifications? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _notifications.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('All notifications cleared'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredNotifications = _filteredNotifications;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // Filter button
          IconButton(
            onPressed: () {
              setState(() {
                _showUnreadOnly = !_showUnreadOnly;
              });
            },
            icon: Icon(
              _showUnreadOnly ? Icons.filter_alt : Icons.filter_alt_outlined,
            ),
            tooltip: _showUnreadOnly ? 'Show All' : 'Show Unread Only',
          ),
          // More options
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'mark_all_read':
                  if (_unreadCount > 0) _markAllAsRead();
                  break;
                case 'clear_all':
                  if (_notifications.isNotEmpty) _clearAllNotifications();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'mark_all_read',
                enabled: _unreadCount > 0,
                child: Row(
                  children: [
                    const Icon(Icons.done_all_rounded),
                    const SizedBox(width: 12),
                    Text('Mark All Read ($_unreadCount)'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'clear_all',
                enabled: _notifications.isNotEmpty,
                child: const Row(
                  children: [
                    Icon(Icons.clear_all_rounded),
                    SizedBox(width: 12),
                    Text('Clear All'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: filteredNotifications.isEmpty
            ? NotificationEmptyState(
                showUnreadOnly: _showUnreadOnly,
                onShowAll: () => setState(() => _showUnreadOnly = false),
              )
            : Column(
                children: [
                  // Header info
                  if (!_showUnreadOnly && _unreadCount > 0)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle_notifications_rounded,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '$_unreadCount unread notification${_unreadCount == 1 ? '' : 's'}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Notifications list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filteredNotifications.length,
                      itemBuilder: (context, index) {
                        final notification = filteredNotifications[index];
                        return TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 300 + (index * 50)),
                          tween: Tween(begin: 0, end: 1),
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 50 * (1 - value)),
                              child: Opacity(
                                opacity: value,
                                child: child,
                              ),
                            );
                          },
                          child: NotificationItem(
                            notification: notification,
                            onTap: () => _markAsRead(notification.id),
                            onDelete: () =>
                                _deleteNotification(notification.id),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
