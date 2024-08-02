import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:people/database/database.dart';
import 'package:people/features/createPerson/view/create_person_page.dart';
import 'package:people/features/editGroup/view/edit_group_page.dart';
import 'package:people/features/editPerson/view/edit_person_page.dart';
import '../../features/createGroup/view/create_group_page.dart';
import '../../features/dashboard/view/dashboard_page.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter(this._databaseHandler);
  final DatabaseHandler _databaseHandler;
  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
          name: AppRoutes.dashboard,
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return DashboardPage(databaseHandler: _databaseHandler);
          }),
      GoRoute(
          name: AppRoutes.editGroup,
          path: '/edit_group',
          builder: (BuildContext context, GoRouterState state) {
            final extras = state.extra! as Map<String, dynamic>;
            final groupId = extras['groupId'] as int;
            return EditGroupPage(databaseHandler: _databaseHandler, groupId: groupId);
          }),
      GoRoute(
          name: AppRoutes.editPerson,
          path: '/edit_person',
          builder: (BuildContext context, GoRouterState state) {
            final extras = state.extra! as Map<String, dynamic>;
            final personId = extras['personId'] as int;
            return EditPersonPage(databaseHandler: _databaseHandler, personId: personId);
          }),
      GoRoute(
          name: AppRoutes.createGroup,
          path: '/create_group',
          builder: (BuildContext context, GoRouterState state) {
            return CreateGroupPage(databaseHandler: _databaseHandler);
          }),
      GoRoute(
          name: AppRoutes.createPerson,
          path: '/create_person',
          builder: (BuildContext context, GoRouterState state) {
            return  CreatePersonPage(databaseHandler: _databaseHandler);
          }),
    ],
  );

  void back({dynamic arguments}) => router.pop(arguments);
}
