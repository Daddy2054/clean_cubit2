import '../../../core/exception/failure.dart';
import '../../../core/extension/date_formatter.dart';
import '../data/dto/todo_response.dart';
import '../data/dto/todos_response.dart';
import '../data/repository/itodo_repository.dart';
import '../domain/model/todo_item.dart';
import '../domain/model/todo_model.dart';
import '../domain/model/todo_page.dart';
import 'itodo_service.dart';

class ToDoService implements IToDoService {
  final IToDoRepository _toDoRepository;

  ToDoService(this._toDoRepository);

  @override
  Future<ToDoItem> addToDo(Map<String, dynamic> body) async {
    try {
      final response = await _toDoRepository.addToDo(body);
      final result = _mapToDoItem(response);

      return result;
    } on Failure catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteToDo(Map<String, dynamic> queries) async {
    try {
      final response = await _toDoRepository.deleteToDo(queries);

      return response.deleted;
    } on Failure catch (_) {
      rethrow;
    }
  }

  @override
  Future<ToDoItem> getToDo(int id) async {
    try {
      final response = await _toDoRepository.getToDo(id);
      final result = _mapToDoItem(response);

      return result;
    } on Failure catch (_) {
      rethrow;
    }
  }

  @override
  Future<ToDoModel> getToDos(int userId) async {
    try {
      final response = await _toDoRepository.getToDos(userId);
      final result = _mapToDoModel(response);

      return result;
    } on Failure catch (_) {
      rethrow;
    }
  }

  @override
  Future<ToDoModel> getToDoList(Map<String, dynamic> queries) async {
    try {
      final response = await _toDoRepository.getToDoList(queries);
      final result = _mapToDoModel(response);

      return result;
    } on Failure catch (_) {
      rethrow;
    }
  }

  @override
  Future<ToDoItem> updateToDo(Map<String, dynamic> queries) async {
    try {
      final response = await _toDoRepository.updateToDo(queries);
      final result = _mapToDoItem(response);

      return result;
    } on Failure catch (_) {
      rethrow;
    }
  }

  ToDoItem _mapToDoItem(ToDoResponse response) {
    return ToDoItem(
      id: int.parse(response.id),
      userId: int.parse(response.userId),
      title: response.title,
      body: response.body,
      note: response.note,
      status: response.status == '1' ? true : false,
      createdAt: response.createdAt.dateFormatter(response.createdAt),
      updatedAt: response.updatedAt.dateFormatter(response.updatedAt),
    );
  }

  ToDoModel _mapToDoModel(ToDosResponse response) {
    final data = response.data;

    return ToDoModel(
      todos: data
          .map((todo) => ToDoItem(
                id: int.parse(todo.id),
                userId: int.parse(todo.userId),
                title: todo.title,
                body: todo.body,
                note: todo.note,
                status: todo.status == '1' ? true : false,
                createdAt: todo.createdAt.dateFormatter(todo.createdAt),
                updatedAt: todo.updatedAt.dateFormatter(todo.updatedAt),
              ))
          .toList(),
      page: ToDoPage(
        currentPage: response.currentPage,
        perPage: response.perPage,
        lastPage: response.lastPage,
        total: response.total,
      ),
    );
  }
}
