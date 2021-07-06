import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:noon_reader/utils/json_converters.dart';

part 'setting.freezed.dart';
part 'setting.g.dart';

@freezed
class Setting with _$Setting {
  factory Setting({
    required bool darkMode,
    required String language,
    required String fontFamily,
    required double fontSize,
    @JsonKey(name: 'fontWeight')
    @FontWeightSerializer()
        required FontWeight fontWeight,
    @JsonKey(name: 'fontColor') @ColorSerialiser() required Color fontColor,
    @JsonKey(name: 'backgroundColor')
    @ColorSerialiser()
        required Color backgroundColor,
    @JsonKey(name: 'padding')
    @EdgeInsetsSerializer()
        required EdgeInsets padding,
  }) = _Setting;

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);
}
