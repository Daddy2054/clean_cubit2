import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/exception/failure.dart';
import '../../application/itodo_service.dart';
import '../state/todo_state.dart';

class ToDoController extends Cubit<ToDoState> {
  final IToDoService _toDoService;

  ToDoController(this._toDoService) : super(const ToDoState());

  void getToDos() async {
    try {
      emit(state.copyWith(isLoading: true));

      final result = await _toDoService.getToDos(1);

      emit(state.copyWith(todos: result.todos, isLoading: false));
    } on Failure catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMsg: e.message,
      ));
    }
  }

  void getToDoList() async {
    try {
      final oldItems = state.todos;

      if (oldItems.isNotEmpty && !state.isScrolling) return;

      if (state.isFetching) return;

      emit(state.copyWith(isLoading: true, isFetching: true));

      final pageNumber = state.currentPage == 0 ? 1 : state.currentPage + 1;
      final query = {
        'user_id': '1',
        'perPage': '10',
        'pageNumber': pageNumber.toString()
      };

      final result = await _toDoService.getToDoList(query);

      emit(
        state.copyWith(
          todos: [...oldItems, ...result.todos],
          currentPage: result.page.currentPage,
          lastPage: result.page.lastPage,
          isLoading: false,
          isFetching: false,
          isDeleted: false,
        ),
      );
    } on Failure catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isFetching: false,
        errorMsg: e.message,
      ));
    }
  }

  void refetchToDos() {
    emit(
      state.copyWith(
          todos: [],
          currentPage: 0,
          lastPage: 0,
          isLoading: false,
          isDeleted: false,
          isFetching: false),
    );

    getToDoList();
  }

  void getToDo(int id) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        isDeleted: false,
      ));

      final result = await _toDoService.getToDo(id);

      final formData = {
        'id': result.id.toString(),
        'user_id': result.userId.toString(),
        'title': result.title,
        'body': result.body,
        'note': result.note,
        'created_at': result.createdAt,
        'updated_at': result.updatedAt,
      };

      setToDoStatus(result.status);

      emit(state.copyWith(
        todo: result,
        formData: formData,
        isLoading: false,
      ));
    } on Failure catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMsg: e.message,
      ));
    }
  }

  void updateToDo() async {
    try {
      emit(state.copyWith(isLoading: true));

      final result = await _toDoService.updateToDo(state.formData);

      final oldData = state.todos;

      emit(state.copyWith(
        todos: [
          for (final item in oldData)
            if (item.id == result.id)
              item.copyWith(
                  userId: result.userId,
                  title: result.title,
                  body: result.body,
                  note: result.note,
                  status: result.status,
                  updatedAt: result.updatedAt)
            else
              item
        ],
        todo: result,
        isUpdated: true,
        isLoading: false,
      ));
    } on Failure catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isUpdated: false,
        errorMsg: e.message,
      ));
    }
  }

  void deleteToDo(int id, int userId) async {
    try {
      emit(state.copyWith(isLoading: true));

      final queries = {
        'id': id.toString(),
        'user_id': userId.toString(),
      };
      final result = await _toDoService.deleteToDo(queries);

      emit(state.copyWith(
        isDeleted: result,
        isLoading: false,
      ));
    } on Failure catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isDeleted: false,
        errorMsg: e.message,
      ));
    }
  }

  void setIsEnabled() {
    emit(state.copyWith(isReadonly: !state.isReadonly));
  }

  void setToDoStatus(bool value) {
    emit(state.copyWith(todoStatus: value));
    setFormData(
      key: 'status',
      value: value ? '1' : '0',
    );
  }

  void setFormData({
    required String key,
    required dynamic value,
  }) {
    emit(state.copyWith(formData: {
      ...state.formData,
      ...{key: value}
    }));
  }

  void setIsScrolling(bool value) {
    emit(state.copyWith(isScrolling: value));
  }

  void clearState() {
    emit(
      state.copyWith(
        isLoading: false,
        isUpdated: false,
        isDeleted: false,
        isReadonly: true,
        // isReadonly: false,
        todoStatus: false,
        isFetching: false,
        isScrolling: false,
        formData: {},
        //   todos: [],  //lesson 35.Update ToDo.mp4
      ),
    );
  }
}
