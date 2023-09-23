import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/app_bar_bottom_widget.dart';
import 'package:amazon_clone/features/account/widgets/app_bar_upper_widget.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4),
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 42,
              margin: const EdgeInsets.only(left: 16, bottom: 12, top: 6),
              child: Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 2,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search Amazon.in",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(top: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.black38,
                        width: 1,
                      ),
                    ),
                    prefixIcon: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: 42,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Icon(
              Icons.mic,
              size: 26,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
