import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/add_product_appbar.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  static const String routeName = '/EditProductScreen';
  final ProductMd productMd;
  const EditProduct({
    super.key,
    required this.productMd,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  final GlobalKey<FormState> editProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];
  List<File> images = [];
  late String selectedCategory;

  selectImages() async {
    var result = await pickImages();
    setState(() {
      images = result;
    });
  }

  void editProducts() async {
    if (editProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProducts(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        category: widget.productMd.category,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        images: images,
        onSuccess: () async {
          if (!context.mounted) return;
          showSnakeBar(context, "Product Added Successfully!");
          Navigator.pushNamedAndRemoveUntil(
            context,
            AdminScreen.routeName,
            (route) => false,
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.productMd.category;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("${const JsonDecoder().convert(widget.productMd.toJson())}");
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AddProductAppBar(title: "Edit Product"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: editProductFormKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 20),
            child: Column(
              children: [
                images.isNotEmpty
                    ? DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          height: 150,
                          child: CarouselSlider(
                            items: images
                                .map(
                                  (e) => Builder(
                                    builder: (context) => Image.file(
                                      e,
                                      fit: BoxFit.cover,
                                      height: 500,
                                    ),
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CarouselSlider(
                                  items: widget.productMd.images
                                      .map(
                                        (e) => Builder(
                                          builder: (context) => Image.network(
                                            e,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  options: CarouselOptions(),
                                ),
                              ),
                              Text(
                                "Click to edit current Product Images",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  controller: productNameController,
                  hintText: widget.productMd.name,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: descriptionController,
                  hintText: widget.productMd.description,
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: quantityController,
                  hintText: widget.productMd.quantity.toString(),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: priceController,
                  hintText: widget.productMd.price.toString(),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: GlobalVariables.greyBackgroundColor,
                    ),
                  ),
                  child: DropdownButton(
                    value: selectedCategory,
                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: "Sell",
                  onTap: editProducts,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
