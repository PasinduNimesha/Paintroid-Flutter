import 'dart:ui';

extension OffsetExtensions on Offset {
  // Returns the distance between this [Offset] and [other].
  double distanceTo(Offset other) => (this - other).distance;

  // Checks if [other] is within [radius] of this [Offset].
  bool isWithinRadius(Offset other, double radius) =>
      distanceTo(other) < radius;

  // Moves this [Offset] towards [towards] by [distance], with optional [rotation] and [from] origin.
  Offset moveTowards({
    required Offset towards,
    required double distance,
    Offset? from,
    double rotation = 0,
  }) {
    final direction = (towards - (from ?? this)).direction + rotation;
    return (from ?? this) + Offset.fromDirection(direction, distance);
  }

  // Moves this [Offset] by [distance] in [direction] radians, with optional [from] origin.
  Offset move(double distance, double direction, {Offset? from}) =>
      (from ?? this) + Offset.fromDirection(direction, distance);
}