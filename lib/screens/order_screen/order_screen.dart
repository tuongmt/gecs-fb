import 'package:ecommerce_app/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:ecommerce_app/models/order_model/order_model.dart';
import 'package:ecommerce_app/utils/numbers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Your Orders",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream:
            Stream.fromFuture(FirebaseFirestoreHelper.instance.getUserOrder()),
        // future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              !snapshot.hasData) {
            return const Center(
              child: Text("No Order Found"),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    iconColor: Colors.blue,
                    childrenPadding: EdgeInsets.zero,
                    tilePadding: EdgeInsets.zero,
                    collapsedShape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue, width: 2.2),
                        borderRadius: BorderRadius.circular(12.0)),
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue, width: 2.2),
                        borderRadius: BorderRadius.circular(12.0)),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          padding: EdgeInsets.zero,
                          height: 100,
                          width: 100,
                          color: Colors.blue.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              orderModel.products[0].image,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderModel.products[0].name,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "Total Price: ${numberFormatter(orderModel.totalPrice)}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Order Status: ",
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  Text(
                                    orderModel.status,
                                    style: orderModel.status == "Canceled"
                                        ? const TextStyle(
                                            fontSize: 14.0, color: Colors.red)
                                        : orderModel.status == "Completed"
                                            ? const TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.green)
                                            : const TextStyle(fontSize: 14.0),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              orderModel.status == "Pending"
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      onPressed: () async {
                                        await FirebaseFirestoreHelper.instance
                                            .updateOrderStatus(
                                                orderModel, "Canceled");
                                        orderModel.status = "Canceled";
                                        setState(() {});
                                      },
                                      child: const Text("Cancel Order"))
                                  : SizedBox.fromSize(),
                              orderModel.status == "Delivery"
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        await FirebaseFirestoreHelper.instance
                                            .updateOrderStatus(
                                                orderModel, "Completed");
                                        orderModel.status = "Completed";
                                        setState(() {});
                                      },
                                      child: const Text("Delivered Order"))
                                  : SizedBox.fromSize(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    children: orderModel.products.isNotEmpty
                        ? [
                            const Text(
                              "Order Details",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(color: Colors.blue),
                            ...orderModel.products.map(
                              (singleProduct) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.zero,
                                            height: 100,
                                            width: 100,
                                            color: Colors.blue.withOpacity(0.3),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                singleProduct.image,
                                                width: 80,
                                                height: 80,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  singleProduct.name,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Price: ${numberFormatter(singleProduct.price)}",
                                                      style: const TextStyle(
                                                        fontSize: 12.0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 48.0,
                                                    ),
                                                    Text(
                                                      "Quantity: ${numberFormatter((singleProduct.qty!).toDouble())}",
                                                      style: const TextStyle(
                                                          fontSize: 12.0),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8.0,
                                                ),
                                                Text(
                                                  "Subtotal Price: ${numberFormatter((singleProduct.price * singleProduct.qty!))}",
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ],
                                  ),
                                );
                              },
                            )
                          ]
                        : [],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
