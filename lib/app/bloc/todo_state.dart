import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_todo/app/models/todo_model.dart';

abstract class AppState extends Equatable {}

class InitialState extends AppState {
  static var instanceCount = 0;

  InitialState() {
    instanceCount++;
    print('InitialState.instanceCount = $instanceCount');
  }

  @override
  List<Object?> get props => [];

  dispose() {
    instanceCount--;
    print('InitialState.instanceCount = $instanceCount');
  }
}

class BusyState extends AppState {
  static var instanceCount = 0;
  
  BusyState() {
    instanceCount++;
    print('BusyState.instanceCount = $instanceCount');
  }

  @override
  List<Object?> get props => [];

  dispose() {
    instanceCount--;
    print('BusyState.instanceCount = $instanceCount');
  }
}

class DoneState extends AppState {
  static var instanceCount = 0;

  final List<Todo> todos;

  DoneState({required this.todos}) {
    instanceCount++;
    print('DoneState.instanceCount = $instanceCount');
  }

  dispose() {
    instanceCount--;
    print('DoneState.instanceCount = $instanceCount');
  }

  @override
  List<Object?> get props => [todos];
}

class ErrorState extends AppState {
  final String errorMessage;

  ErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
