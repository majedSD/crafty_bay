
import 'package:crafty_bay/data/model/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class DeletCartListController extends GetxController{
  bool _inProgress=false;

  bool get inProgress=>_inProgress;

  String _errorMessage='';

  String get errorMessage=>_errorMessage;

  Future<bool>getDeletCartList(int id)async{
    _inProgress=true;
    update();
    ResponseData response=await NetworkCaller().getRequest(Urls.deleteCartList(id));
    _inProgress=false;
    update();
    if(response.isSuccess){
      update();
      return true;
    }else{
      _errorMessage=response.errorMessage??'';
      update();
      return false;
    }
  }
}