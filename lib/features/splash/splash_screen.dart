import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/auth/screens/auth_view.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/SplashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthServices authServices = AuthServices();

  void navigateAfterThreeSeconds() {
    Future.delayed(
      const Duration(seconds: 3),
      () => authServices.getUserData(context),
    ).then((value) {
      Provider.of<UserProvider>(context, listen: false).user.token.isNotEmpty
          ? Navigator.pushNamedAndRemoveUntil(
              context,
              CustomBottomBar.routeName,
              (route) => false,
            )
          : Navigator.pushNamedAndRemoveUntil(
              context,
              AuthScreen.routeName,
              (route) => false,
            );
    });
  }

  @override
  void initState() {
    navigateAfterThreeSeconds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: Center(
        child: Image.asset(
          "assets/white_splash.png",
          width: size * 0.7,
        ),
      ),
    );
  }
}
