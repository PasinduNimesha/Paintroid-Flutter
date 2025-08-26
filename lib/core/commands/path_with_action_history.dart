import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:paintroid/core/json_serialization/converter/path_action_converter.dart';
import 'package:paintroid/core/json_serialization/converter/path_with_action_history_converter.dart';

class PathWithActionHistory {
  PathWithActionHistory();

  final Path path = Path();

  @PathActionConverter()
  final List<PathAction> actions = <PathAction>[];

  void moveTo(double x, double y) {
    actions.add(MoveToAction(x, y));
    path.moveTo(x, y);
  }

  void lineTo(double x, double y) {
    actions.add(LineToAction(x, y));
    path.lineTo(x, y);
  }

  void close() {
    actions.add(const CloseAction());
    path.close();
  }

  Map<String, dynamic> toJson() =>
      const PathWithActionHistoryConverter().toJson(this);

  factory PathWithActionHistory.fromJson(Map<String, dynamic> json) =>
      const PathWithActionHistoryConverter().fromJson(json);

  @override
  bool operator ==(Object other) =>
      other is PathWithActionHistory &&
      const ListEquality<PathAction>().equals(actions, other.actions);

  @override
  int get hashCode => const ListEquality<PathAction>().hash(actions);
}

abstract class PathAction {
  const PathAction();
}

class MoveToAction extends PathAction {
  final double x;
  final double y;

  const MoveToAction(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is MoveToAction && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}

class LineToAction extends PathAction {
  final double x;
  final double y;

  const LineToAction(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is LineToAction && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}

class CloseAction extends PathAction {
  const CloseAction();
}