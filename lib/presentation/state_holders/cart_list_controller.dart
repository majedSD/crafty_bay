import 'package:crafty_bay/data/model/cart_item.dart';
import 'package:crafty_bay/data/model/cart_list_model.dart';
import 'package:crafty_bay/data/model/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class CartListController extends GetxController{
  bool _inProgress=false;

  bool get inProgress=>_inProgress;

  String _errorMessage='';

  String get errorMessage=>_errorMessage;

  CartListModel _cartListModel=CartListModel();

  CartListModel get cartListModel=>_cartListModel;

  final RxDouble _totalPrice=0.0.obs;

  RxDouble get totalPrice=>_totalPrice;

  Future<bool>getCartList()async{
    _inProgress=true;
    update();
    ResponseData response=await NetworkCaller().getRequest(Urls.cartList,token:AuthController.token);
    _inProgress=false;
    update();
    if(response.isSuccess){
      _cartListModel=CartListModel.fromJson(response.responseData);
      _totalPrice.value=_calculateTotalPrice;
      update();
      return true;
    }else{
      _errorMessage=response.errorMessage??'';
      update();
      return false;
    }
  }
  Future<bool>getDeletCart(int id)async{
    ResponseData response=await NetworkCaller().getRequest(Urls.deleteCartList(id),token:AuthController.token);
    update();
    print(response.statusCode);
    print(response.statusCode);
    print(response.isSuccess);
    print(response.isSuccess);
    print(response.responseData);
    print(response.responseData);
    if(response.isSuccess){
      return true;
    }else{
      return false;
    }
  }
  void updateQuantity(int? id, int?count){
   _cartListModel.cartList?.firstWhere((element)=>element.id==id).quantity=count;
   _totalPrice.value=_calculateTotalPrice;
  }
 double get _calculateTotalPrice{
    double total=0.0;
    for(CartItem item in _cartListModel.cartList??[]){
        total+=((double.tryParse(item.price??'0')??0) *item.quantity!.toInt());
    }
    return total;
 }
}