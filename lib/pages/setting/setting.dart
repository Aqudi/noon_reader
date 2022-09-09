import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/constants/app.dart';
import 'package:noon_reader/pages/setting/widgets/option_modal.dart';
import 'package:noon_reader/widgets/floating_modal.dart';
import 'package:noon_reader/widgets/loading_indicator.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:noon_reader/widgets/viewer_container.dart';
import 'package:noon_reader/utils/extensions.dart';

import '../../generated/locale_keys.g.dart';
import 'setting_viewmodel.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingViewModel = ref.watch(settingViewModelProvider);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCommonSection(settingViewModel, context),
            ..._buildViewerPreviewSection(settingViewModel, context),
            _buildViewerSection(settingViewModel, context),
            _buildMiscSection(context),
          ],
        ),
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
          title: const Text(LocaleKeys.setting_common_section).tr(),
          tiles: [
            SettingsTile(
              title: const Text(LocaleKeys.setting_language).tr(),
              description:
                  Text("${LocaleKeys.language}.${setting.languageCode}").tr(),
              leading: const Icon(Icons.language),
              onPressed: (context) async => settingViewModel.updateLanguage(
                context,
                await showFloatingModalBottomSheet(
                  context: context,
                  builder: (context) => OptionModal(
                    title: 'Language',
                    builder: (code) =>
                        Text("${LocaleKeys.language}.$code").tr(),
                    options: context.supportedLocales
                        .map((locale) => locale.languageCode)
                        .toList(),
                  ),
                ),
              ),
            ),
            SettingsTile.switchTile(
              title: const Text(LocaleKeys.setting_darkMode).tr(),
              leading: const Icon(Icons.dark_mode),
              onToggle: settingViewModel.toggleDarkMode,
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
          SettingsSection(
            title: const Text(LocaleKeys.setting_viewer_preview_section).tr(),
            tiles: const [],
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
                content = LocaleKeys.error_unknown.tr();
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

    buildColorBox(Color color) {
      return Container(
        width: 100,
        color: color,
        child: const Text(" "),
      );
    }

    Widget showColorPicker(Color color) {
      return HookConsumer(builder: (context, ref, widget) {
        final newColor = useState(color);
        final textController = useTextEditingController();

        return AlertDialog(
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: newColor.value,
              onColorChanged: (value) {
                newColor.value = value;
              },
              hexInputController: textController,
              colorPickerWidth: 300,
              pickerAreaHeightPercent: 0.7,
              displayThumbColor: true,
              paletteType: PaletteType.hsvWithHue,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
              portraitOnly: true,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text(LocaleKeys.save).tr(),
              onPressed: () {
                Navigator.of(context).pop(newColor.value);
              },
            ),
          ],
        );
      });
    }

    return _buildSettingList(
      sections: [
        SettingsSection(
          title: const Text(LocaleKeys.setting_viewer_section).tr(),
          tiles: [
            SettingsTile(
              title: const Text(LocaleKeys.setting_fontFamily).tr(),
              description: Text(setting.fontFamily),
              leading: const Icon(Icons.text_format),
              onPressed: (context) async => settingViewModel.updateFontFamily(
                await showFloatingModalBottomSheet(
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
                ),
              ),
            ),
            SettingsTile(
              title: const Text(LocaleKeys.setting_fontSize).tr(),
              description: Text('${setting.fontSize}'),
              leading: const Icon(Icons.format_size),
              onPressed: (context) async => settingViewModel.updateFontSize(
                await showFloatingModalBottomSheet(
                  context: context,
                  builder: (context) => HookConsumer(
                    builder: (context, ref, widget) {
                      final settingViewModel =
                          ref.watch(settingViewModelProvider);
                      final fontSize = settingViewModel.setting.fontSize;
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          Slider(
                            value: fontSize,
                            min: 1,
                            max: 100,
                            label: fontSize.toInt().toString(),
                            onChanged: (value) {
                              settingViewModel.updateFontSize(value.toInt());
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            SettingsTile(
              title: const Text(LocaleKeys.setting_fontWeight).tr(),
              description: Text(setting.fontWeight.toReadableName()),
              leading: const Icon(Icons.format_bold),
              onPressed: (context) async => settingViewModel.updateFontWeight(
                await showFloatingModalBottomSheet(
                  context: context,
                  builder: (context) => OptionModal(
                    title: LocaleKeys.setting_fontWeight.tr(),
                    options: FontWeightReadable.names,
                  ),
                ),
              ),
            ),
            SettingsTile(
              title: const Text(LocaleKeys.setting_fontColor).tr(),
              trailing: buildColorBox(setting.fontColor),
              leading: const Icon(Icons.palette_outlined),
              onPressed: (context) async => settingViewModel.updateFontColor(
                await showDialog<Color?>(
                  context: context,
                  builder: (context) => showColorPicker(setting.fontColor),
                ),
              ),
            ),
            SettingsTile(
              title: const Text(LocaleKeys.setting_backgroundColor).tr(),
              trailing: buildColorBox(setting.backgroundColor),
              leading: const Icon(Icons.format_paint_outlined),
              onPressed: (context) async =>
                  settingViewModel.updateBackgroundColor(
                await showDialog<Color?>(
                  context: context,
                  builder: (context) =>
                      showColorPicker(setting.backgroundColor),
                ),
              ),
            ),
            SettingsTile(
              title: const Text(LocaleKeys.setting_padding).tr(),
              description: Text(setting.padding
                  .toReadable()
                  .split(", ")
                  .map((e) => e.tr())
                  .join("\n")),
              leading: const Icon(Icons.padding_outlined),
              onPressed: (context) async => settingViewModel.updatePadding(
                await showFloatingModalBottomSheet(
                  context: context,
                  builder: (context) => HookConsumer(
                    builder: (context, ref, widget) {
                      final settingViewModel =
                          ref.watch(settingViewModelProvider);
                      final padding = settingViewModel.setting.padding
                          .toLTRB()
                          .map((e) => e.roundAsFixed(2))
                          .toList();
                      final labelKeys = ["left", "top", "right", "bottom"];
                      final labels =
                          labelKeys.map((e) => e.tr().padLeft(6, " ")).toList();

                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        shrinkWrap: true,
                        children: [
                          for (var i = 0; i < padding.length; i++)
                            Row(
                              children: [
                                Text(labels[i]),
                                Expanded(
                                  child: Slider(
                                    value: padding[i],
                                    min: 0,
                                    max: 100,
                                    label: padding[i].toString(),
                                    onChanged: (value) {
                                      padding[i] = value.roundAsFixed(2);
                                      settingViewModel.updatePadding(
                                        EdgeInsets.fromLTRB(
                                          padding[0],
                                          padding[1],
                                          padding[2],
                                          padding[3],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Text(padding[i].toString().padRight(6, " ")),
                              ],
                            ),
                        ],
                      );
                    },
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
          title: const Text(LocaleKeys.setting_misc_section).tr(),
          tiles: [
            SettingsTile(
              title: const Text(LocaleKeys.setting_termisOfService).tr(),
              leading: const Icon(Icons.description),
            ),
            SettingsTile(
              title: const Text(LocaleKeys.setting_openSourceLicenses).tr(),
              leading: const Icon(Icons.collections_bookmark),
            ),
          ],
        ),
      ],
    );
  }
}
