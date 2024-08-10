import 'dart:convert';

import 'package:ecommerce_app/models/product_model/product_model.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String orderId;
  String userId;
  String payment;
  List<ProductModel> products;
  String status;
  double totalPrice;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.payment,
    required this.products,
    required this.status,
    required this.totalPrice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productsMap = json["products"];
    return OrderModel(
      orderId: json["orderId"],
      userId: json["userId"],
      payment: json["payment"],
      products: productsMap.map((e) => ProductModel.fromJson(e)).toList(),
      status: json["status"],
      totalPrice: json["totalPrice"] == null
          ? 0
          : double.parse(json["totalPrice"].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "userId": userId,
        "payment": payment,
        "products": products,
        "status": status,
        "totalPrice": totalPrice,
      };
}
