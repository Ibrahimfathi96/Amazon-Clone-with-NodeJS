import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/admin/screens/posts_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_view.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );
    case CustomBottomBar.routeName:
      return MaterialPageRoute(
        builder: (context) => const CustomBottomBar(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AdminScreen(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AddProductScreen(),
      );
    case PostsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const PostsScreen(),
      );
    case SplashScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => CategoryDealsScreen(
          category: category,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text(
              'Screen does not exist,\ntry to navigate to another valid screen',
            ),
          ),
        ),
      );
  }
}
