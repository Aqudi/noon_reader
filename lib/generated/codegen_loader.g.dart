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

  static const Map<String,dynamic> en = {
  "language": {
    "en": "English",
    "ko": "한국어"
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
  "save": "save",
  "left": "left",
  "top": "top",
  "right": "right",
  "bottom": "bottom"
};
static const Map<String,dynamic> ko = {
  "explorer": {
    "label": "탐색기",
    "openFile": "파일열기"
  },
  "error": {
    "404": "404 Page not found",
    "unknown": "Unknown error"
  },
  "history": {
    "label": "기록"
  },
  "setting": {
    "label": "설정",
    "common_section": "일반",
    "language": "언어",
    "darkMode": "다크모드",
    "viewer_preview_section": "뷰어 미리보기",
    "viewer_section": "뷰어",
    "fontFamily": "글꼴",
    "fontSize": "글자 크기",
    "fontWeight": "글자 굵기",
    "fontColor": "글자 색상",
    "backgroundColor": "배경 색상",
    "padding": "여백",
    "misc_section": "기타",
    "termisOfService": "서비스 이용약관",
    "openSourceLicenses": "오픈소스 라이센스"
  },
  "viewer": {
    "menuTooltip": "메뉴"
  },
  "save": "저장",
  "left": "왼쪽",
  "top": "상단",
  "right": "오른쪽",
  "bottom": "하단"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ko": ko};
}
