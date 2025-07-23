// *******************************************************
// **************** Sopheap Om ****************
// **************** www.sopheap.dev ****************
// **************** 2025-07-05 ****************
// *******************************************************

import 'dart:io';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Please provide a module name');
    exit(1);
  }

  final moduleName = args[0].toLowerCase();
  final moduleNameCapitalized =
      moduleName[0].toUpperCase() + moduleName.substring(1);

  // Create module directory structure
  final directories = [
    'lib/screens/$moduleName/bloc',
    'lib/screens/$moduleName/view',
    'lib/screens/$moduleName/widgets',
  ];

  for (final dir in directories) {
    await Directory(dir).create(recursive: true);
    print('Created $dir');
  }

  // Add translation keys to English ARB file
  final arbFile = File('lib/config/l10n/arb/app_en.arb');
  if (await arbFile.exists()) {
    final content = await arbFile.readAsString();
    final contentWithoutLastBrace = content.substring(
      0,
      content.lastIndexOf('}'),
    );

    final newTranslations = '''$contentWithoutLastBrace,
  "${moduleName}ScreenTitle": "${moduleNameCapitalized}",
  "@${moduleName}ScreenTitle": {
    "description": "Title for the ${moduleNameCapitalized} screen"
  }
}''';

    await arbFile.writeAsString(newTranslations);
    print('Added translations to app_en.arb');

    // Also update Khmer ARB file
    final kmArbFile = File('lib/config/l10n/arb/app_km.arb');
    if (await kmArbFile.exists()) {
      final kmContent = await kmArbFile.readAsString();
      final kmContentWithoutLastBrace = kmContent.substring(
        0,
        kmContent.lastIndexOf('}'),
      );

      final kmNewTranslations = '''$kmContentWithoutLastBrace,
  "${moduleName}ScreenTitle": "${moduleNameCapitalized}"
}''';

      await kmArbFile.writeAsString(kmNewTranslations);
      print('Added translations to app_km.arb');
    }
  }

  // Create view file with l10n support
  await _createFile(
    'lib/screens/$moduleName/view/${moduleName}_screen.dart',
    '''
import 'package:flutter/material.dart';
import 'package:flutter_project_template/config/l10n/l10n.dart';

class ${moduleNameCapitalized}Screen extends StatelessWidget {
  const ${moduleNameCapitalized}Screen({super.key});

  static const String routeName = '/${moduleName}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.${moduleName}ScreenTitle),
      ),
      body: Center(
        child: Text('Body of \${context.l10n.${moduleName}ScreenTitle}'),
      ),
    );
  }
}
''',
  );

  print('Module $moduleNameCapitalized created successfully!');
  print('\nNext steps:');
  print('1. Add your screen to the app routes');
  print('2. Implement your screen logic');
  print('3. Add necessary widgets in the widgets folder');
  print('4. Add state management in the bloc folder if needed');
  print('5. Run "flutter gen-l10n" to update localization files');
  print('6. Add translations for other languages if needed');
}

Future<void> _createFile(String path, String content) async {
  final file = File(path);
  await file.create(recursive: true);
  await file.writeAsString(content);
  print('Created $path');
}
