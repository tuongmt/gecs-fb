import 'package:ecommerce_app/constants/routes.dart';
import 'package:ecommerce_app/models/product_model/product_model.dart';
import 'package:ecommerce_app/screens/product_detail/product_detail.dart';
import 'package:ecommerce_app/utils/numbers.dart';
import 'package:flutter/material.dart';

class BestProductItem extends StatefulWidget {
  final ProductModel singleProduct;
  const BestProductItem({super.key, required this.singleProduct});

  @override
  State<BestProductItem> createState() => _BestProductItemState();
}

class _BestProductItemState extends State<BestProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: [
          MaterialButton(
            onPressed: () {
              Routes.instance.push(
                  widget: ProductDetail(singleProduct: widget.singleProduct),
                  context: context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.network(
                widget.singleProduct.image,
                width: 80,
                height: 80,
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            widget.singleProduct.name,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Price: ${numberFormatter(widget.singleProduct.price)}"),
          const SizedBox(
            height: 16.0,
          ),
          SizedBox(
            width: 120,
            height: 40,
            child: OutlinedButton(
                onPressed: () {
                  Routes.instance.push(
                      widget:
                          ProductDetail(singleProduct: widget.singleProduct),
                      context: context);
                },
                child: const Text(
                  "Buy",
                )),
          )
        ],
      ),
    );
  }
}
