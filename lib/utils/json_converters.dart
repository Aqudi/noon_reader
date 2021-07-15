import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorSerialiser implements JsonConverter<Color, int> {
  const ColorSerialiser();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.value;
}

class FontWeightSerializer implements JsonConverter<FontWeight, int> {
  const FontWeightSerializer();

  @override
  FontWeight fromJson(int json) => FontWeight.values[json];

  @override
  int toJson(FontWeight fontWeight) => fontWeight.index;
}

enum EdgeInsetsDirections {
  top,
  bottom,
  left,
  right,
}

class EdgeInsetsSerializer implements JsonConverter<EdgeInsets, String> {
  const EdgeInsetsSerializer();

  @override
  EdgeInsets fromJson(String json) {
    final map = jsonDecode(json);
    return EdgeInsets.only(
      top: map[EdgeInsetsDirections.top.toString()] ?? 0,
      bottom: map[EdgeInsetsDirections.bottom.toString()] ?? 0,
      left: map[EdgeInsetsDirections.left.toString()] ?? 0,
      right: map[EdgeInsetsDirections.right.toString()] ?? 0,
    );
  }

  @override
  String toJson(EdgeInsets edgeInsets) {
    final map = {
      EdgeInsetsDirections.top.toString(): edgeInsets.top,
      EdgeInsetsDirections.bottom.toString(): edgeInsets.bottom,
      EdgeInsetsDirections.left.toString(): edgeInsets.left,
      EdgeInsetsDirections.right.toString(): edgeInsets.right,
    };
    return jsonEncode(map);
  }
}
