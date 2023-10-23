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

class AddressServices {
  //! SAVE USER ADDRESS
  Future<void> saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/saveUserAddress'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.user.token
        },
        body: jsonEncode({
          'address': address,
        }),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          MyUser user = userProvider.user.copyWith(
            address: jsonDecode(response.body)['address'],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (err) {
      showSnakeBar(context, err.toString());
    }
  }

  //! PLACE ORDER
  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response =
          await http.post(Uri.parse("$uri/api/orderProduct"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                "x-auth-token": userProvider.user.token,
              },
              body: jsonEncode({
                'cart': userProvider.user.cart,
                'address': address,
                'totalPrice': totalSum,
              }));
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnakeBar(
            context,
            'Your order has been placed successfully',
          );
          MyUser user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (err) {
      showSnakeBar(context, err.toString());
    }
  }

  //! DELETE A PRODUCT
  void deleteProduct({
    required BuildContext context,
    required ProductMd productMd,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/admin/deleteProduct"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.token
        },
        body: jsonEncode({
          'id': productMd.id,
        }),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (err) {
      showSnakeBar(context, err.toString());
    }
  }
}
