
import 'package:crafty_bay/data/model/payment_method_wraper.dart';
import 'package:crafty_bay/presentation/state_holders/create_invoice_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/payment_web_view_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Get.find<CreateInvoiceController>().getInvoice();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
           Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body:GetBuilder<CreateInvoiceController>(
        builder: (controller) {
          if(controller.inProgress){
           return const CenterCircularProgressIndicator();
          }
          PaymentMethodWarper paymentMethodWarper=controller.paymentListMethodModel.paymentMethodWraperList!.first;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text('payable:${paymentMethodWarper.payable}',style:const TextStyle(
                   color: AppColors.primaryColor,
                 ),),
                 Text('vat:${paymentMethodWarper.vat}',style:const TextStyle(
                   color: AppColors.primaryColor,
                 ),),
                 Text('total:${paymentMethodWarper.total}',style:const TextStyle(
                   color: AppColors.primaryColor
                 ),),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                     itemCount:paymentMethodWarper.paymentMethodList?.length??0,
                      itemBuilder:(context,index){
                       return ListTile(
                        title:Text('${paymentMethodWarper.paymentMethodList?[index].name}'),
                         leading:Image.network('${paymentMethodWarper.paymentMethodList?[index].logo}'),
                         trailing:IconButton(
                             onPressed:(){
                               Get.to(()=>PaymentWebViewScreen(url:paymentMethodWarper.paymentMethodList![index].redirectGatewayURL??''));
                             },
                             icon:const Icon(Icons.arrow_forward)),
                         );
                       },
                    separatorBuilder:(context,index)=>const Divider(),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
