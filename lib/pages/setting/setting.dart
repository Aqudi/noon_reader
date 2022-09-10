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

final viewerPreviewGlobalKey = GlobalKey();

class SettingPage extends HookConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingViewModel = ref.watch(settingViewModelProvider);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCommonSection(context, settingViewModel),
            ..._buildViewerSection(context, settingViewModel),
            _buildMiscSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingList({
    Key? key,
    required List<SettingsSection> sections,
  }) {
    return SettingsList(
      key: key,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      sections: sections,
      // contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildCommonSection(
    BuildContext context,
    SettingViewModel settingViewModel,
  ) {
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
                    title: LocaleKeys.setting_language.tr(),
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

  List<Widget> _buildViewerSection(
    BuildContext context,
    SettingViewModel settingViewModel,
  ) {
    final setting = settingViewModel.setting;

    scrollToViewerPreview() {
      if (viewerPreviewGlobalKey.currentContext != null) {
        Scrollable.ensureVisible(
          viewerPreviewGlobalKey.currentContext!,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    }

    buildViewerPreview() {
      return SizedBox(
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
      );
    }

    buildColorBox(Color color) {
      return Container(
        width: 100,
        color: color,
        child: const Text(" "),
      );
    }

    showColorPicker(Color color) {
      return HookConsumer(builder: (context, ref, widget) {
        final textController = useTextEditingController();
        final newColor = useState(color);

        return AlertDialog(
          content: SingleChildScrollView(
            child: Theme(
              data: setting.darkMode ? ThemeData.dark() : ThemeData.light(),
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

    return [
      /// section title
      _buildSettingList(
        key: viewerPreviewGlobalKey,
        sections: [
          SettingsSection(
            title: const Text(LocaleKeys.setting_viewer_section).tr(),
            tiles: const [],
          ),
        ],
      ),

      /// viewer preview
      buildViewerPreview(),

      /// viewer settings
      _buildSettingList(
        sections: [
          SettingsSection(
            // title: const Text(LocaleKeys.setting_viewer_section).tr(),
            tiles: [
              SettingsTile(
                title: const Text(LocaleKeys.setting_fontFamily).tr(),
                description: Text(setting.fontFamily),
                leading: const Icon(Icons.text_format),
                onPressed: (context) async {
                  scrollToViewerPreview();

                  settingViewModel.updateFontFamily(
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
                  );
                },
              ),
              SettingsTile(
                title: const Text(LocaleKeys.setting_fontSize).tr(),
                description: Text('${setting.fontSize}'),
                leading: const Icon(Icons.format_size),
                onPressed: (context) async {
                  scrollToViewerPreview();

                  settingViewModel.updateFontSize(
                    await showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => HookConsumer(
                        builder: (context, ref, widget) {
                          final settingViewModel =
                              ref.watch(settingViewModelProvider);
                          final fontSize = settingViewModel.setting.fontSize;
                          return ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              ListTile(
                                leading: const Text(LocaleKeys.setting_fontSize)
                                    .tr(),
                                title: Slider(
                                  value: fontSize,
                                  min: 1,
                                  max: 100,
                                  label: fontSize.toInt().toString(),
                                  onChanged: (value) {
                                    settingViewModel
                                        .updateFontSize(value.toInt());
                                  },
                                ),
                                trailing:
                                    Text(fontSize.toString().padRight(6, " ")),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              SettingsTile(
                title: const Text(LocaleKeys.setting_fontWeight).tr(),
                description: Text(setting.fontWeight.toReadableName()),
                leading: const Icon(Icons.format_bold),
                onPressed: (context) async {
                  scrollToViewerPreview();

                  settingViewModel.updateFontWeight(
                    await showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => OptionModal(
                        title: LocaleKeys.setting_fontWeight.tr(),
                        options: FontWeightReadable.names,
                      ),
                    ),
                  );
                },
              ),
              SettingsTile(
                title: const Text(LocaleKeys.setting_fontColor).tr(),
                trailing: buildColorBox(setting.fontColor),
                leading: const Icon(Icons.palette_outlined),
                onPressed: (context) async {
                  scrollToViewerPreview();

                  settingViewModel.updateFontColor(
                    await showDialog<Color?>(
                      context: context,
                      builder: (context) => showColorPicker(setting.fontColor),
                    ),
                  );
                },
              ),
              SettingsTile(
                title: const Text(LocaleKeys.setting_backgroundColor).tr(),
                trailing: buildColorBox(setting.backgroundColor),
                leading: const Icon(Icons.format_paint_outlined),
                onPressed: (context) async {
                  scrollToViewerPreview();

                  settingViewModel.updateBackgroundColor(
                    await showDialog<Color?>(
                      context: context,
                      builder: (context) =>
                          showColorPicker(setting.backgroundColor),
                    ),
                  );
                },
              ),
              SettingsTile(
                title: const Text(LocaleKeys.setting_padding).tr(),
                description: Text(setting.padding
                    .toReadable()
                    .split(", ")
                    .map((e) => e.tr())
                    .join("\n")),
                leading: const Icon(Icons.padding_outlined),
                onPressed: (context) async {
                  scrollToViewerPreview();

                  settingViewModel.updatePadding(
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
                          final labels = labelKeys
                              .map((e) => e.tr().padLeft(6, " "))
                              .toList();

                          return ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              for (var i = 0; i < padding.length; i++)
                                ListTile(
                                  leading: Text(labels[i]),
                                  title: Slider(
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
                                  trailing: Text(
                                      padding[i].toString().padRight(6, " ")),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ];
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
