import 'package:amazon_clone/common/widgets/app_bar_leading.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AddProductAppBar extends StatelessWidget {
  const AddProductAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const AppBarLeading(),
      centerTitle: true,
      title: const Text(
        "Add Product",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
      ),
    );
  }
}
