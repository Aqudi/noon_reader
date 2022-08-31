import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:noon_reader/widgets/viewer_container.dart';
import 'package:noon_reader/utils/extensions.dart';

import 'setting_viewmodel.dart';

class SettingPage extends HookConsumerWidget {
  final lorem =
      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus imperdiet tortor vitae sagittis efficitur. Duis posuere nisl quam, sed lacinia purus dignissim sed. Aenean ornare justo molestie mauris finibus scelerisque. Nunc a est posuere, tempus enim a, rhoncus erat. Ut fringilla arcu vel ipsum faucibus, ut vestibulum nisl fermentum. Nullam efficitur laoreet mi, sed iaculis tellus tristique vitae. Nullam a ornare dolor. Nulla auctor, purus et vestibulum volutpat, ligula metus rhoncus felis, eget luctus mauris elit sed est. Proin scelerisque purus varius est egestas consequat. Donec suscipit nulla eu est condimentum blandit. Curabitur tempor neque vitae nisl tincidunt, cursus sagittis ipsum eleifend. In hendrerit leo eu ipsum tincidunt, vel mattis ante finibus. In eget efficitur dui. Aenean leo ex, auctor in est sed, vehicula euismod ante. Cras ullamcorper, risus vitae suscipit pellentesque, eros ipsum sagittis dolor, ullamcorper volutpat quam libero vel augue.

Duis a metus tellus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam felis ante, pretium sit amet hendrerit sed, mattis et metus. In egestas ligula tempor, consectetur enim eget, tincidunt magna. Morbi rhoncus, nisi non sodales facilisis, sapien nisl gravida erat, quis aliquam leo quam ut enim. Maecenas viverra accumsan pulvinar. In vulputate nisl vitae fermentum aliquet. Ut vel ante ac diam scelerisque porttitor. Nulla cursus a velit et imperdiet. Donec euismod consequat justo eu rhoncus. Pellentesque augue leo, pellentesque nec pellentesque vitae, elementum et nibh. Pellentesque fringilla elit vel laoreet placerat. Quisque vehicula feugiat tellus in malesuada.

Cras molestie luctus dolor, nec faucibus libero pellentesque ut. Duis vitae rhoncus sem. Maecenas pretium ligula ac auctor egestas. Nunc auctor elit in mattis tincidunt. Aliquam libero mauris, lacinia ac est lobortis, ullamcorper ultrices ipsum. Morbi non enim quis leo fringilla fermentum. Nulla rhoncus magna id leo accumsan hendrerit sed quis mauris. Duis bibendum erat sed nisl placerat, eget aliquam purus tincidunt. In id tincidunt nibh. Nunc egestas faucibus eros vitae tincidunt.''';

  const SettingPage({Key? key}) : super(key: key);

  Widget _buildSettingList({required List<SettingsSection> sections}) {
    return SettingsList(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      sections: sections,
    );
  }

  Widget _buildCommonSection(WidgetRef ref, BuildContext context) {
    final settingViewModel = ref.read(settingViewModelProvider);
    final setting = settingViewModel.setting;

    return _buildSettingList(
      sections: [
        SettingsSection(
          title: const Text('Common'),
          tiles: [
            SettingsTile(
              title: const Text('Language'),
              description: Text(setting.language),
              leading: const Icon(Icons.language),
              onPressed: settingViewModel.languageOnPressed,
            ),
            SettingsTile.switchTile(
              title: const Text('Dark mode'),
              leading: const Icon(Icons.dark_mode),
              onToggle: settingViewModel.darkModeOnToggle,
              initialValue: setting.darkMode,
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
          const SettingsSection(
            title: Text('Viewer preview'),
            tiles: [],
          ),
        ],
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: ViewerContainer(lorem),
      ),
    ];
  }

  Widget _buildViewerSection(WidgetRef ref, BuildContext context) {
    final settingViewModel = ref.read(settingViewModelProvider);
    final setting = settingViewModel.setting;

    return _buildSettingList(
      sections: [
        SettingsSection(
          title: const Text('Viewer'),
          tiles: [
            SettingsTile(
              title: const Text('Font family'),
              description: Text(setting.fontFamily),
              leading: const Icon(Icons.text_format),
              onPressed: settingViewModel.fontFamilyOnPressed,
            ),
            SettingsTile(
              title: const Text('Font size'),
              description: Text('${setting.fontSize}'),
              leading: const Icon(Icons.format_size),
              onPressed: settingViewModel.fontSizeOnPressed,
            ),
            SettingsTile(
              title: const Text('Font weight'),
              description: Text(setting.fontWeight.toReadableName()),
              leading: const Icon(Icons.format_bold),
              onPressed: settingViewModel.fontWeightOnPressed,
            ),
            SettingsTile(
              title: const Text('Font color'),
              description: Text(setting.fontColor.toReadableName()),
              leading: const Icon(Icons.palette_outlined),
              onPressed: settingViewModel.fontColorOnPressed,
            ),
            SettingsTile(
              title: const Text('Background color'),
              description: Text(setting.backgroundColor.toReadableName()),
              leading: const Icon(Icons.format_paint_outlined),
              onPressed: settingViewModel.backgroundColorOnPressed,
            ),
            SettingsTile(
              title: const Text('Padding'),
              description: Text(setting.padding.toReadable()),
              leading: const Icon(Icons.padding_outlined),
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
          title: const Text('Misc'),
          tiles: [
            SettingsTile(
              title: const Text('Terms of Service'),
              leading: const Icon(Icons.description),
            ),
            SettingsTile(
              title: const Text('Open source licenses'),
              leading: const Icon(Icons.collections_bookmark),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCommonSection(ref, context),
          ..._buildViewerPreviewSection(context),
          _buildViewerSection(ref, context),
          _buildMiscSection(context),
        ],
      ),
    );
  }
}
