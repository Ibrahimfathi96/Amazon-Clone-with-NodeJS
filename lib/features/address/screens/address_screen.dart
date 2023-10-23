// ignore_for_file: deprecated_member_use

import 'package:amazon_clone/common/widgets/app_bar_leading.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/AddressScreen';
  const AddressScreen({super.key});

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
  List<PaymentItem> paymentItems = [];

  @override
  void dispose() {
    super.dispose();
    _flatBuildingController.dispose();
    _areaStreetController.dispose();
    _pincodeController.dispose();
    _townCityController.dispose();
  }

  void onGooglePayResult(paymentResult) {}
  @override
  Widget build(BuildContext context) {
    var address = '101 Fake Street';
    // var address = context.watch<UserProvider>().user.address;
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
                        width: double.infinity,
                        height: 60,
                        paymentConfiguration: snapshot.data!,
                        paymentItems: paymentItems,
                        type: GooglePayButtonType.buy,
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        onPaymentResult: onGooglePayResult,
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
                        width: double.infinity,
                        height: 60,
                        paymentConfiguration: snapshot.data!,
                        paymentItems: paymentItems,
                        type: ApplePayButtonType.buy,
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        onPaymentResult: onGooglePayResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
