import 'package:amazon_clone/common/rating.dart';
import 'package:amazon_clone/common/widgets/app_bar_leading.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductsDetailsScreen extends StatefulWidget {
  static const String routeName = '/ProductsDetailsScreen';
  final ProductMd productMd;

  const ProductsDetailsScreen({super.key, required this.productMd});

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  const CustomRating(rating: 4),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                initialRating: 0,
                minRating: 1,
                allowHalfRating: true,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: GlobalVariables.secondaryColor,
                ),
                onRatingUpdate: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsDetailsAppBar extends StatelessWidget {
  const ProductsDetailsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const AppBarLeading(),
      flexibleSpace: Container(
        padding: const EdgeInsets.only(left: 4),
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 50, bottom: 12, top: 8),
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      elevation: 2,
                      child: TextFormField(
                        onFieldSubmitted: (value) {},
                        decoration: InputDecoration(
                          hintText: "Search Amazon.in",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          prefixIcon: InkWell(
                            onTap: () {
                              debugPrint("SearchIcon Clicked");
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: IconButton(
                    onPressed: () {
                      debugPrint("Mic Clicked");
                    },
                    icon: const Icon(
                      Icons.mic,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
