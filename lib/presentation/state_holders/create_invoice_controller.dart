import 'package:crafty_bay/data/model/payment_method_list_model.dart';
import 'package:crafty_bay/data/model/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class CreateInvoiceController extends GetxController{
  bool _inProgress= false;
  bool get inProgress=>_inProgress;

  String _errorMessage='';
  String get errorMessage=>_errorMessage;

  PaymentListMethodModel _paymentListMethodModel=PaymentListMethodModel();
  PaymentListMethodModel get paymentListMethodModel=>_paymentListMethodModel;

  Future<bool>getInvoice()async{
    _inProgress=true;
    update();
    ResponseData response=await NetworkCaller().getRequest(Urls.invoiceCreate,token: AuthController.token);
    _inProgress=false;
    update();
    print(response.statusCode);
    print(response.statusCode);
    print(response.isSuccess);
    print(response.isSuccess);
    print(response.responseData);
    print(response.responseData);
    if(response.isSuccess){
      _paymentListMethodModel=PaymentListMethodModel.fromJson(response.responseData);
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