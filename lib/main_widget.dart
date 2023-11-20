import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/enum/app_theme.dart';
import 'core/route/go_router_provider.dart';
import 'core/service_locator.dart';
import 'core/theme/color_schemes.dart';
import 'features/setting/presentation/controller/setting_controller.dart';
import 'features/setting/presentation/state/setting_state.dart';
import 'features/todo/presentation/controller/todo_controller.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final route = getIt.get<GoRouterProvider>();
    final goRouter = route.goRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<ToDoController>()),
        BlocProvider(create: (context) => getIt.get<SettingController>()),
      ],
      child: BlocBuilder<SettingController, SettingState>(
        builder: (context, state) {
          return MaterialApp.router(
        title: 'Todo App',
            routerConfig: goRouter,
            themeMode: state.appTheme == AppTheme.light
                ? ThemeMode.light
                : ThemeMode.dark,
        theme: ThemeData(
          colorScheme: lightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme,
          useMaterial3: true,
        ),
                  );
        },
      ),
    );
  }
}
