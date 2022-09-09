import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/constants/app.dart';
import 'package:noon_reader/services/setting.dart';
import 'package:noon_reader/services/storage.dart';
import 'package:noon_reader/widgets/loading_indicator.dart';

import 'generated/codegen_loader.g.dart';
import 'pages/root/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      saveLocale: false,
      supportedLocales: const [Locale('en'), Locale('ko')],
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      path: 'translations',
      child: const ProviderScope(
        overrides: [],
        child: NoonReader(),
      ),
    ),
  );
}

class NoonReader extends HookConsumerWidget {
  const NoonReader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storageService = ref.read(storageServiceProvider);

    return FutureBuilder(
      future: storageService.init(),
      builder: (context, snapshot) {
        late Widget widget;
        if (snapshot.connectionState == ConnectionState.done) {
          widget = HookConsumer(
            child: const RootPage(),
            builder: (context, ref, home) {
              final settingService = ref.watch(settingServiceProvider);
              final textTheme = settingService.getTextTheme(context);

              final initialLanguageCode = context.locale.languageCode;
              useEffect(() {
                // Save locale
                final setting = settingService.setting.copyWith(
                  languageCode: settingService.setting.languageCode ??
                      initialLanguageCode,
                );
                settingService.update(setting);
                return null;
              }, [initialLanguageCode]);

              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: AppConstants.appName,
                theme: ThemeData.light().copyWith(textTheme: textTheme),
                darkTheme: ThemeData.dark().copyWith(textTheme: textTheme),
                themeMode:
                    settingService.darkMode ? ThemeMode.dark : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: home,
              );
            },
          );
        } else {
          widget = const LoadingIndicator();
        }
        return widget;
      },
    );
  }
}
