import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/orders_model.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  //! ADD / SELL PRODUCTS
  Future<void> sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required String category,
    required double price,
    required double quantity,
    required List<File> images,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final cloudinary =
          CloudinaryPublic('doehu91ch', 'u6eviuek', cache: false);
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(response.secureUrl);
      }
      ProductMd productMd = ProductMd(
        name: name,
        description: description,
        quantity: quantity,
        price: price,
        images: imageUrls,
        category: category,
      );
      http.Response response = await http.post(
        Uri.parse('$uri/admin/addProduct'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.token
        },
        body: productMd.toJson(),
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

  //! GET ALL PRODUCTS
  Future<List<ProductMd>> fetchAllProducts(
      {required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<ProductMd> productsList = [];
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/admin/getAllProducts"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.token
        },
      );
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

  //! FETCHING ALL THE ORDERS
  Future<List<OrdersMd>> fetchAllOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<OrdersMd> ordersList = [];
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/admin/getAllOrders"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.token
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(response.body).length; i++) {
            ordersList.add(
              OrdersMd.fromJson(
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
    return ordersList;
  }

  //! CHANGING STATUS OF A PRODUCT FOR THE STEPPER
  void changeOrdersStatus({
    required BuildContext context,
    required int status,
    required OrdersMd ordersMd,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/admin/changeOrdersStatus"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.token
        },
        body: jsonEncode({'id': ordersMd.id, 'status': status}),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (err) {
      showSnakeBar(context, err.toString());
    }
  }
}
