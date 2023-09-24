import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/widgets/list_category_item.dart';
import 'package:flutter/material.dart';

class HomeTopCategories extends StatefulWidget {
  const HomeTopCategories({super.key});

  @override
  State<HomeTopCategories> createState() => _HomeTopCategoriesState();
}

class _HomeTopCategoriesState extends State<HomeTopCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 80,
      child: ListView.builder(
        itemExtent: 78,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ListCategoryItem(
          title: GlobalVariables.categoryImages[index]['title'] ?? '',
          imageUrl: GlobalVariables.categoryImages[index]['image'] ?? '',
        ),
        itemCount: GlobalVariables.categoryImages.length,
      ),
    );
  }
}
