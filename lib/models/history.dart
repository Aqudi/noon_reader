import 'package:freezed_annotation/freezed_annotation.dart';

part 'history.freezed.dart';
part 'history.g.dart';

@freezed
class History with _$History {
  factory History({
    @Default(0) int? index,
    @Default(0) int? maxIndex,
    @Default("") String? path,
    @Default(0) int? timestamp,
  }) = _History;

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
}
