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

class EdgeInsetsSerializer
    implements JsonConverter<EdgeInsets, Map<EdgeInsetsDirections, double>> {
  const EdgeInsetsSerializer();

  @override
  EdgeInsets fromJson(Map<EdgeInsetsDirections, double> json) =>
      EdgeInsets.only(
        top: json[EdgeInsetsDirections.top] ?? 0,
        bottom: json[EdgeInsetsDirections.bottom] ?? 0,
        left: json[EdgeInsetsDirections.left] ?? 0,
        right: json[EdgeInsetsDirections.right] ?? 0,
      );

  @override
  Map<EdgeInsetsDirections, double> toJson(EdgeInsets edgeInsets) => {
        EdgeInsetsDirections.top: edgeInsets.top,
        EdgeInsetsDirections.bottom: edgeInsets.bottom,
        EdgeInsetsDirections.left: edgeInsets.left,
        EdgeInsetsDirections.right: edgeInsets.right,
      };
}
