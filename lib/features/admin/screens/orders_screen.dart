import 'package:amazon_clone/common/widgets/custom_loader.dart';
import 'package:amazon_clone/features/account/widgets/product_item_widget.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/order_details/screens/order_details.dart';
import 'package:amazon_clone/models/orders_model.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/OrdersScreen';

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<OrdersMd>? ordersList;
  final AdminServices services = AdminServices();

  void fetchAllOrders() async {
    ordersList = await services.fetchAllOrders(context: context);
    setState(() {});
  }

  @override
  void initState() {
    fetchAllOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ordersList == null
        ? const CustomLoader()
        : GridView.builder(
            itemCount: ordersList?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final order = ordersList![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OrderDetailsScreen.routeName,
                    arguments: order,
                  );
                },
                child: SizedBox(
                  height: 140,
                  child: ProduceItemWidget(
                    imageUrl: order.products[0].images[0],
                  ),
                ),
              );
            },
          );
  }
}
