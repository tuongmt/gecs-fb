// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:ecommerce_app/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:ecommerce_app/models/order_model/order_model.dart';
import 'package:ecommerce_app/models/product_model/product_model.dart';
import 'package:ecommerce_app/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  // CART
  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];

  void addCardProduct(ProductModel productModel) {
    int index =
        _cartProductList.indexWhere((product) => product.id == productModel.id);
    if (index != -1) {
      int qty = productModel.qty!;
      _cartProductList[index].qty = (_cartProductList[index].qty!) + qty;
    } else {
      _cartProductList.add(productModel);
    }
    notifyListeners();
  }

  void removeCardProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  // FAVOURITE PRODUCT
  final List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  // USER INFORMATION
  UserModel? _userModel;

  UserModel get getUserInformation => _userModel!;

  void getUserInfoFireBase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      showLoaderDialog(context);
      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
    } else {
      showLoaderDialog(context);
      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
    }
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.of(context).pop();
    showMessage("Successfully updated profile");
    notifyListeners();
  }

  // TOTAL PRICE
  double totalPrice() {
    double totalPrice = 0.0;
    for (var product in _cartProductList) {
      totalPrice += product.price * product.qty!;
    }
    return totalPrice;
  }

  double totalPriceBuyProductList() {
    if (_buyProductList.isEmpty) {
      showMessage("Error: Cannot checkout with empty product");
      return 0.0;
    }
    double totalPrice = 0.0;
    for (var product in _buyProductList) {
      totalPrice += product.price * product.qty!;
    }
    return totalPrice;
  }

  void updateQty(ProductModel productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  // BUY PRODUCT - CART CHECKOUT
  List<ProductModel> get getBuyProductList => _buyProductList;

  void addBuyProduct(ProductModel product) {
    _buyProductList.add(product);
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  // void uploadOrderedProductToFirebaseFromAPI(
  //   List<ProductModel> productList,
  //   String payment,
  //   BuildContext context,
  // ) async {
  //   bool res =
  //       await FirebaseFirestoreHelper.instance.uploadOrderedProductFirebase();
  // }

  // ORDER OF USER
  List<OrderModel> _userOrderList = [];
  void getUserOrderFromAPI() async {
    _userOrderList = await FirebaseFirestoreHelper.instance.getUserOrder();
  }

  List<OrderModel> get getUserOrderList => _userOrderList;
}
