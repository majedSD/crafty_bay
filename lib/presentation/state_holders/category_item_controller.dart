import 'package:crafty_bay/data/models/category_item_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CategoryItemController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  CategoryItemModel _categoryItemModel = CategoryItemModel();
  CategoryItemModel get categoryItemModel => _categoryItemModel;

  Future<bool> getCategoryList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.categoryItems);
    _inProgress = false;
    if (response.isSuccess) {
      _categoryItemModel = CategoryItemModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}