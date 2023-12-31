import 'dart:io';

import '../../../../core/exception/failure.dart';
import '../../../../core/extension/http_response_error.dart';
import '../api/itodo_api_service.dart';
import '../dto/todo_delete_response.dart';
import '../dto/todo_response.dart';
import '../dto/todos_response.dart';
import 'itodo_repository.dart';

class ToDoRepository implements IToDoRepository {
  final IToDoApiService _toDoApiService;

  ToDoRepository(this._toDoApiService);

  @override
  Future<ToDoResponse> addToDo(Map<String, dynamic> body) async {
    try {
      final response = await _toDoApiService.addToDo(body);

      if (response.statusCode != HttpStatus.created) {
        throw Failure(message: response.httpResponseError());
      }

      return toDoResponseFromJson(response.body);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ToDoDeleteResponse> deleteToDo(Map<String, dynamic> queries) async {
    try {
      final response = await _toDoApiService.deleteToDo(queries);

      if (response.statusCode != HttpStatus.ok) {
        throw Failure(message: response.httpResponseError());
      }

      return toDoDeleteResponseFromJson(response.body);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ToDoResponse> getToDo(int id) async {
    try {
      final response = await _toDoApiService.getToDo(id);

      if (response.statusCode != HttpStatus.ok) {
        throw Failure(message: response.httpResponseError());
      }

      return toDoResponseFromJson(response.body);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ToDosResponse> getToDos(int userId) async {
    try {
      final response = await _toDoApiService.getToDos(userId);

      if (response.statusCode != HttpStatus.ok) {
        throw Failure(message: response.httpResponseError());
      }

      return toDosResponseFromJson(response.body);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ToDoResponse> updateToDo(Map<String, dynamic> queries) async {
    try {
      final response = await _toDoApiService.updateToDo(queries);

      if (response.statusCode != HttpStatus.accepted) {
        throw Failure(message: response.httpResponseError());
      }

      return toDoResponseFromJson(response.body);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ToDosResponse> getToDoList(Map<String, dynamic> queries) async {
    try {
      final response = await _toDoApiService.getToDoList(queries);

      if (response.statusCode != HttpStatus.ok) {
        throw Failure(message: response.httpResponseError());
      }

      return toDosResponseFromJson(response.body);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
