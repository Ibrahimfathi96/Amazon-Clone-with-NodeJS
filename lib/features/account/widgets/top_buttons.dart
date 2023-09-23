import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class CustomTopButton extends StatelessWidget {
  const CustomTopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              buttonText: "Your Orders",
              onTap: () {},
            ),
            AccountButton(
              buttonText: "Your Seller",
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              buttonText: "Log out",
              onTap: () {},
            ),
            AccountButton(
              buttonText: "Your Wish List",
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
