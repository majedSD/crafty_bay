import 'package:crafty_bay/data/model/product_details_model.dart';
import 'package:crafty_bay/data/model/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController{

  bool _inProgress=false;

  bool get inProgress=>_inProgress;

  String _errorMessage='';

  String get errorMessage=>_errorMessage;

  ProductDetailsModel _productDetailsModel=ProductDetailsModel();

  ProductDetailsModel get productDetailsModel=>_productDetailsModel;

  Future<bool>getProductDetails(int id)async{
  _inProgress=true;
  ResponseData response=await NetworkCaller().getRequest(Urls.productDetailsById(id));
 print(response.responseData);
  print(response.responseData);
  print(response.statusCode);
  print(response.statusCode);
  print(id);
  print(id);
  if(response.isSuccess){
    _inProgress=false;
    update();
  _productDetailsModel=ProductDetailsModel.fromJson(response.responseData);
  return true;
  }else{
  _errorMessage=response.errorMessage??'';
  update();
  return false;
  }
  }
}