import 'dart:convert';
import 'package:flutter_bloc_todo/app/constants/api_constants.dart';
import 'package:flutter_bloc_todo/app/models/todo_model.dart';
import 'package:flutter_bloc_todo/app/utilities/json_to_object.dart';
import 'package:http/http.dart' as http;

class TodoServices {
  Future<List<Todo>> fetchTodoList() async {
    try {
      final response = await http.get(
        _getUri(null),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final result = jsonToObject(response.body, Todo.fromJson);
        return List<Todo>.from(result);
      } else {
        throw Exception('HTTP status: ${response.statusCode}');
      }
    } catch (err) {
      print('${err.toString()}');
      return [];
    }
  }

  Future<Todo?> fetchTodo(final String id) async {
    try {
      final response = await http.get(
        _getUri(id),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final result = jsonToObject(response.body, Todo.fromJson);
        return result as Todo;
      } else {
        throw Exception('HTTP status: ${response.statusCode}');
      }
    } catch (err) {
      print('${err.toString()}');
      return null;
    }
  }

  Future<List<Todo>> addTodo(
    final String title,
    final String description
 ) async {
    try {
      final response = await http.post(
        _getUri(null),
        headers: headers,
        body: jsonEncode({
          'title': title,
          'description': description,
        }),
      );
      if (response.statusCode == 200) {
        final todos = jsonToObject(response.body, Todo.fromJson);
        print('todos = $todos');
        return List<Todo>.from(todos);
      } else {
        throw Exception('HTTP status: ${response.statusCode}');
      }
    } catch (err) {
      print('${err.toString()}');
      return [];
    }
  }

  Future<List<Todo>> deleteTodo(final String id) async {
    try {
      final response = await http.delete(
        _getUri(id),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final todos = jsonToObject(response.body, Todo.fromJson);
        return List<Todo>.from(todos);
      } else {
        throw Exception('HTTP status: ${response.statusCode}');
      }
    } catch (err) {
      print('${err.toString()}');
      return [];
    }
  }

  Future<List<Todo>> updateTodo(
    final String id,
    final String? title,
    final String? description,
  ) async {
    try {
      final response = await http.patch(
        _getUri(id),
        headers: headers,
        body: jsonEncode({
          'title': title,
          'description': description,
        }),
      );
      if (response.statusCode == 200) {
        final todos = jsonToObject(response.body, Todo.fromJson);
        return List<Todo>.from(todos);
      } else {
        throw Exception('HTTP status: ${response.statusCode}');
      }
    } catch (err) {
      print('${err.toString()}');
      return [];
    }
  }

  Uri _getUri(String? id) {
    return Uri(
      path:
          id != null ? '/$currentVersion/todos/$id' : '/$currentVersion/todos',
      scheme: scheme,
      host: host,
      port: port,
    );
  }
}
