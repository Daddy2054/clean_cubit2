import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login/presentation/controller/login_controller.dart';
import '../../features/auth/login/presentation/ui/login_screen.dart';
import '../../features/auth/signup/presentation/controller/sign_up_controller.dart';
import '../../features/auth/signup/presentation/ui/sign_up_screen.dart';
import '../../features/dashboard/presentation/ui/dashboard_screen.dart';
import '../../features/setting/presentation/ui/setting_screen.dart';
import '../../features/todo/presentation/controller/todo_add_controller.dart';
import '../../features/todo/presentation/ui/todo_add_screen.dart';
import '../../features/todo/presentation/ui/todo_detail_screen.dart';
import '../../features/todo/presentation/ui/todo_screen.dart';
import '../service_locator.dart';
import 'route_name.dart';

class GoRouterProvider {
  final RouteObserver _shellRouteObserver;

  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey(debugLabel: 'root');
  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey(debugLabel: 'shell');

  GoRouterProvider(this._shellRouteObserver);
  GoRouter goRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          name: loginRoute,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt.get<LoginController>(),
              child: LoginScreen(
                key: state.pageKey,
              ),
            );
          },
          routes: [
            GoRoute(
              path: 'signUp',
              name: signUpRoute,
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => getIt.get<SignUpController>(),
                  child: SignUpScreen(
                    key: state.pageKey,
                  ),
                );
              },
            ),
          ],
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          observers: [_shellRouteObserver],
          builder: (context, state, child) {
            return DashboardScreen(
              key: state.pageKey,
              child: child,
            );
          },
          routes: [
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: '/',
              name: homeRoute,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: ToDoScreen(
                    key: state.pageKey,
                  ),
                );
              },
              routes: [
                GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: 'addToDo',
                  name: addToDoRoute,
                  builder: (context, state) {
                    return BlocProvider(
                      create: (context) => getIt.get<ToDoAddController>(),
                      child: ToDoAddScreen(
                        key: state.pageKey,
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: 'detail/:id',
                  name: detailToDoRoute,
                  builder: (context, state) {
                    final id = int.parse(state.pathParameters['id'].toString());
                    return ToDoDetailScreen(
                      key: state.pageKey,
                      id: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/setting',
              name: settingRoute,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: SettingScreen(
                    key: state.pageKey,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
