import 'package:crafty_bay/data/model/banner_list_model.dart';
import 'package:crafty_bay/data/model/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class HomeBannerController extends GetxController{
 bool _inProgrss=false;

bool get inProgress=>_inProgrss;

String _errorMessage='';

String get errorMessage=>_errorMessage;

BannerListModel _bannerListModel=BannerListModel();

BannerListModel get bannerListModel=>_bannerListModel;

Future<bool>getBannerList()async{
  _inProgrss=true;
  update();
  ResponseData response=await NetworkCaller().getRequest(Urls.listProductSlider);
  _inProgrss=false;
  update();
  if(response.isSuccess==true){
    _bannerListModel=BannerListModel.fromJson(response.responseData);
    update();
    return true;
  }else{
    _errorMessage=response.errorMessage??'';
    update();
    return false;
  }
}
}