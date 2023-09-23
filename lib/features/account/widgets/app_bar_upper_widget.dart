import 'package:flutter/material.dart';

class AppBarUpperWidget extends StatelessWidget {
  const AppBarUpperWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              "assets/amazon_in.png",
              width: 130,
              height: 46,
              color: Colors.black,
            ),
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
                  size: 30,
                ),
              ),
              Icon(
                Icons.search,
                size: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
