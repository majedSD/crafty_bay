import 'package:crafty_bay/data/model/review_data.dart';

class ReviewModel {
  String? msg;
  List<ReviewData>? reviewDataList;

  ReviewModel({this.msg, this.reviewDataList});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      reviewDataList = <ReviewData>[];
      json['data'].forEach((v) {
        reviewDataList!.add(ReviewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (reviewDataList != null) {
      data['data'] = reviewDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



