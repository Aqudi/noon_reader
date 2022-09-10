// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Setting _$$_SettingFromJson(Map<String, dynamic> json) => _$_Setting(
      darkMode: json['darkMode'] as bool,
      languageCode: json['languageCode'] as String?,
      fontFamily: json['fontFamily'] as String,
      fontSize: (json['fontSize'] as num).toDouble(),
      fontWeight:
          const FontWeightSerializer().fromJson(json['fontWeight'] as int),
      fontColor: const ColorSerialiser().fromJson(json['fontColor'] as int),
      backgroundColor:
          const ColorSerialiser().fromJson(json['backgroundColor'] as int),
      padding: const EdgeInsetsSerializer().fromJson(json['padding'] as String),
    );

Map<String, dynamic> _$$_SettingToJson(_$_Setting instance) =>
    <String, dynamic>{
      'darkMode': instance.darkMode,
      'languageCode': instance.languageCode,
      'fontFamily': instance.fontFamily,
      'fontSize': instance.fontSize,
      'fontWeight': const FontWeightSerializer().toJson(instance.fontWeight),
      'fontColor': const ColorSerialiser().toJson(instance.fontColor),
      'backgroundColor':
          const ColorSerialiser().toJson(instance.backgroundColor),
      'padding': const EdgeInsetsSerializer().toJson(instance.padding),
    };
