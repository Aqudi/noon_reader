import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:noon_reader/utils/extensions.dart';

import 'setting_viewmodel.dart';

class SettingPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final settingViewModel = useProvider(settingViewModelProvider);
    final setting = settingViewModel.setting;

    return SettingsList(
      sections: [
        SettingsSection(
          title: 'Common',
          tiles: [
            SettingsTile(
              title: 'Language',
              subtitle: setting.language,
              leading: Icon(Icons.language),
              onPressed: settingViewModel.languageOnPressed,
            ),
            SettingsTile.switchTile(
              title: 'Dark mode',
              leading: Icon(Icons.dark_mode),
              onToggle: settingViewModel.darkModeOnToggle,
              switchValue: setting.darkMode,
            ),
          ],
        ),
        SettingsSection(
          title: 'Viewer',
          tiles: [
            SettingsTile(
              title: 'Font family',
              subtitle: setting.fontFamily,
              leading: Icon(Icons.text_format),
              onPressed: settingViewModel.fontFamilyOnPressed,
            ),
            SettingsTile(
              title: 'Font size',
              subtitle: '${setting.fontSize}',
              leading: Icon(Icons.format_size),
              onPressed: settingViewModel.fontSizeOnPressed,
            ),
            SettingsTile(
              title: 'Font weight',
              subtitle: setting.fontWeight.toReadableName(),
              leading: Icon(Icons.format_bold),
              onPressed: settingViewModel.fontWeightOnPressed,
            ),
            SettingsTile(
              title: 'Font color',
              subtitle: setting.fontColor.toReadableName(),
              leading: Icon(Icons.palette_outlined),
              onPressed: settingViewModel.fontColorOnPressed,
            ),
            SettingsTile(
              title: 'Background color',
              subtitle: setting.backgroundColor.toReadableName(),
              leading: Icon(Icons.format_paint_outlined),
              onPressed: settingViewModel.backgroundColorOnPressed,
            ),
            SettingsTile(
              title: 'Padding',
              subtitle: '${setting.padding}',
              leading: Icon(Icons.padding_outlined),
              onPressed: settingViewModel.paddingOnPressed,
            ),
          ],
        ),
        SettingsSection(
          title: 'Misc',
          tiles: [
            SettingsTile(
                title: 'Terms of Service', leading: Icon(Icons.description)),
            SettingsTile(
                title: 'Open source licenses',
                leading: Icon(Icons.collections_bookmark)),
          ],
        ),
      ],
    );
  }
}
