import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/app/bloc/todo_bloc.dart';
import 'package:flutter_bloc_todo/app/bloc/todo_event.dart';

class ReusableAlertDialog extends StatelessWidget {
  final String id;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final bool isUpdate;

  const ReusableAlertDialog({
    super.key,
    required this.id,
    required this.titleController,
    required this.descriptionController,
    required this.isUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isUpdate ? 'Update Todo' : 'Add Todo'),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Enter Todo Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter Todo Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (isUpdate) {
              BlocProvider.of<TodoBloc>(context).add(
                UpdateTodoEvent(
                  id: id,
                  title: titleController.text,
                  description: descriptionController.text,
                ),
              );
            } else {
              BlocProvider.of<TodoBloc>(context).add(
                AddTodoEvent(
                  title: titleController.text,
                  description: descriptionController.text,
                ),
              );
            }
            titleController.clear();
            descriptionController.clear();
            Navigator.pop(context);
          },
          child: Text(isUpdate ? 'Update Todo' : 'Add Todo'),
        ),
      ],
    );
  }
}
