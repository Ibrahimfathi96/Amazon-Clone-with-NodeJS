import 'package:amazon_clone/common/widgets/rating.dart';
import 'package:amazon_clone/features/product_details/screens/products_details_screen.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchedProductsItem extends StatelessWidget {
  final ProductMd productMd;

  const SearchedProductsItem({super.key, required this.productMd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            ProductsDetailsScreen.routeName,
            arguments: productMd,
          );
        },
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                productMd.images[0],
                height: 135,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        productMd.name,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 6),
                      child: const CustomRating(
                        rating: 4,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 6),
                      child: Text(
                        '${productMd.price} EGP',
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 6),
                      child: const Text(
                        'Eligible for FREE Shipping',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'In Stock',
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
