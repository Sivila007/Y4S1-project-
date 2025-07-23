import 'package:camovies/core/blocs/appearance/appearance_bloc_bloc.dart';
import 'package:camovies/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:camovies/config/l10n/l10n.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static const String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(context.l10n.settingScreenTitle),
          ),
          const SliverToBoxAdapter(
            child: _SettingsContent(),
          ),
        ],
      ),
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AppearanceBloc, AppearanceState>(
      builder: (context, state) {
        if (state.status == AppearanceStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              theme,
              title: 'Preferences',
              children: [
                _buildSettingTile(
                  context,
                  leading: const Icon(Icons.language),
                  title: 'Language',
                  subtitle: state.language?.languageName,
                  onTap: () => context.push(
                    '${SettingScreen.routeName}/language',
                  ),
                ),
                _buildSettingTile(
                  context,
                  leading: Icon(
                    state.themeMode == AppConstants.themeModeDark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                  title: 'Theme',
                  subtitle: state.themeMode == AppConstants.themeModeDark
                      ? 'Dark Mode'
                      : 'Light Mode',
                  trailing: Switch(
                    value: state.themeMode == AppConstants.themeModeDark,
                    onChanged: (value) {
                      context.read<AppearanceBloc>().add(
                            ChangeThemeMode(
                              state.themeMode == AppConstants.themeModeDark
                                  ? AppConstants.themeModeLight
                                  : AppConstants.themeModeDark,
                            ),
                          );
                    },
                  ),
                ),
              ],
            ),
            _buildSection(
              theme,
              title: 'Notifications',
              children: [
                _buildSettingTile(
                  context,
                  leading: const Icon(Icons.notifications_active),
                  title: 'Push Notifications',
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                _buildSettingTile(
                  context,
                  leading: const Icon(Icons.email),
                  title: 'Email Notifications',
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            _buildSection(
              theme,
              title: 'About',
              children: [
                _buildSettingTile(
                  context,
                  leading: const Icon(Icons.info),
                  title: 'Version',
                  subtitle: '1.0.0',
                ),
                _buildSettingTile(
                  context,
                  leading: const Icon(Icons.privacy_tip),
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
                _buildSettingTile(
                  context,
                  leading: const Icon(Icons.description),
                  title: 'Terms of Service',
                  onTap: () {},
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildSection(
    ThemeData theme, {
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required Widget leading,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        child: leading,
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing:
          trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }
}
