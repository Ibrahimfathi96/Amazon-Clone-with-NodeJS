import 'package:amazon_clone/common/widgets/custom_bottom_bar_icon.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomBar extends StatefulWidget {
  static const String routeName = '/actual-home-screen';

  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int page = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const Scaffold(
      body: Center(
        child: Text("Cart Screen"),
      ),
    ),
    const AccountScreen(),
  ];

  void updatePage(int updatedPage) {
    setState(() {
      page = updatedPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 32,
        onTap: updatePage,
        items: [
          //HOME PAGE
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
          //CART
          BottomNavigationBarItem(
            label: '',
            icon: CustomBottomBarIcon(
              currentPage: 1,
              isSelected: page == 1 ? true : false,
              icon: badges.Badge(
                badgeContent: Text(
                  userCartLength.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.red,
                  elevation: 0,
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
          ),
          //ACCOUNT
          BottomNavigationBarItem(
            label: '',
            icon: CustomBottomBarIcon(
              currentPage: 2,
              isSelected: page == 2 ? true : false,
              icon: const Icon(
                Icons.person_outline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
