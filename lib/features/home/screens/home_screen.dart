import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/home/widgets/home_appbar.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HomeAppBar(),
            AddressBox(),
          ],
        ),
      ),
    );
  }
}
