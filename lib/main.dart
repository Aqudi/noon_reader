import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/constants/app.dart';
import 'package:noon_reader/services/setting.dart';
import 'package:noon_reader/services/storage.dart';

import 'pages/root/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // LocalStorageService 초기화
  final storageService = StorageService();
  await storageService.init();

  runApp(
    ProviderScope(
      overrides: [
        storageServiceProvider.overrideWithValue(storageService),
      ],
      child: NoonReader(),
    ),
  );
}

class NoonReader extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final settingService = useProvider(settingServiceProvider);
    final textTheme = settingService.getTextTheme(context);

    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData.light().copyWith(textTheme: textTheme),
      darkTheme: ThemeData.dark().copyWith(textTheme: textTheme),
      themeMode:
          settingService.setting.darkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        builder: (context, snapshot) => RootPage(),
      ),
    );
  }
}
