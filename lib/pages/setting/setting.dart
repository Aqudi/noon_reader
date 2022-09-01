import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/pages/setting/widgets/option_modal.dart';
import 'package:noon_reader/widgets/floating_modal.dart';
import 'package:noon_reader/widgets/loading_indicator.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:noon_reader/widgets/viewer_container.dart';
import 'package:noon_reader/utils/extensions.dart';

import 'setting_viewmodel.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingViewModel = ref.watch(settingViewModelProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCommonSection(settingViewModel, context),
          ..._buildViewerPreviewSection(settingViewModel, context),
          _buildViewerSection(settingViewModel, context),
          _buildMiscSection(context),
        ],
      ),
    );
  }

  Widget _buildSettingList({required List<SettingsSection> sections}) {
    return SettingsList(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      sections: sections,
    );
  }

  Widget _buildCommonSection(
      SettingViewModel settingViewModel, BuildContext context) {
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

  List<Widget> _buildViewerPreviewSection(
      SettingViewModel settingViewModel, BuildContext context) {
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
        child: HookBuilder(
          builder: (context) {
            final snapshot = useFuture(settingViewModel.loadSampleText());

            late Widget widget;

            if (snapshot.connectionState != ConnectionState.done) {
              widget = const LoadingIndicator();
            } else {
              String? content;
              if (snapshot.hasData) {
                content = snapshot.data;
              }

              if (snapshot.hasError) {
                content = "알 수 없는 오류";
              }

              widget = ViewerContainer(
                content: content?.split("\n"),
                setting: settingViewModel.setting,
              );
            }

            return widget;
          },
        ),
      ),
    ];
  }

  Widget _buildViewerSection(
      SettingViewModel settingViewModel, BuildContext context) {
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
              onPressed: (context) => settingViewModel.backgroundColorOnPressed(
                () async => showFloatingModalBottomSheet<Color?>(
                  context: context,
                  builder: (context) => OptionModal(
                      title: 'Background color',
                      options: const [
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
                ),
              ),
            ),
            SettingsTile(
              title: const Text('Padding'),
              description: Text(setting.padding.toReadable()),
              leading: const Icon(Icons.padding_outlined),
              onPressed: (context) => settingViewModel.paddingOnPressed(
                () async => showFloatingModalBottomSheet<double?>(
                  context: context,
                  builder: (context) => OptionModal(
                    title: 'Padding',
                    options: List.generate(30, (index) => index),
                  ),
                ),
              ),
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
}
