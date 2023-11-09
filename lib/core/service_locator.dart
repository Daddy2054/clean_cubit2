import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../features/todo/application/itodo_service.dart';
import '../features/todo/application/todo_service.dart';
import '../features/todo/data/api/itodo_api_service.dart';
import '../features/todo/data/api/todo_api_service.dart';
import '../features/todo/data/repository/itodo_repository.dart';
import '../features/todo/data/repository/todo_repository.dart';
import '../features/todo/presentation/controller/todo_add_controller.dart';
import '../features/todo/presentation/controller/todo_controller.dart';
import 'route/go_router_provider.dart';

final getIt = GetIt.instance;

void serviceLocatorInit() {
 // getIt.registerSingleton<RouteObserver>(RouteObserver<ModalRoute>());
//  getIt.registerFactory(() => GoRouterProvider(getIt.get<RouteObserver>()));
  getIt.registerFactory(() => GoRouterProvider());

 getIt.registerSingleton<Client>(Client());

  //Feature ToDo
  getIt.registerLazySingleton<IToDoApiService>(() => ToDoApiService(getIt<Client>()));
  getIt.registerLazySingleton<IToDoRepository>(() => ToDoRepository(getIt<IToDoApiService>()));
  getIt.registerLazySingleton<IToDoService>(() => ToDoService(getIt<IToDoRepository>()));

  // ToDO Controller
  getIt.registerFactory<ToDoController>(() => ToDoController(getIt<IToDoService>()));
  getIt.registerFactory<ToDoAddController>(() => ToDoAddController(getIt<IToDoService>()));
}