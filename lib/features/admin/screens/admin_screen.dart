import 'package:amazon_clone/common/widgets/custom_bottom_bar_icon.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/screens/posts_screen.dart';
import 'package:amazon_clone/features/admin/widgets/admin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/AdminScreen';

  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int page = 0;
  List<Widget> pages = [
    const PostsScreen(),
    const Scaffold(
      body: Center(
        child: Text("Analytics Screen"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Orders Screen"),
      ),
    ),
  ];

  void updatePage(int updatedPage) {
    setState(() {
      page = updatedPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0XFF1DC9C1),
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: AdminAppBar(),
          ),
          body: pages[page],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: page,
            selectedItemColor: GlobalVariables.selectedNavBarColor,
            unselectedItemColor: GlobalVariables.unselectedNavBarColor,
            backgroundColor: GlobalVariables.backgroundColor,
            iconSize: 32,
            onTap: updatePage,
            items: [
              //Posts
              BottomNavigationBarItem(
                label: '',
                icon: CustomBottomBarIcon(
                  currentPage: 0,
                  isSelected: page == 0 ? true : false,
                  icon: const Icon(
                    Icons.home_outlined,
                  ),
                ),
              ),
              //Analytics
              BottomNavigationBarItem(
                label: '',
                icon: CustomBottomBarIcon(
                  currentPage: 1,
                  isSelected: page == 1 ? true : false,
                  icon: const Icon(
                    Icons.analytics_outlined,
                  ),
                ),
              ),
              //Orders
              BottomNavigationBarItem(
                label: '',
                icon: CustomBottomBarIcon(
                  currentPage: 2,
                  isSelected: page == 2 ? true : false,
                  icon: const Icon(
                    Icons.all_inbox_outlined,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
