import 'package:amazon_clone/common/widgets/app_bar_leading.dart';
import 'package:amazon_clone/common/widgets/custom_loader.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widgets/search_app_bar.dart';
import 'package:amazon_clone/features/search/widgets/search_products.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/SearchScreen';
  final String searchQuery;

  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductMd>? productsList;
  final SearchServices searchServices = SearchServices();

  fetchSearchedProducts() async {
    productsList = await searchServices.fetchAllProducts(
      context: context,
      query: widget.searchQuery,
    );
    setState(() {});
  }

  // void navigateToSearchScreen(String query) {
  //   Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  // }

  @override
  void initState() {
    super.initState();
    fetchSearchedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            leading: const AppBarLeading(),
            flexibleSpace: SearchAppBar(
              onFieldSubmitted: (val) {},
            ),
          ),
        ),
        body: productsList == null
            ? const CustomLoader()
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: productsList!.length,
                      itemBuilder: (context, index) => SearchedProductsItem(
                        productMd: productsList![index],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
