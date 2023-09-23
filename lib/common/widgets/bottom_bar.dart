import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

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
            icon: BottomBarIcon(
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
            icon: BottomBarIcon(
              currentPage: 1,
              isSelected: page == 1 ? true : false,
              icon: const badges.Badge(
                badgeContent: Text(
                  '2',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.red,
                  elevation: 0,
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
          ),
          //ACCOUNT
          BottomNavigationBarItem(
            label: '',
            icon: BottomBarIcon(
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

class BottomBarIcon extends StatelessWidget {
  final double currentPage;
  final Widget icon;
  final bool isSelected;

  const BottomBarIcon({
    super.key,
    required this.currentPage,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    double bottomBarWidth = 50;
    double bottomBarBorderWidth = 5;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: bottomBarWidth,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: isSelected
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        icon,
      ],
    );
  }
}
