// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/my_user_model.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsServices {
  void rateProduct(
      {required BuildContext context,
      required ProductMd productMd,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/productRating'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.token
        },
        body: jsonEncode(
          {
            'id': productMd.id!,
            'rating': rating,
          },
        ),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (err) {
      showSnakeBar(context, err.toString());
    }
  }

  void addToCart({
    required BuildContext context,
    required ProductMd productMd,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/addToCart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.user.token
        },
        body: jsonEncode(
          {
            'id': productMd.id!,
          },
        ),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          MyUser user = userProvider.user.copyWith(
            cart: jsonDecode(response.body)['cart'],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (err) {
      showSnakeBar(context, err.toString());
    }
  }
}
