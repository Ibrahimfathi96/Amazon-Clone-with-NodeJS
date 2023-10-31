// ignore_for_file: deprecated_member_use

import 'package:amazon_clone/common/widgets/app_bar_leading.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/AddressScreen';
  final String totalAmount;

  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();
  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaStreetController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _townCityController = TextEditingController();

  final Future<PaymentConfiguration> _applePayConfigFuture =
      PaymentConfiguration.fromAsset('applepay.json');
  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('gpay.json');

  String addressToBeUse = '';
  String addressCash = "";

  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _flatBuildingController.dispose();
    _areaStreetController.dispose();
    _pincodeController.dispose();
    _townCityController.dispose();
  }

  void onPayResult(paymentResult) {
    var userAddress =
        Provider.of<UserProvider>(context, listen: false).user.address;
    if (userAddress.isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUse,
      );
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUse,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void onPayCash(userAddress) {
    if (userAddress.isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressCash,
      );
    }

    addressServices.placeOrder(
      context: context,
      address: userAddress,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUse = '';
    bool isFormValid = _flatBuildingController.text.trim().isNotEmpty ||
        _areaStreetController.text.trim().isNotEmpty ||
        _pincodeController.text.trim().isNotEmpty ||
        _townCityController.text.trim().isNotEmpty;
    if (isFormValid) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUse =
            '${_flatBuildingController.text}, ${_areaStreetController.text}, ${_townCityController.text} - ${_pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUse = addressFromProvider;
    } else {
      showSnakeBar(context, "Error");
    }
    debugPrint(addressToBeUse);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: const AppBarLeading(),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: 'Flat, House no, Building, Company',
                      controller: _flatBuildingController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      hintText: 'Area, Street',
                      controller: _areaStreetController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      hintText: 'Pincode',
                      controller: _pincodeController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      hintText: 'Town/City',
                      controller: _townCityController,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              FutureBuilder<PaymentConfiguration>(
                future: _googlePayConfigFuture,
                builder: (context, snapshot) => snapshot.hasData
                    ? GooglePayButton(
                        onPressed: () => payPressed(address),
                        width: double.infinity,
                        height: 60,
                        paymentConfiguration: snapshot.data!,
                        paymentItems: paymentItems,
                        type: GooglePayButtonType.buy,
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        onPaymentResult: onPayResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              FutureBuilder<PaymentConfiguration>(
                future: _applePayConfigFuture,
                builder: (context, snapshot) => snapshot.hasData
                    ? ApplePayButton(
                        onPressed: () => payPressed(address),
                        width: double.infinity,
                        height: 60,
                        paymentConfiguration: snapshot.data!,
                        paymentItems: paymentItems,
                        type: ApplePayButtonType.buy,
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        onPaymentResult: onPayResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              ElevatedButton(
                onPressed: () {
                  if (address.isNotEmpty) {
                    onPayCash(address);
                  } else if (_addressFormKey.currentState!.validate()) {
                    addressCash =
                        '${_flatBuildingController.text}, ${_areaStreetController.text}, ${_townCityController.text} - ${_pincodeController.text}';
                    onPayCash(addressCash);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.wallet,
                            size: 36,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Pay with Wallet Cash",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$ ${widget.totalAmount}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
