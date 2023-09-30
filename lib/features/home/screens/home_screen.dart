import 'package:amazon_clone/features/home/widgets/carousel_images.dart';
import 'package:amazon_clone/features/home/widgets/deal_of_the_day.dart';
import 'package:amazon_clone/features/home/widgets/home_appbar.dart';
import 'package:amazon_clone/features/home/widgets/top_categories.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: HomeAppBar(
            onFieldSubmitted: navigateToSearchScreen,
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            HomeTopCategories(),
            CarouselImagesSlider(),
            DealOfTheDay()
          ],
        ),
      ),
    );
  }
}
