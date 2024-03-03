import 'package:crafty_bay/data/models/product.dart';

class ProductListModel {
  String? msg;
  List<Product>? productList;

  ProductListModel({this.msg, this.productList});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productList = <Product>[];
      json['data'].forEach((v) {
        productList!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (productList != null) {
      data['data'] = productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}