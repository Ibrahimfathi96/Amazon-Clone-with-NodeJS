// ignore_for_file: use_build_context_synchronously

import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:amazon_clone/features/auth/screens/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTopButton extends StatelessWidget {
  const CustomTopButton({super.key});

  void signOut(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove("x-auth-token");
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      debugPrint("Error during logout: $e");
    }
  }

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
              onTap: () {
                signOut(context);
              },
              isLogOut: true,
            ),
          ],
        ),
      ],
    );
  }
}
