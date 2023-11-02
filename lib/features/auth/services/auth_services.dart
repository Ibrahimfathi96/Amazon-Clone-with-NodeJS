// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/my_user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  //! User Sign-Up
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      MyUser user = MyUser(
        id: "",
        name: name,
        email: email,
        password: password,
        address: "",
        type: "",
        token: "",
        cart: [],
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      debugPrint("===============SignUp==================================");
      debugPrint(
          "response: $response, Status-Code: ${response.statusCode}, Body: ${response.body}");
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnakeBar(
            context,
            'Account Created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnakeBar(
        context,
        "catch-errors:${e.toString()}",
      );
    }
  }

  //! User Sign-In
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          "password": password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      debugPrint("===============SignIn==================================");
      debugPrint(
          "response: $response, Status-Code: ${response.statusCode}, Body: ${response.body}");
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
          await preferences.setString(
            "x-auth-token",
            jsonDecode(response.body)['token'],
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            CustomBottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnakeBar(
        context,
        "catch-errors:${e.toString()}",
      );
    }
  }

  //! Get user Data
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("x-auth-token");

      if (token == null) {
        token = '';
        preferences.setString("x-auth-token", token);
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": token
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userResponse = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": token
          },
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnakeBar(
        context,
        "catch-errors:${e.toString()}",
      );
    }
  }
}
