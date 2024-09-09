import 'package:crafty_bay/data/model/category_list_model.dart';
import 'package:crafty_bay/data/model/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
  bool _inProgress=false;

  bool get inProgress=>_inProgress;

  String _errorMessage='';

  String get errorMessage=>_errorMessage;

  CategoryListModel _categoryListModel=CategoryListModel();

  CategoryListModel get categoryListModel=>_categoryListModel;

  Future<bool>getCategoryList()async{
    _inProgress=true;
    ResponseData response=await NetworkCaller().getRequest(Urls.categoryList);
    _inProgress=false;
     update();
    if(response.isSuccess){
      _categoryListModel=CategoryListModel.fromJson(response.responseData);
      update();
      return true;
    }else{
      _errorMessage=response.errorMessage??'';
      update();
      return false;
    }
  }
}