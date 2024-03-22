import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/app/bloc/todo_event.dart';
import 'package:flutter_bloc_todo/app/bloc/todo_state.dart';
import 'package:flutter_bloc_todo/app/services/todo_services.dart';

class TodoBloc extends Bloc<AppEvent, AppState> {
  final _todoServices = TodoServices();

  TodoBloc() : super(InitialState()) {
    on<FetchListEvent>(_onFetchList);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  _onFetchList(event, emit) async {
    try {
      emit(BusyState());
      final todoList = await _todoServices.fetchTodoList();
      emit(DoneState(todos: todoList));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  _onAddTodo(event, emit) async {
    try {
      emit(BusyState());
      final todoList = await _todoServices.addTodo(
        event.title,
        event.description,
      );
      emit(DoneState(todos: todoList));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  _onUpdateTodo(event, emit) async {
    try {
      emit(BusyState());
      final todoList = await _todoServices.updateTodo(
        event.id,
        event.title,
        event.description
      );
      emit(DoneState(todos: todoList));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  _onDeleteTodo(event, emit) async {
    try {
      print ('_onDeleteTodo');
      emit(BusyState());
      final todoList = await _todoServices.deleteTodo(event.id);
      print('todoList.length = ${todoList.length}');
      emit(DoneState(todos: todoList));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
