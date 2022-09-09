import 'dart:math';

import 'package:flutter/widgets.dart';

extension FontWeightReadable on FontWeight {
  static final values = {
    FontWeight.normal: 'Normal',
    FontWeight.bold: 'Bold',
    FontWeight.w800: 'Extra bold'
  };

  static List<FontWeight> get weights =>
      values.entries.map((e) => e.key).toList();
  static List<String> get names => values.entries.map((e) => e.value).toList();

  String toReadableName() {
    return values[this] ?? names.first;
  }

  static FontWeight fromReadableName(String name) {
    return weights[names.indexWhere((element) => element == name)];
  }
}

extension ColorReadable on Color {
  String toReadableName() {
    return '0x${value.toRadixString(16).toUpperCase()}';
  }
}

extension EdgeInsetsExtensions on EdgeInsets {
  String toReadable() {
    return 'left: $left, right: $right, top: $top, bottom: $bottom';
  }

  List<double> toLTRB() {
    return [left, top, right, bottom];
  }
}

extension DoubleExtensions on double {
  double roundAsFixed(int decimalPlaces) {
    return (this * pow(10, decimalPlaces)).round() / pow(10, decimalPlaces);
  }
}
