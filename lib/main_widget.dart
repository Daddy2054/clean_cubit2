import 'package:clean_cubit2/core/route/go_router_provider.dart';
import 'package:clean_cubit2/core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/color_schemes.dart';
import 'features/todo/presentation/controller/todo_controller.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final route = getIt.get<GoRouterProvider>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<ToDoController>())
      ],
      child: MaterialApp.router(
        title: 'Todo App',
        routerConfig: route.goRouter(),
        theme: ThemeData(
          colorScheme: lightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme,
          useMaterial3: true,
        ),
      ),
    );
  }
}
