import 'package:amazon_clone/common/widgets/app_bar_leading.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;
  static const String routeName = '/CategoryDealsScreen';

  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          leading: const AppBarLeading(),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              "Keep Shopping for ${widget.category}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              padding: EdgeInsets.only(left: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.4,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => Text("Hello"),
            ),
          )
        ],
      ),
    );
  }
}
