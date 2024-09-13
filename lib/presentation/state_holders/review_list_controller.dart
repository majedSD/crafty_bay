import 'package:crafty_bay/data/model/response_data.dart';
import 'package:crafty_bay/data/model/review_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class ReviewListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  ReviewModel _reviewModel = ReviewModel();

  ReviewModel get reviewListModel => _reviewModel;

  Future<bool> getReviewList(int id) async {
    _inProgress = true;
    update();
    ResponseData response = await NetworkCaller()
        .getRequest(Urls.reviewList(id));
     print(id);
     print(id);
     print(id);
     print(id);
     print(id);
     print(id);
     print(id);
    _inProgress = false;
    update();
    if (response.isSuccess) {
      _reviewModel=ReviewModel.fromJson(response.responseData);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage ?? '';
      update();
      return false;
    }
  }

}
