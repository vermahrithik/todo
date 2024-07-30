import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'taskModel.g.dart';

@JsonSerializable()
class TaskModel {
  String? task;
  String? taskNote;
  bool isChecked;

  TaskModel({
    required this.task,
    required this.taskNote,
    this.isChecked = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
