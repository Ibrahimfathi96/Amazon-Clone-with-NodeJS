import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  List list = [
    "https://cdn.pixabay.com/photo/2020/06/26/12/21/macbook-pro-5342546_1280.png",
    "https://cdn.pixabay.com/photo/2020/06/26/12/21/macbook-pro-5342546_1280.png",
    "https://cdn.pixabay.com/photo/2020/06/26/12/21/macbook-pro-5342546_1280.png",
    "https://cdn.pixabay.com/photo/2020/06/26/12/21/macbook-pro-5342546_1280.png",
    "https://cdn.pixabay.com/photo/2020/06/26/12/21/macbook-pro-5342546_1280.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16),
              child: const Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  Text(
                    "See all",
                    style: TextStyle(
                      color: GlobalVariables.selectedNavBarColor,
                    ),
                  ),
                  Icon(
                    Icons.double_arrow_outlined,
                    size: 18,
                    color: GlobalVariables.selectedNavBarColor,
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => ProduceItemWidget(
              imageUrl: list[index],
            ),
            itemCount: list.length,
          ),
        ),
      ],
    );
  }
}
