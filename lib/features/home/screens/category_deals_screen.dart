import 'package:amazon_clone/common/widgets/app_bar_leading.dart';
import 'package:amazon_clone/common/widgets/custom_loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;
  static const String routeName = '/CategoryDealsScreen';

  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<ProductMd>? productsList;
  final HomeServices homeServices = HomeServices();

  fetchCategoryProducts() async {
    productsList = await homeServices.fetchAllProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  void initState() {
    fetchCategoryProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          leading: const AppBarLeading(),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: productsList == null
          ? const CustomLoader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Keep Shopping for ${widget.category}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: productsList!.length,
                    padding: const EdgeInsets.only(left: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final product = productsList![index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 130,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(product.images[0]),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(
                              left: 0,
                              top: 6,
                              right: 16,
                            ),
                            child: Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
