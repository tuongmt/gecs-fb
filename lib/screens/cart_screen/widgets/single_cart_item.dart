import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/models/product_model/product_model.dart';
import 'package:ecommerce_app/provider/app_provider.dart';
import 'package:ecommerce_app/utils/numbers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  // int qty = 1;

  @override
  void initState() {
    // qty = widget.singleProduct.qty ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.blue, width: 2.4)),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 127,
            color: Colors.blue.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.network(
                widget.singleProduct.image,
                width: 100,
                height: 100,
              ),
            ),
          )),
          Expanded(
            flex: 3,
            child: Container(
              height: 127,
              color: Colors.white.withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.singleProduct.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                CupertinoButton(
                                  onPressed: () {
                                    if (widget.singleProduct.qty! > 1) {
                                      // setState(() {
                                      //   qty--;
                                      // });
                                      appProvider.updateQty(
                                          widget.singleProduct,
                                          widget.singleProduct.qty! - 1);
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 12,
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                                Text(
                                  widget.singleProduct.qty.toString(),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                CupertinoButton(
                                  onPressed: () {
                                    // setState(() {
                                    //   qty++;
                                    // });
                                    appProvider.updateQty(widget.singleProduct,
                                        widget.singleProduct.qty! + 1);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 12,
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (!appProvider.getFavouriteProductList
                                    .contains(widget.singleProduct)) {
                                  appProvider.addFavouriteProduct(
                                      widget.singleProduct);
                                  showMessage("Added to wishlist");
                                } else {
                                  appProvider.removeFavouriteProduct(
                                      widget.singleProduct);
                                  showMessage("Removed from wishlist");
                                }
                              },
                              child: Text(
                                appProvider.getFavouriteProductList
                                        .contains(widget.singleProduct)
                                    ? "Remove from wishlist"
                                    : "Add to wishlist",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          numberFormatter((widget.singleProduct.price *
                              widget.singleProduct.qty!)),
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        AppProvider appProvider =
                            Provider.of<AppProvider>(context, listen: false);
                        appProvider.removeCardProduct(widget.singleProduct);
                        showMessage("Removed from Cart");
                      },
                      child: const CircleAvatar(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        maxRadius: 12,
                        child: Icon(Icons.delete_outline, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
