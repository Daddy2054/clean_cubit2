import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../features/auth/signup/application/isign_up_service.dart';
import '../features/auth/signup/application/sign_up_service.dart';
import '../features/auth/signup/data/api/isign_up_api_service.dart';
import '../features/auth/signup/data/api/sign_up_api_service.dart';
import '../features/auth/signup/data/repository/isign_up_repository.dart';
import '../features/auth/signup/data/repository/sign_up_repository.dart';
import '../features/auth/signup/presentation/controller/sign_up_controller.dart';
import '../features/auth/signup/presentation/state/sign_up_state.dart';
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
  getIt.registerSingleton<RouteObserver>(
    RouteObserver<ModalRoute>(),
  );
  getIt.registerFactory(
    () => GoRouterProvider(
      getIt.get<RouteObserver>(),
    ),
  );
  getIt.registerSingleton<Client>(Client());

  //Feature ToDo
  getIt.registerLazySingleton<IToDoApiService>(
    () => ToDoApiService(
      getIt<Client>(),
    ),
  );
  getIt.registerLazySingleton<IToDoRepository>(
    () => ToDoRepository(
      getIt<IToDoApiService>(),
    ),
  );
  getIt.registerLazySingleton<IToDoService>(
    () => ToDoService(
      getIt<IToDoRepository>(),
    ),
  );

  // ToDO Controller
  getIt.registerFactory<ToDoController>(
    () => ToDoController(
      getIt<IToDoService>(),
    ),
  );
  getIt.registerFactory<ToDoAddController>(
    () => ToDoAddController(
      getIt<IToDoService>(),
    ),
  );

  //Feature SignUp
  getIt.registerLazySingleton<ISignUpApiService>(
    () => SignUpApiService(
      getIt<Client>(),
    ),
  );
  getIt.registerLazySingleton<ISignUpRepository>(
    () => SignUpRepository(
      getIt<ISignUpApiService>(),
    ),
  );
  getIt.registerLazySingleton<ISignUpService>(
    () => SignUpService(
      getIt<ISignUpRepository>(),
    ),
  );

  //  SignUp Controller
  getIt.registerFactory<SignUpController>(
    () => SignUpController(
      const SignUpState(),
      getIt<ISignUpService>(),
    ),
  );

  // //Feature Login
  // getIt.registerLazySingleton<ILoginApiService>(
  //     () => LoginApiService(getIt<Client>()));
  // getIt.registerLazySingleton<ILoginRepository>(
  //     () => LoginRepository(getIt<ILoginApiService>()));
  // getIt.registerLazySingleton<ILoginService>(
  //     () => LoginService(getIt<ILoginRepository>()));

  // //  Login Controller
  // getIt.registerFactory<LoginController>(() => LoginController(
  //       getIt.get<ILoginService>(),
  //     ));

  // //Feature setting

  // getIt.registerFactory<SettingController>(() => SettingController());
}
