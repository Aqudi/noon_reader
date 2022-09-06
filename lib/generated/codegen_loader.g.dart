// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en_US = {
  "language": {
    "en": "English",
    "ko": "Korean"
  },
  "explorer": {
    "label": "Explorer",
    "openFile": "Open file"
  },
  "error": {
    "404": "404 Page not found",
    "unknown": "Unknown error"
  },
  "history": {
    "label": "History"
  },
  "setting": {
    "label": "Setting",
    "common_section": "Common",
    "language": "Language",
    "darkMode": "Dark mode",
    "viewer_preview_section": "Viewer preview",
    "viewer_section": "Viewer",
    "fontFamily": "Font family",
    "fontSize": "Font size",
    "fontWeight": "Font weight",
    "fontColor": "Font color",
    "backgroundColor": "Background color",
    "padding": "Padding",
    "misc_section": "Misc",
    "termisOfService": "Terms of service",
    "openSourceLicenses": "Open source licenses"
  },
  "viewer": {
    "menuTooltip": "menu"
  },
  "save": "save"
};
static const Map<String,dynamic> ko_KR = {};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": en_US, "ko_KR": ko_KR};
}
