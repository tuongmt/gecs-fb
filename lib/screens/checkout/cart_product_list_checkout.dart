// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_app/constants/routes.dart';
import 'package:ecommerce_app/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:ecommerce_app/provider/app_provider.dart';
import 'package:ecommerce_app/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce_app/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:ecommerce_app/stripe_helper/stripe_helper.dart';
import 'package:ecommerce_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProductListCheckout extends StatefulWidget {
  const CartProductListCheckout({super.key});

  @override
  State<CartProductListCheckout> createState() =>
      _CartProductListCheckoutState();
}

class _CartProductListCheckoutState extends State<CartProductListCheckout> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.blue),
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.blue),
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Pay by card",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
              title: "Continue",
              onPressed: () async {
                if (groupValue == 1) {
                  bool value = await FirebaseFirestoreHelper.instance
                      .uploadOrderedProductFirebase(
                          appProvider.getBuyProductList,
                          "Cash on Delivery",
                          context);
                  appProvider.clearBuyProduct();
                  if (value) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Routes.instance.push(
                          widget: const CustomBottomBar(), context: context);
                    });
                  }
                } else {
                  int value = double.parse(
                          appProvider.totalPriceBuyProductList().toString())
                      .round()
                      .toInt();
                  String totalPrice = (value * 100).toString();
                  await StripeHelper.instance.makePayment(totalPrice, context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
