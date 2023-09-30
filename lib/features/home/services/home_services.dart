import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<ProductMd>> fetchAllProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<ProductMd> productsList = [];
    try {
      http.Response response = await http.get(
        Uri.parse(
          "$uri/api/products?category=$category",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.token
        },
      );
      if (!context.mounted) return productsList;
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(response.body).length; i++) {
            productsList.add(
              ProductMd.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (err) {
      showSnakeBar(context, err.toString());
    }
    return productsList;
  }
}
