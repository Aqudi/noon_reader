import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:noon_reader/constants/app.dart';
import 'package:noon_reader/models/setting.dart';
import 'package:noon_reader/resources/resources.dart';
import 'package:noon_reader/services/setting.dart';
import 'package:noon_reader/utils/extensions.dart';
import 'package:noon_reader/widgets/floating_modal.dart';

import 'widgets/widgets.dart';

final settingViewModelProvider =
    ChangeNotifierProvider<SettingViewModel>((ref) {
  final settingService = ref.watch(settingServiceProvider);
  return SettingViewModel(settingService);
});

class SettingViewModel with ChangeNotifier {
  SettingViewModel(this._settingService);

  final SettingService _settingService;
  Setting get setting => _settingService.setting;

  Future<String> loadSampleText() {
    return rootBundle.loadString(Assets.sampleLorem);
  }

  void darkModeOnToggle(bool value) {
    _settingService.update(
      setting.copyWith(
        darkMode: value,
      ),
    );
    notifyListeners();
  }

  void languageOnPressed(BuildContext context) async {
    final value = await showFloatingModalBottomSheet(
      context: context,
      builder: (context) => const OptionModal(
        title: 'Language',
        options: AppConstants.languages,
      ),
    );
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          language: value,
        ),
      );
      notifyListeners();
    }
  }

  void fontFamilyOnPressed(BuildContext context) async {
    final value = await showFloatingModalBottomSheet(
      context: context,
      builder: (context) => OptionModal(
        title: 'Font family',
        options: AppConstants.fontFamilies,
        builder: (dynamic fontFamily) => Text(
          '$fontFamily',
          style: GoogleFonts.getFont(fontFamily,
              textStyle: Theme.of(context).textTheme.bodyText2),
        ),
      ),
    );
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          fontFamily: value,
        ),
      );
      notifyListeners();
    }
  }

  void fontSizeOnPressed(BuildContext context) async {
    final value = await showFloatingModalBottomSheet(
      context: context,
      builder: (context) => OptionModal(
        title: 'Font size',
        options: List.generate(70, (index) => index + 8),
      ),
    );
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          fontSize: value * 1.0,
        ),
      );
      notifyListeners();
    }
  }

  void fontWeightOnPressed(BuildContext context) async {
    final value = await showFloatingModalBottomSheet(
      context: context,
      builder: (context) => OptionModal(
        title: 'Font weight',
        options: FontWeightReadable.names,
      ),
    );
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          fontWeight: FontWeightReadable.fromReadableName(value),
        ),
      );
      notifyListeners();
    }
  }

  void updateFontColor(Color? color) async {
    if (color != null) {
      _settingService.update(
        setting.copyWith(
          fontColor: color,
        ),
      );
      notifyListeners();
    }
  }

  void updateBackgroundColor(Color? color) async {
    if (color != null) {
      _settingService.update(
        setting.copyWith(
          backgroundColor: color,
        ),
      );
      notifyListeners();
    }
  }

  void paddingOnPressed(Future<double?> Function() builder) async {
    final value = await builder();
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          padding: EdgeInsets.all(value * 1.0),
        ),
      );
      notifyListeners();
    }
  }
}
