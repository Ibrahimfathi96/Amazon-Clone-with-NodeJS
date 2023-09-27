import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  Future<void> sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required String category,
    required double price,
    required double quantity,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      //TODO: NOT WORKING / DIDN'T UPLOAD THE PHOTOS.
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
      if (!context.mounted) return;
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnakeBar(context, "Product Added Successfully!");
          Navigator.pop(context);
        },
      );
    } catch (err) {
      if (!context.mounted) return;
      showSnakeBar(context, err.toString());
    }
  }
}
