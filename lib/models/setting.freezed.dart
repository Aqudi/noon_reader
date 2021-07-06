// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Setting _$SettingFromJson(Map<String, dynamic> json) {
  return _Setting.fromJson(json);
}

/// @nodoc
class _$SettingTearOff {
  const _$SettingTearOff();

  _Setting call(
      {required bool darkMode,
      required String language,
      required String fontFamily,
      required double fontSize,
      @JsonKey(name: 'fontWeight')
      @FontWeightSerializer()
          required FontWeight fontWeight,
      @JsonKey(name: 'fontColor')
      @ColorSerialiser()
          required Color fontColor,
      @JsonKey(name: 'backgroundColor')
      @ColorSerialiser()
          required Color backgroundColor,
      @JsonKey(name: 'padding')
      @EdgeInsetsSerializer()
          required EdgeInsets padding}) {
    return _Setting(
      darkMode: darkMode,
      language: language,
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontColor: fontColor,
      backgroundColor: backgroundColor,
      padding: padding,
    );
  }

  Setting fromJson(Map<String, Object> json) {
    return Setting.fromJson(json);
  }
}

/// @nodoc
const $Setting = _$SettingTearOff();

/// @nodoc
mixin _$Setting {
  bool get darkMode => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String get fontFamily => throw _privateConstructorUsedError;
  double get fontSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'fontWeight')
  @FontWeightSerializer()
  FontWeight get fontWeight => throw _privateConstructorUsedError;
  @JsonKey(name: 'fontColor')
  @ColorSerialiser()
  Color get fontColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'backgroundColor')
  @ColorSerialiser()
  Color get backgroundColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'padding')
  @EdgeInsetsSerializer()
  EdgeInsets get padding => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingCopyWith<Setting> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingCopyWith<$Res> {
  factory $SettingCopyWith(Setting value, $Res Function(Setting) then) =
      _$SettingCopyWithImpl<$Res>;
  $Res call(
      {bool darkMode,
      String language,
      String fontFamily,
      double fontSize,
      @JsonKey(name: 'fontWeight')
      @FontWeightSerializer()
          FontWeight fontWeight,
      @JsonKey(name: 'fontColor')
      @ColorSerialiser()
          Color fontColor,
      @JsonKey(name: 'backgroundColor')
      @ColorSerialiser()
          Color backgroundColor,
      @JsonKey(name: 'padding')
      @EdgeInsetsSerializer()
          EdgeInsets padding});
}

/// @nodoc
class _$SettingCopyWithImpl<$Res> implements $SettingCopyWith<$Res> {
  _$SettingCopyWithImpl(this._value, this._then);

  final Setting _value;
  // ignore: unused_field
  final $Res Function(Setting) _then;

  @override
  $Res call({
    Object? darkMode = freezed,
    Object? language = freezed,
    Object? fontFamily = freezed,
    Object? fontSize = freezed,
    Object? fontWeight = freezed,
    Object? fontColor = freezed,
    Object? backgroundColor = freezed,
    Object? padding = freezed,
  }) {
    return _then(_value.copyWith(
      darkMode: darkMode == freezed
          ? _value.darkMode
          : darkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      fontFamily: fontFamily == freezed
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      fontSize: fontSize == freezed
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      fontWeight: fontWeight == freezed
          ? _value.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as FontWeight,
      fontColor: fontColor == freezed
          ? _value.fontColor
          : fontColor // ignore: cast_nullable_to_non_nullable
              as Color,
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      padding: padding == freezed
          ? _value.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as EdgeInsets,
    ));
  }
}

/// @nodoc
abstract class _$SettingCopyWith<$Res> implements $SettingCopyWith<$Res> {
  factory _$SettingCopyWith(_Setting value, $Res Function(_Setting) then) =
      __$SettingCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool darkMode,
      String language,
      String fontFamily,
      double fontSize,
      @JsonKey(name: 'fontWeight')
      @FontWeightSerializer()
          FontWeight fontWeight,
      @JsonKey(name: 'fontColor')
      @ColorSerialiser()
          Color fontColor,
      @JsonKey(name: 'backgroundColor')
      @ColorSerialiser()
          Color backgroundColor,
      @JsonKey(name: 'padding')
      @EdgeInsetsSerializer()
          EdgeInsets padding});
}

/// @nodoc
class __$SettingCopyWithImpl<$Res> extends _$SettingCopyWithImpl<$Res>
    implements _$SettingCopyWith<$Res> {
  __$SettingCopyWithImpl(_Setting _value, $Res Function(_Setting) _then)
      : super(_value, (v) => _then(v as _Setting));

  @override
  _Setting get _value => super._value as _Setting;

  @override
  $Res call({
    Object? darkMode = freezed,
    Object? language = freezed,
    Object? fontFamily = freezed,
    Object? fontSize = freezed,
    Object? fontWeight = freezed,
    Object? fontColor = freezed,
    Object? backgroundColor = freezed,
    Object? padding = freezed,
  }) {
    return _then(_Setting(
      darkMode: darkMode == freezed
          ? _value.darkMode
          : darkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      fontFamily: fontFamily == freezed
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      fontSize: fontSize == freezed
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      fontWeight: fontWeight == freezed
          ? _value.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as FontWeight,
      fontColor: fontColor == freezed
          ? _value.fontColor
          : fontColor // ignore: cast_nullable_to_non_nullable
              as Color,
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      padding: padding == freezed
          ? _value.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as EdgeInsets,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Setting implements _Setting {
  _$_Setting(
      {required this.darkMode,
      required this.language,
      required this.fontFamily,
      required this.fontSize,
      @JsonKey(name: 'fontWeight')
      @FontWeightSerializer()
          required this.fontWeight,
      @JsonKey(name: 'fontColor')
      @ColorSerialiser()
          required this.fontColor,
      @JsonKey(name: 'backgroundColor')
      @ColorSerialiser()
          required this.backgroundColor,
      @JsonKey(name: 'padding')
      @EdgeInsetsSerializer()
          required this.padding});

  factory _$_Setting.fromJson(Map<String, dynamic> json) =>
      _$_$_SettingFromJson(json);

  @override
  final bool darkMode;
  @override
  final String language;
  @override
  final String fontFamily;
  @override
  final double fontSize;
  @override
  @JsonKey(name: 'fontWeight')
  @FontWeightSerializer()
  final FontWeight fontWeight;
  @override
  @JsonKey(name: 'fontColor')
  @ColorSerialiser()
  final Color fontColor;
  @override
  @JsonKey(name: 'backgroundColor')
  @ColorSerialiser()
  final Color backgroundColor;
  @override
  @JsonKey(name: 'padding')
  @EdgeInsetsSerializer()
  final EdgeInsets padding;

  @override
  String toString() {
    return 'Setting(darkMode: $darkMode, language: $language, fontFamily: $fontFamily, fontSize: $fontSize, fontWeight: $fontWeight, fontColor: $fontColor, backgroundColor: $backgroundColor, padding: $padding)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Setting &&
            (identical(other.darkMode, darkMode) ||
                const DeepCollectionEquality()
                    .equals(other.darkMode, darkMode)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.fontFamily, fontFamily) ||
                const DeepCollectionEquality()
                    .equals(other.fontFamily, fontFamily)) &&
            (identical(other.fontSize, fontSize) ||
                const DeepCollectionEquality()
                    .equals(other.fontSize, fontSize)) &&
            (identical(other.fontWeight, fontWeight) ||
                const DeepCollectionEquality()
                    .equals(other.fontWeight, fontWeight)) &&
            (identical(other.fontColor, fontColor) ||
                const DeepCollectionEquality()
                    .equals(other.fontColor, fontColor)) &&
            (identical(other.backgroundColor, backgroundColor) ||
                const DeepCollectionEquality()
                    .equals(other.backgroundColor, backgroundColor)) &&
            (identical(other.padding, padding) ||
                const DeepCollectionEquality().equals(other.padding, padding)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(darkMode) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(fontFamily) ^
      const DeepCollectionEquality().hash(fontSize) ^
      const DeepCollectionEquality().hash(fontWeight) ^
      const DeepCollectionEquality().hash(fontColor) ^
      const DeepCollectionEquality().hash(backgroundColor) ^
      const DeepCollectionEquality().hash(padding);

  @JsonKey(ignore: true)
  @override
  _$SettingCopyWith<_Setting> get copyWith =>
      __$SettingCopyWithImpl<_Setting>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SettingToJson(this);
  }
}

abstract class _Setting implements Setting {
  factory _Setting(
      {required bool darkMode,
      required String language,
      required String fontFamily,
      required double fontSize,
      @JsonKey(name: 'fontWeight')
      @FontWeightSerializer()
          required FontWeight fontWeight,
      @JsonKey(name: 'fontColor')
      @ColorSerialiser()
          required Color fontColor,
      @JsonKey(name: 'backgroundColor')
      @ColorSerialiser()
          required Color backgroundColor,
      @JsonKey(name: 'padding')
      @EdgeInsetsSerializer()
          required EdgeInsets padding}) = _$_Setting;

  factory _Setting.fromJson(Map<String, dynamic> json) = _$_Setting.fromJson;

  @override
  bool get darkMode => throw _privateConstructorUsedError;
  @override
  String get language => throw _privateConstructorUsedError;
  @override
  String get fontFamily => throw _privateConstructorUsedError;
  @override
  double get fontSize => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'fontWeight')
  @FontWeightSerializer()
  FontWeight get fontWeight => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'fontColor')
  @ColorSerialiser()
  Color get fontColor => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'backgroundColor')
  @ColorSerialiser()
  Color get backgroundColor => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'padding')
  @EdgeInsetsSerializer()
  EdgeInsets get padding => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SettingCopyWith<_Setting> get copyWith =>
      throw _privateConstructorUsedError;
}
