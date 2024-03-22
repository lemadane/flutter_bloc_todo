import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {}

class InitialEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class FetchListEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class FetchTodoEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class AddTodoEvent extends AppEvent {
  final String title;
  final String description;

  AddTodoEvent({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [
        title,
        description,
      ];
}

class UpdateTodoEvent extends AppEvent {
  final String id;
  final String title;
  final String description;

  UpdateTodoEvent({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
      ];
}

class DeleteTodoEvent extends AppEvent {
  final String id;

  DeleteTodoEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
