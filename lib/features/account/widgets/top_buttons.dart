// ignore_for_file: use_build_context_synchronously

import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
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
              buttonText: "Turn Seller",
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              buttonText: "Your Wishlist",
              onTap: () {},
            ),
            AccountButton(
              buttonText: "Log Out",
              onTap: () => AuthServices().signOut(context),
              isLogOut: true,
            ),
          ],
        ),
      ],
    );
  }
}
