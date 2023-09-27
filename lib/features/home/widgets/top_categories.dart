import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/home/widgets/list_category_item.dart';
import 'package:flutter/material.dart';

class HomeTopCategories extends StatelessWidget {
  const HomeTopCategories({super.key});

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      CategoryDealsScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 80,
      child: ListView.builder(
        itemExtent: 78,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => navigateToCategoryPage(
            context,
            GlobalVariables.categoryImages[index]['title']!,
          ),
          child: ListCategoryItem(
            title: GlobalVariables.categoryImages[index]['title'] ?? '',
            imageUrl: GlobalVariables.categoryImages[index]['image'] ?? '',
          ),
        ),
        itemCount: GlobalVariables.categoryImages.length,
      ),
    );
  }
}
