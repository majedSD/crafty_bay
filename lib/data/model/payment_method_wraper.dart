
import 'package:crafty_bay/data/model/payment_method.dart';

class PaymentMethodWarper {
  List<PaymentMethod>? paymentMethodList;
  int? payable;
  int? vat;
  int? total;

  PaymentMethodWarper({this.paymentMethodList, this.payable, this.vat, this.total});

  PaymentMethodWarper.fromJson(Map<String, dynamic> json) {
    if (json['paymentMethod'] != null) {
      paymentMethodList = <PaymentMethod>[];
      json['paymentMethod'].forEach((v) {
        paymentMethodList!.add(PaymentMethod.fromJson(v));
      });
    }
    payable = json['payable'];
    vat = json['vat'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentMethodList != null) {
      data['paymentMethod'] =
          paymentMethodList!.map((v) => v.toJson()).toList();
    }
    data['payable'] = payable;
    data['vat'] = vat;
    data['total'] = total;
    return data;
  }
}