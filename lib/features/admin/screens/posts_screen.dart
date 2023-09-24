import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  static const String routeName = '/PostsScreen';

  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    void navigateToAddProduct() {
      Navigator.pushNamed(context, AddProductScreen.routeName);
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddProduct();
        },
        tooltip: "Add a Product",
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text("Products"),
      ),
    );
  }
}
