// ignore_for_file: use_build_context_synchronously

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/myuser_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  //User Sign Up
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    try {
      MyUser user = MyUser(
        id: "",
        name: name,
        email: email,
        password: password,
        address: "",
        type: "",
        token: "",
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
}
