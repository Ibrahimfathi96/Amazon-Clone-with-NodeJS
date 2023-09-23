import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/splash/splash_screen.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';

class AmazonClone extends StatefulWidget {
  const AmazonClone({super.key});

  @override
  State<AmazonClone> createState() => _AmazonCloneState();
}

class _AmazonCloneState extends State<AmazonClone> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => generateRoute(settings),
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
      ),
      home: const SplashScreen(),
    );
  }
}
