import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

enum TodoStatus { pending, ongoing, done }

@JsonSerializable()
// ignore: must_be_immutable
class Todo extends Equatable {
  String? id;
  final String title;
  final String description;
  var status = TodoStatus.pending;
  @JsonKey(name: 'date_created')
  var dateCreated = DateTime.now();
  @JsonKey(name: 'date_updated')
  var dateUpdated = DateTime.now();

  Todo({
    required this.title,
    required this.description,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        dateCreated,
        dateUpdated,
      ];
}
