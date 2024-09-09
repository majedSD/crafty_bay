import 'package:crafty_bay/data/model/wish_item.dart';

class WishListModel {
  String? msg;
  List<WishItem>? wishList;

  WishListModel({this.msg, this.wishList});

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      wishList = <WishItem>[];
      json['data'].forEach((v) {
        wishList!.add(WishItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (wishList != null) {
      data['data'] = wishList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




