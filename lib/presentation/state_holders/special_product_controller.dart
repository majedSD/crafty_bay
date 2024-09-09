import 'package:crafty_bay/data/model/product_list_model.dart';
import 'package:crafty_bay/data/model/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';
class SpecialProductController extends GetxController{
  bool _inProgress= false;
  bool get inProgress=>_inProgress;
  String _errorMessage='';
  String get errorMessage=>_errorMessage;
  ProductListModel _productListModel=ProductListModel();
  ProductListModel get productListModel=>_productListModel;
  Future<bool>getSpecialProduct()async{
    _inProgress=true;
    update();
    ResponseData response=await NetworkCaller().getRequest(Urls.listProductByRemark('Special'));
    _inProgress=false;
    update();
    if(response.isSuccess){
      _productListModel=ProductListModel.fromJson(response.responseData);
      update();
      return true;
    }
    else{
      _errorMessage=response.errorMessage??'';
      update();
      return false;
    }
  }
}