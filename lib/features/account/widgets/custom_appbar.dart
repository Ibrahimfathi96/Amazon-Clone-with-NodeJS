import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/below_app_bar_widget.dart';
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/amazon_in.png",
                  width: 120,
                  height: 46,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 16,
                      ),
                      child: Icon(
                        Icons.notifications_outlined,
                      ),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ],
          ),
          const BelowAppBarWidget(),
        ],
      ),
    );
  }
}
