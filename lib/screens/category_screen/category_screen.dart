import 'package:ecommerce_app/constants/routes.dart';
import 'package:ecommerce_app/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:ecommerce_app/models/category_model/category_model.dart';
import 'package:ecommerce_app/models/product_model/product_model.dart';
import 'package:ecommerce_app/screens/product_detail/product_detail.dart';
import 'package:ecommerce_app/utils/numbers.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryScreen({super.key, required this.categoryModel});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    getModelList();
    super.initState();
  }

  void getModelList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryScreenProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const BackButton(),
                          Text(
                            widget.categoryModel.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                  productModelList.isEmpty
                      ? const Center(
                          child: Text("Product is empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: productModelList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 0.75,
                                      crossAxisCount: 2),
                              itemBuilder: (ctx, index) {
                                ProductModel singleProduct =
                                    productModelList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Column(
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          Routes.instance.push(
                                              widget: ProductDetail(
                                                  singleProduct: singleProduct),
                                              context: context);
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Image.network(
                                            singleProduct.image,
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Text(
                                        singleProduct.name,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          "Price: ${numberFormatter(singleProduct.price)}"),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      SizedBox(
                                        width: 120,
                                        height: 40,
                                        child: OutlinedButton(
                                            onPressed: () {
                                              Routes.instance.push(
                                                  widget: ProductDetail(
                                                      singleProduct:
                                                          singleProduct),
                                                  context: context);
                                            },
                                            child: const Text(
                                              "Buy",
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
    );
  }
}
