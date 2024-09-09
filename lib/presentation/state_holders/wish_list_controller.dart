import 'package:crafty_bay/data/model/response_data.dart';
import 'package:crafty_bay/data/model/wish_list_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class WishListController extends GetxController{
  bool _inProgress=false;

  bool get inProgress=>_inProgress;

  String _errorMessage='';

  String get errorMessage=>_errorMessage;

  WishListModel _wishListModel=WishListModel();

  WishListModel get wishListModel=>_wishListModel;

  Future<bool>getWishList()async{
    _inProgress=true;
    update();
    ResponseData response=await NetworkCaller().getRequest(Urls.productWishList,token: AuthController.token);
    _inProgress=false;
    print(response.statusCode);
    print(response.statusCode);
    print(response.responseData);
    print(response.responseData);
    print(response.isSuccess);
    print(response.isSuccess);
    update();
    if(response.isSuccess){
      _wishListModel=WishListModel.fromJson(response.responseData);
      update();
      return true;
    }else{
      _errorMessage=response.errorMessage??'';
      update();
      return false;
    }
  }
}