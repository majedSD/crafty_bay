import 'package:crafty_bay/data/models/category.dart';

class CategoryItemModel {
  String? msg;
  List<Category>? categoryList;

  CategoryItemModel({this.msg, this.categoryList});

  CategoryItemModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      categoryList = <Category>[];
      json['data'].forEach((v) {
        categoryList!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (categoryList != null) {
      data['data'] = categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}