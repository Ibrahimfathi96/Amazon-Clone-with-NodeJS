import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(ProductMd productMd) {
    productDetailsServices.addToCart(
      context: context,
      productMd: productMd,
    );
  }

  void decreaseQuantity(ProductMd productMd) {
    cartServices.removeFromCart(
      context: context,
      productMd: productMd,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final productMd = ProductMd.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
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
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => decreaseQuantity(productMd),
                      child: Container(
                        width: 36,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Container(
                          width: 36,
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(
                            quantity.toString(),
                          )),
                    ),
                    InkWell(
                      onTap: () => increaseQuantity(productMd),
                      child: Container(
                        width: 36,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
