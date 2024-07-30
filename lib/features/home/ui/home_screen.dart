import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:my_resturant_dash/features/editing_password/view/editing_pass_screen.dart';
import 'package:my_resturant_dash/features/my_resturant/view/my_restu_screen.dart';
import '../../Editing_Resturant_Info/view/editing_screen.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({Key? key}) : super(key: key);

  @override
  _DashboardHomeScreenState createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  final PageController pageController = PageController();
  final SideMenuController sideMenuController = SideMenuController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      sideMenuController.changePage(pageController.page!.toInt());
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    sideMenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          Container(
            width: 250,
            color: Colors.redAccent[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SideMenu(
                  controller: sideMenuController,
                  style: SideMenuStyle(
                    showHamburger: false,
                    displayMode: SideMenuDisplayMode.auto,
                    hoverColor: Colors.red[700],
                    selectedColor: Colors.yellow[700],
                    selectedTitleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    selectedIconColor: Colors.white,
                    unselectedTitleTextStyle:
                        const TextStyle(color: Colors.white70),
                    unselectedIconColor: Colors.white54,
                    backgroundColor: Colors.transparent,
                    openSideMenuWidth: 250,
                    compactSideMenuWidth: 70,
                    toggleColor: Colors.yellow,
                    itemHeight: 60,
                    iconSize: 24,
                  ),
                  items: [
                    SideMenuItem(
                      title: 'معلومات المطعم',
                      icon: Icon(Icons.restaurant_menu, color: Colors.white),
                      onTap: (index, controller) {
                        pageController.jumpToPage(0);
                        controller.changePage(index);
                      },
                    ),
                    SideMenuItem(
                      title: 'تعديل معلومات المطعم',
                      icon: Icon(Icons.edit, color: Colors.white),
                      onTap: (index, controller) {
                        pageController.jumpToPage(1);
                        controller.changePage(index);
                      },
                    ),
                    SideMenuItem(
                      title: 'تعديل المعلومات الخاصة',
                      icon: Icon(Icons.lock, color: Colors.white),
                      onTap: (index, controller) {
                        pageController.jumpToPage(2);
                        controller.changePage(index);
                      },
                    ),
                  ],
                  onDisplayModeChanged: (mode) {
                    print(mode);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                const MyResturantMainScreen(),
                EditRestaurantInfoView(),
                ChangePasswordScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
