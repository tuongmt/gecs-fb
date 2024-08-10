import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String name;
  double price;
  String description;
  String image;
  bool isFavourite;

  int? qty;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.image,
      required this.isFavourite,
      this.qty});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: double.parse(json["price"].toString()),
        description: json["description"],
        image: json["image"],
        isFavourite: false,
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "image": image,
        "isFavourite": isFavourite,
        "qty": qty
      };

  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
          id: id,
          name: name,
          price: price,
          description: description,
          image: image,
          isFavourite: isFavourite,
          qty: qty ?? this.qty);
}
