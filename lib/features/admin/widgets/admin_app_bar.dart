// ignore_for_file: use_build_context_synchronously

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

class AdminAppBar extends StatelessWidget {
  const AdminAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              "assets/amazon_in.png",
              width: 130,
              height: 46,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              children: [
                const Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => AuthServices().signOut(context),
                  icon: const Icon(
                    Icons.logout,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
