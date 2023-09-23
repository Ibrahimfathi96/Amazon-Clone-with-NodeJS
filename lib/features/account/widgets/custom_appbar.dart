import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/app_bar_bottom_widget.dart';
import 'package:amazon_clone/features/account/widgets/app_bar_upper_widget.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: const Column(
        children: [
          AppBarUpperWidget(),
          AppBarBottomWidget(),
        ],
      ),
    );
  }
}
