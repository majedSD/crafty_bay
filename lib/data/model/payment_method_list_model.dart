import 'package:crafty_bay/data/model/payment_method_wraper.dart';

class PaymentListMethodModel {
  String? msg;
  List<PaymentMethodWarper>? paymentMethodWraperList;

  PaymentListMethodModel({this.msg, this.paymentMethodWraperList});

  PaymentListMethodModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      paymentMethodWraperList = <PaymentMethodWarper>[];
      json['data'].forEach((v) {
        paymentMethodWraperList!.add(PaymentMethodWarper.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (paymentMethodWraperList != null) {
      data['data'] = paymentMethodWraperList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


