import 'package:flutter/animation.dart';

class Product{
  int id;
  String productName;
  String productDescription;
  double productPrice;

  Product(this.productName, this.productDescription, this.productPrice);

  Product.withId(this.id, this.productName, this.productDescription, this.productPrice);

  Product.fromObject(dynamic object)
  {
    this.id = int.tryParse(object["id"]);
    this.productName = object["productName"];
    this.productDescription = object["productDescription"];
    this.productPrice = double.tryParse(object["productPrice"]);
  }

  Map<String, dynamic> toMap()
  {
    var map = Map<String, dynamic>();
    map["productName"] = productName;
    map["productDescription"] = productDescription;
    map["productPrice"] = productPrice;
    if(id != null)
      map["id"] = id;

    return map;
  }
}