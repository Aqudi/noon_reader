import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/constants/app.dart';

import 'package:noon_reader/models/setting.dart';

final settingServiceProvider = ChangeNotifierProvider<SettingService>(
  (ref) => SettingService(),
);

class SettingService extends ChangeNotifier {
  late Setting _setting;

  Setting get setting => _setting;

  SettingService() {
    _setting = Setting(
      darkMode: true,
      language: AppConstants.defaultLanguage,
      fontFamily: AppConstants.defaultFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontColor: Colors.white70,
      backgroundColor: Colors.black,
      padding: const EdgeInsets.all(12),
    );
  }

  void load() {}

  void update(Setting setting) {
    _setting = setting;
    notifyListeners();
  }

  TextTheme getTextTheme(BuildContext context) {
    final typograpy =
        Typography.material2018(platform: Theme.of(context).platform);
    return (setting.darkMode ? typograpy.white : typograpy.black).copyWith(
      bodyText1: GoogleFonts.getFont(
        setting.fontFamily,
        textStyle: Theme.of(context).textTheme.bodyText2,
        fontSize: setting.fontSize,
        fontWeight: setting.fontWeight,
        color: setting.fontColor,
      ),
    );
  }
}
