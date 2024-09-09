import 'package:crafty_bay/data/model/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CreateCartListController extends GetxController{
  bool _inProgress=false;

  bool get inProgress=>_inProgress;

  String _errorMessage='';

  String get errorMessage=>_errorMessage;

  Future<bool>postCreatCartList(int? id,int?qty,String? color,String? size,String? token)async{
    _inProgress=true;
    update();
    Map<String,dynamic>body={
      "product_id":id,
      "color":color,
      "size":size,
      "qty":qty,
    };
    ResponseData response=await NetworkCaller().postRequest(
      Urls.createCartList,
      token:token,
      body: body,
    );
    _inProgress=false;
    update();
    if(response.isSuccess){
      return true;
    }else{
      _errorMessage=response.errorMessage??'';
      return false;
    }
  }
}
