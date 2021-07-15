// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Setting _$_$_SettingFromJson(Map<String, dynamic> json) {
  return _$_Setting(
    darkMode: json['darkMode'] as bool,
    language: json['language'] as String,
    fontFamily: json['fontFamily'] as String,
    fontSize: (json['fontSize'] as num).toDouble(),
    fontWeight:
        const FontWeightSerializer().fromJson(json['fontWeight'] as int),
    fontColor: const ColorSerialiser().fromJson(json['fontColor'] as int),
    backgroundColor:
        const ColorSerialiser().fromJson(json['backgroundColor'] as int),
    padding: const EdgeInsetsSerializer().fromJson(json['padding'] as String),
  );
}

Map<String, dynamic> _$_$_SettingToJson(_$_Setting instance) =>
    <String, dynamic>{
      'darkMode': instance.darkMode,
      'language': instance.language,
      'fontFamily': instance.fontFamily,
      'fontSize': instance.fontSize,
      'fontWeight': const FontWeightSerializer().toJson(instance.fontWeight),
      'fontColor': const ColorSerialiser().toJson(instance.fontColor),
      'backgroundColor':
          const ColorSerialiser().toJson(instance.backgroundColor),
      'padding': const EdgeInsetsSerializer().toJson(instance.padding),
    };
