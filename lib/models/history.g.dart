// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_History _$$_HistoryFromJson(Map<String, dynamic> json) => _$_History(
      index: json['index'] as int? ?? 0,
      maxIndex: json['maxIndex'] as int? ?? 0,
      path: json['path'] as String? ?? "",
      timestamp: json['timestamp'] as int? ?? 0,
    );

Map<String, dynamic> _$$_HistoryToJson(_$_History instance) =>
    <String, dynamic>{
      'index': instance.index,
      'maxIndex': instance.maxIndex,
      'path': instance.path,
      'timestamp': instance.timestamp,
    };
