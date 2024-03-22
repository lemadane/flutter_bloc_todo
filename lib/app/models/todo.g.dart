// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      title: json['title'] as String,
      description: json['description'] as String,
    )
      ..id = json['id'] as String?
      ..status = $enumDecode(_$TodoStatusEnumMap, json['status'])
      ..dateCreated = DateTime.parse(json['date_created'] as String)
      ..dateUpdated = DateTime.parse(json['date_updated'] as String);

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': _$TodoStatusEnumMap[instance.status]!,
      'date_created': instance.dateCreated.toIso8601String(),
      'date_updated': instance.dateUpdated.toIso8601String(),
    };

const _$TodoStatusEnumMap = {
  TodoStatus.pending: 'pending',
  TodoStatus.ongoing: 'ongoing',
  TodoStatus.done: 'done',
};
