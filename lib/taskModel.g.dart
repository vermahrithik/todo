// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
  task: json['task'].toString(),
  taskNote: json['taskNote'].toString(),
  isChecked: json['isChecked'] as bool? ?? false,
);

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
  'task': instance.task,
  'isChecked': instance.isChecked,
};
