import 'package:flutter/material.dart';
import 'package:camovies/config/l10n/l10n.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const String routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.authScreenTitle),
      ),
      body: Center(
        child: Text('Body of ${context.l10n.authScreenTitle}'),
      ),
    );
  }
}