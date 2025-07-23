import 'package:camovies/core/blocs/appearance/appearance_bloc_bloc.dart';
import 'package:camovies/core/enum/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camovies/config/l10n/l10n.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({
    super.key,
  });

  static const String routeName = 'language';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingScreenTitle),
      ),
      body: BlocConsumer<AppearanceBloc, AppearanceState>(
        listener: (context, state) {
          if (state.status == AppearanceStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.status.toString()),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == AppearanceStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: AppLanguage.values.length,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              final language = AppLanguage.values[index];
              final isSelected = state.language == language;

              return Material(
                color: Colors.transparent,
                child: ListTile(
                  onTap: () {
                    context.read<AppearanceBloc>().add(
                          ChangeLanguage(language),
                        );
                  },
                  leading: CircleAvatar(
                    backgroundColor: isSelected
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Text(
                      language.code.toUpperCase(),
                      style: TextStyle(
                        color: isSelected
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  title: Text(language.languageName),
                  subtitle: Text(language.countryCode),
                  trailing: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: isSelected
                        ? Icon(
                            Icons.check_circle,
                            key: const ValueKey('selected'),
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : const SizedBox(
                            key: ValueKey('not_selected'),
                            width: 24,
                          ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
