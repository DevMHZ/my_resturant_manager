import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:my_resturant_dash/core/theming/colors.dart';
import 'package:my_resturant_dash/features/home/ui/home_screen.dart';
import 'package:my_resturant_dash/features/login/view/login_screen.dart';
import 'package:my_resturant_dash/features/my_resturant/controller/my_restu_controller.dart';

class RestDashApp extends StatelessWidget {
  const RestDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Root(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginView(),
        ),
        GoRoute(
          path: '/homeScreen',
          builder: (context, state) => const DashboardHomeScreen(),
        ),
      ],
    );

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp.router(
          textDirection: TextDirection.rtl,
          title: 'Dashboard Screen',
          theme: ThemeData(
            primaryColor: AppColor.appBlueColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          routeInformationProvider: _router.routeInformationProvider,
        );
      },
    );
  }
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          if (snapshot.data == true) {
            context.go('/home'); // Navigate to home if logged in
          } else {
            context.go('/login'); // Navigate to login if not logged in
          }
          return Container(); // Placeholder container to satisfy the builder requirement.
        }
      },
    );
  }

  Future<bool> _checkLoginStatus() async {
    var box = await Hive.openBox('loginBox');
    String? subDomain = box.get('subDomain');
    String? id = box.get('id');

    if (subDomain != null && id != null) {
      print("THE ID IS $id");
      print("THE SUB DOMAIN IS $subDomain");
      Get.put(MyResturantMainScreenController())
          .fetchMyResturantData(subDomain);
      return true;
    }
    return false;
  }
}
