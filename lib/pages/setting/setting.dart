import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:settings_ui/src/defines.dart';

import 'package:noon_reader/widgets/viewer_container.dart';
import 'package:noon_reader/utils/extensions.dart';

import 'setting_viewmodel.dart';

class SettingPage extends HookWidget {
  final lorem =
      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus imperdiet tortor vitae sagittis efficitur. Duis posuere nisl quam, sed lacinia purus dignissim sed. Aenean ornare justo molestie mauris finibus scelerisque. Nunc a est posuere, tempus enim a, rhoncus erat. Ut fringilla arcu vel ipsum faucibus, ut vestibulum nisl fermentum. Nullam efficitur laoreet mi, sed iaculis tellus tristique vitae. Nullam a ornare dolor. Nulla auctor, purus et vestibulum volutpat, ligula metus rhoncus felis, eget luctus mauris elit sed est. Proin scelerisque purus varius est egestas consequat. Donec suscipit nulla eu est condimentum blandit. Curabitur tempor neque vitae nisl tincidunt, cursus sagittis ipsum eleifend. In hendrerit leo eu ipsum tincidunt, vel mattis ante finibus. In eget efficitur dui. Aenean leo ex, auctor in est sed, vehicula euismod ante. Cras ullamcorper, risus vitae suscipit pellentesque, eros ipsum sagittis dolor, ullamcorper volutpat quam libero vel augue.

Duis a metus tellus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam felis ante, pretium sit amet hendrerit sed, mattis et metus. In egestas ligula tempor, consectetur enim eget, tincidunt magna. Morbi rhoncus, nisi non sodales facilisis, sapien nisl gravida erat, quis aliquam leo quam ut enim. Maecenas viverra accumsan pulvinar. In vulputate nisl vitae fermentum aliquet. Ut vel ante ac diam scelerisque porttitor. Nulla cursus a velit et imperdiet. Donec euismod consequat justo eu rhoncus. Pellentesque augue leo, pellentesque nec pellentesque vitae, elementum et nibh. Pellentesque fringilla elit vel laoreet placerat. Quisque vehicula feugiat tellus in malesuada.

Cras molestie luctus dolor, nec faucibus libero pellentesque ut. Duis vitae rhoncus sem. Maecenas pretium ligula ac auctor egestas. Nunc auctor elit in mattis tincidunt. Aliquam libero mauris, lacinia ac est lobortis, ullamcorper ultrices ipsum. Morbi non enim quis leo fringilla fermentum. Nulla rhoncus magna id leo accumsan hendrerit sed quis mauris. Duis bibendum erat sed nisl placerat, eget aliquam purus tincidunt. In id tincidunt nibh. Nunc egestas faucibus eros vitae tincidunt.''';

  final titlePadding = defaultTitlePadding.copyWith(top: 10);

  Widget _buildSettingList({List<SettingsSection>? sections}) {
    return SettingsList(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      sections: sections,
    );
  }

  Widget _buildCommonSection(BuildContext context) {
    final settingViewModel = context.read(settingViewModelProvider);
    final setting = settingViewModel.setting;

    return _buildSettingList(
      sections: [
        SettingsSection(
          title: 'Common',
          titlePadding: titlePadding,
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
      ],
    );
  }

  List<Widget> _buildViewerPreviewSection(BuildContext context) {
    return [
      _buildSettingList(
        sections: [
          SettingsSection(
            title: 'Viewer preview',
            titlePadding: titlePadding,
            subtitle: Text('You can check the viewer with the settings.'),
            tiles: [],
          ),
        ],
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: ViewerContainer(lorem),
      ),
    ];
  }

  Widget _buildViewerSection(BuildContext context) {
    final settingViewModel = context.read(settingViewModelProvider);
    final setting = settingViewModel.setting;

    return _buildSettingList(
      sections: [
        SettingsSection(
          title: 'Viewer',
          titlePadding: titlePadding,
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
              subtitle: '${setting.padding.toReadable()}',
              leading: Icon(Icons.padding_outlined),
              onPressed: settingViewModel.paddingOnPressed,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMiscSection(BuildContext context) {
    return _buildSettingList(
      sections: [
        SettingsSection(
          title: 'Misc',
          titlePadding: titlePadding,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCommonSection(context),
            ..._buildViewerPreviewSection(context),
            _buildViewerSection(context),
            _buildMiscSection(context),
          ],
        ),
      ),
    );
  }
}
