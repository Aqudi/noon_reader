import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:noon_reader/constants/app.dart';
import 'package:noon_reader/models/setting.dart';
import 'package:noon_reader/services/setting.dart';
import 'package:noon_reader/utils/extensions.dart';
import 'package:noon_reader/widgets/floating_modal.dart';

import 'widgets/widgets.dart';

final settingViewModelProvider =
    ChangeNotifierProvider((ref) => SettingViewModel(ref.read));

class SettingViewModel with ChangeNotifier {
  final Reader read;

  SettingViewModel(this.read);

  SettingService get _settingService => read(settingServiceProvider);
  Setting get setting => _settingService.setting;

  @override
  void notifyListeners() {
    _settingService.save();
    super.notifyListeners();
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
      builder: (context) => OptionModal(
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
        options: List.generate(20, (index) => index + 8),
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

  void fontColorOnPressed(BuildContext context) async {
    final value = await showFloatingModalBottomSheet(
      context: context,
      builder: (context) => OptionModal(
          title: 'Font color',
          options: [
            Colors.black,
            Colors.white,
            Colors.red,
            Colors.blue,
            Colors.green,
            Colors.yellow
          ],
          builder: (value) => Row(
                children: [
                  Container(
                    color: Color(value.value),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 16),
                  ),
                  Text(Color(value.value).toReadableName()),
                ],
              )),
    );
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          fontColor: value,
        ),
      );
      notifyListeners();
    }
  }

  void backgroundColorOnPressed(BuildContext context) async {
    final value = await showFloatingModalBottomSheet(
      context: context,
      builder: (context) => OptionModal(
          title: 'Background color',
          options: [
            Colors.black,
            Colors.white,
            Colors.red,
            Colors.blue,
            Colors.green,
            Colors.yellow
          ],
          builder: (value) => Row(
                children: [
                  Container(
                    color: Color(value.value),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 16),
                  ),
                  Text(Color(value.value).toReadableName()),
                ],
              )),
    );
    if (value != null) {
      _settingService.update(
        setting.copyWith(
          backgroundColor: value,
        ),
      );
      notifyListeners();
    }
  }

  void paddingOnPressed(BuildContext context) async {
    final value = await showFloatingModalBottomSheet(
      context: context,
      builder: (context) => OptionModal(
        title: 'Padding',
        options: List.generate(30, (index) => index),
      ),
    );
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
