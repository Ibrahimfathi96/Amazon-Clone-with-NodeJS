import 'package:amazon_clone/common/rating.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/features/product_details/widgets/product_details_appbar.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductsDetailsScreen extends StatefulWidget {
  static const String routeName = '/ProductsDetailsScreen';
  final ProductMd productMd;

  const ProductsDetailsScreen({super.key, required this.productMd});

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  final ProductDetailsServices services = ProductDetailsServices();
  num avgRating = 0;
  num myRating = 0;

  @override
  void initState() {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.productMd.ratings!.length; i++) {
      totalRating += widget.productMd.ratings![i].rating;
      if (widget.productMd.ratings![i].userId == user.id) {
        myRating = widget.productMd.ratings![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.productMd.ratings!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0XFF1DC9C1),
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(62),
            child: ProductsDetailsAppBar(),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.productMd.id!,
                    ),
                    CustomRating(rating: avgRating),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  widget.productMd.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              CarouselSlider(
                items: widget.productMd.images.map((e) {
                  return Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.network(
                        e,
                        fit: BoxFit.contain,
                        height: 200,
                      ),
                    );
                  });
                }).toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: 300,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                height: 6,
                color: Colors.black12,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    text: "Deal Price:",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "${widget.productMd.price} EGP",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.productMd.description,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                height: 6,
                color: Colors.black12,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomButton(
                  text: "Buy Now",
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomButton(
                  color: const Color.fromRGBO(254, 216, 19, 1),
                  text: "Add To Cart",
                  onTap: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                height: 6,
                color: Colors.black12,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 10),
                child: Text(
                  "Rate The Product",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: RatingBar.builder(
                  initialRating: myRating.toDouble(),
                  minRating: 1,
                  allowHalfRating: true,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: GlobalVariables.secondaryColor,
                  ),
                  onRatingUpdate: (rating) {
                    services.rateProduct(
                      context: context,
                      productMd: widget.productMd,
                      rating: rating,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
