import 'package:amazon_clone/common/widgets/custom_loader.dart';
import 'package:amazon_clone/features/account/widgets/product_item_widget.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/screens/edit_product.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  static const String routeName = '/PostsScreen';

  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminServices adminServices = AdminServices();
  List<ProductMd>? products;

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void navigateToEditProduct(ProductMd productMd) {
    Navigator.pushNamed(
      context,
      EditProduct.routeName,
      arguments: productMd,
    );
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context: context);
    setState(() {});
  }

  void deleteProduct(ProductMd productMd, int index) {
    adminServices.deleteProduct(
      context: context,
      productMd: productMd,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const CustomLoader()
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateToAddProduct();
              },
              tooltip: "Add a Product",
              child: const Icon(Icons.add),
            ),
            body: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final productData = products![index];
                return GestureDetector(
                  onTap: () {
                    navigateToEditProduct(products![index]);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: ProduceItemWidget(
                          imageUrl: productData.images[0],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                productData.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(),
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  deleteProduct(productData, index),
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
