import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/constants/app.dart';
import 'package:noon_reader/services/setting.dart';
import 'package:noon_reader/services/storage.dart';
import 'package:noon_reader/widgets/loading_indicator.dart';

import 'pages/root/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      overrides: [],
      child: NoonReader(),
    ),
  );
}

class NoonReader extends HookConsumerWidget {
  const NoonReader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingService = ref.watch(settingServiceProvider);
    final storageService = ref.read(storageServiceProvider);
    final textTheme = settingService.getTextTheme(context);

    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData.light().copyWith(textTheme: textTheme),
      darkTheme: ThemeData.dark().copyWith(textTheme: textTheme),
      themeMode:
          settingService.setting.darkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: storageService.init(),
        builder: (context, snapshot) {
          late Widget widget;
          if (snapshot.connectionState == ConnectionState.done) {
            widget = const RootPage();
          } else {
            widget = const LoadingIndicator();
          }
          return widget;
        },
      ),
    );
  }
}
