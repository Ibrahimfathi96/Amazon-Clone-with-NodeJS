import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomBottomBarIcon extends StatelessWidget {
  final double currentPage;
  final Widget icon;
  final bool isSelected;

  const CustomBottomBarIcon({
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
