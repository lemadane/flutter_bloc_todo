import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/app/bloc/todo_bloc.dart';
import 'package:flutter_bloc_todo/app/bloc/todo_event.dart';
import 'package:flutter_bloc_todo/app/bloc/todo_state.dart';
import 'package:flutter_bloc_todo/app/components/reusable_alert_dialog.dart';
import 'package:flutter_bloc_todo/app/models/todo_model.dart';

class TodoHomePage extends StatelessWidget {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  TodoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocBuilder<TodoBloc, AppState>(
        builder: (context, state) {
          
          switch (state.runtimeType) {
            case const (InitialState):
              BlocProvider.of<TodoBloc>(context).add(FetchListEvent());
              return const SizedBox();
            
            case const (BusyState):
              return const Center(
                child: CircularProgressIndicator(),
              );
            
            case const (DoneState):
              print('TodoDoneState');
              final todos = (state as DoneState).todos;
              print('todos.length = ${todos.length}');
              final listView = ListView.builder(
                itemCount: todos.length,
                itemBuilder: _itemBuilder,
              );
              return listView;
            
            default:
              return const Center(
                child: Text('Something went wrong!'),
              );
          }
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ReusableAlertDialog(
                id: UniqueKey().toString(),
                isUpdate: false,
                titleController: _titleController,
                descriptionController: _descriptionController,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    List<Todo> todos = (BlocProvider.of<TodoBloc>(context).state as DoneState)
        .todos;
    Todo todo = todos[index];
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        BlocProvider.of<TodoBloc>(context).add(
          DeleteTodoEvent(id: todo.id as String),
        );
      },
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        child: ListTile(
          title: Text(
            todo.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            todo.description,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  _titleController.text = todo.title;
                  _descriptionController.text = todo.description;
                
                  return ReusableAlertDialog(
                    id: todo.id as String,
                    isUpdate: true,
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                  );
                },
              ); // showDialog
            }, // onPressed
            icon: const Icon(Icons.edit),
          ),
        ),
      ),
    ) as Widget?;
  }
}
