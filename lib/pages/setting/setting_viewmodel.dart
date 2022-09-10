import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:noon_reader/models/setting.dart';
import 'package:noon_reader/resources/resources.dart';
import 'package:noon_reader/services/setting.dart';
import 'package:noon_reader/top_level_provider.dart';
import 'package:noon_reader/utils/extensions.dart';

final settingViewModelProvider =
    ChangeNotifierProvider<SettingViewModel>((ref) {
  final logger = ref.watch(loggerProvider);
  final settingService = ref.watch(settingServiceProvider);
  return SettingViewModel(logger, settingService);
});

class SettingViewModel with ChangeNotifier {
  SettingViewModel(this._logger, this._settingService);

  final Logger _logger;
  final SettingService _settingService;
  Setting get setting => _settingService.setting;

  Future<String> loadSampleText() {
    return rootBundle.loadString(Assets.sampleLorem);
  }

  void toggleDarkMode(bool value) {
    _logger.d("darkModeOnToggle: $value");
    _settingService.update(
      setting.copyWith(
        darkMode: value,
      ),
    );
  }

  void updateLanguage(BuildContext context, String? value) async {
    _logger.d("languageOnPressed: $value");
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          languageCode: value,
        ),
        save: false,
      );
      await _settingService.updateLocale(context);
      await _settingService.save();
    }
  }

  void updateFontFamily(String? value) async {
    _logger.d("fontFamilyOnPressed: $value");
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          fontFamily: value,
        ),
      );
    }
  }

  void updateFontSize(num? value) async {
    _logger.d("fontSizeOnPressed: $value");
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          fontSize: value * 1.0,
        ),
      );
    }
  }

  void updateFontWeight(String? value) async {
    _logger.d("fontWeightOnPressed: $value");
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          fontWeight: FontWeightReadable.fromReadableName(value),
        ),
      );
    }
  }

  void updateFontColor(Color? value) async {
    _logger.d("updateFontColor: $value");
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          fontColor: value,
        ),
      );
    }
  }

  void updateBackgroundColor(Color? value) async {
    _logger.d("updateBackgroundColor: $value");
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          backgroundColor: value,
        ),
      );
    }
  }

  void updatePadding(EdgeInsets? value) async {
    _logger.d("paddingOnPressed: $value");
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          padding: value,
        ),
      );
    }
  }
}
