import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_resturant_dash/core/routing/routes.dart';
import 'package:my_resturant_dash/features/home/ui/home_screen.dart';
import 'package:my_resturant_dash/features/login/view/login_screen.dart';
import 'package:my_resturant_dash/features/root/root.dart';
import '../../features/my_resturant/view/my_restu_screen.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Routes.root,
        builder: (context, state) => const Root(),
      ),
      GoRoute(
        path: Routes.loginView,
        builder: (context, state) => LoginView(),
      ),
      GoRoute(
        path: Routes.homeScreen,
        builder: (context, state) => DashboardHomeScreen(),
      ),
      GoRoute(
        path: Routes.myresturantpage,
        builder: (context, state) => MyResturantMainScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('No route defined for ${state.uri.toString()}'),
      ),
    ),
  );
}
