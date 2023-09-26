import 'dart:io';

import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';

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
    try {
      final CloudinaryPublic cloudinary =
          CloudinaryPublic('dl7vuxust', 'dp9lglom');
      List<String> imagesUrl = [];
      for (int i = 0; i < 0; i++) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imagesUrl.add(response.secureUrl);
      }
      ProductMd productMd = ProductMd(
        name: name,
        description: description,
        quantity: quantity,
        price: price,
        images: imagesUrl,
        category: category,
      );
    } catch (err) {
      if (!context.mounted) return;
      showSnakeBar(context, err.toString());
    }
  }
}
