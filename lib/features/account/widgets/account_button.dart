import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final bool isLogOut;

  const AccountButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.isLogOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0),
          borderRadius: BorderRadius.circular(50),
          color: isLogOut ? Colors.red : Colors.white,
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onTap,
          child: Text(
            buttonText,
            style: TextStyle(
              color: isLogOut ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
