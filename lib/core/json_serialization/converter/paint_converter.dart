import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:paintroid/core/json_serialization/versioning/serializer_version.dart';

class PaintConverter implements JsonConverter<Paint, Map<String, dynamic>> {
  const PaintConverter();

  @override
  Paint fromJson(Map<String, dynamic> json) {
    final paint = Paint();
    final version = json['version'] as int;

    if (version >= Version.v1) {
      paint
        ..color = Color(json['color'] as int)
        ..strokeWidth = (json['strokeWidth'] as num).toDouble()
        ..strokeCap = StrokeCap.values[json['strokeCap'] as int]
        ..isAntiAlias = json['isAntiAlias'] as bool
        ..style = PaintingStyle.values[json['style'] as int]
        ..strokeJoin = StrokeJoin.values[json['strokeJoin'] as int]
        ..blendMode = BlendMode.values[json['blendMode'] as int];
    }
    if (version >= Version.v2) {
      // paint.newAttribute = json['newAttribute'];
    }
    return paint;
  }

  // Never remove attributes, it will cause errors in older versions!!
  // Only add new attributes at the end of the map and increase the version number.
  @override
  Map<String, dynamic> toJson(Paint paint) {
    final json = <String, dynamic>{};

    if (SerializerVersion.PAINT_VERSION >= Version.v1) {
      json
        ..['version'] = SerializerVersion.PAINT_VERSION
        ..['color'] = paint.color.value
        ..['strokeWidth'] = paint.strokeWidth
        ..['strokeCap'] = paint.strokeCap.index
        ..['isAntiAlias'] = paint.isAntiAlias
        ..['style'] = paint.style.index
        ..['strokeJoin'] = paint.strokeJoin.index
        ..['blendMode'] = paint.blendMode.index;
    }
    if (SerializerVersion.PAINT_VERSION >= Version.v2) {
      // json['newAttribute'] = paint.newAttribute;
    }

    return json;
  }
}