import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/constants/app.dart';

import 'package:noon_reader/models/setting.dart';
import 'package:noon_reader/services/storage.dart';

final settingServiceProvider = ChangeNotifierProvider<SettingService>((ref) {
  final storageService = ref.read(storageServiceProvider);
  return SettingService(storageService);
});

class SettingService extends ChangeNotifier {
  final StorageService _storageService;
  final storageKey = 'setting';

  late Setting _setting;
  final Setting _defaultSetting = Setting(
    darkMode: true,
    fontFamily: AppConstants.defaultFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontColor: Colors.white70,
    backgroundColor: Colors.black,
    padding: const EdgeInsets.all(12),
  );

  SettingService(this._storageService) {
    _setting = load();
  }

  Setting get setting => _setting;
  bool get isDefaultSetting => _setting == _defaultSetting;
  bool get darkMode => setting.darkMode;

  Setting load() {
    final settingJson = _storageService.get(BoxName.setting, storageKey);
    return settingJson != null
        ? Setting.fromJson(settingJson)
        : _defaultSetting;
  }

  Future<void> save() async {
    await _storageService.put(BoxName.setting, storageKey, setting.toJson());
    notifyListeners();
  }

  void update(Setting setting) {
    _setting = setting;
    save();
  }

  Future<void> updateLocale(BuildContext context) async {
    await EasyLocalization.of(context)
        ?.setLocale(Locale(setting.languageCode ?? "en"));
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
