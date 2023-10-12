import 'package:amazon_clone/common/widgets/custom_loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/products_details_screen.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  final HomeServices homeServices = HomeServices();
  ProductMd? productMd;

  fetchDealOfTheDay() async {
    productMd = await homeServices.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  @override
  void initState() {
    fetchDealOfTheDay();
    super.initState();
  }

  void navigateToDetailsPage() {
    Navigator.pushNamed(
      context,
      ProductsDetailsScreen.routeName,
      arguments: productMd,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToDetailsPage,
      child: productMd == null
          ? const CustomLoader()
          : productMd!.name.isEmpty
              ? const SizedBox()
              : Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 10, top: 16, bottom: 6),
                      child: const Text(
                        "Deal Of the Day",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Image.network(
                      productMd!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        "\$888.44",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 16, top: 6, right: 14),
                      child: const Text(
                        "Ibrahim",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: productMd!.images
                            .map(
                              (e) => Image.network(
                                e,
                                fit: BoxFit.fitWidth,
                                width: 100,
                                height: 100,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "See all deals",
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}
