import 'package:crafty_bay/data/model/cart_item.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/checkout_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Get.find<CartListController>().getCartList();
    });
  }
  List<int> counts =
  List.generate(20, (index) => 1);
  int price=0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) => Get.find<MainBottomNavController>().backToHome,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.find<MainBottomNavController>().backToHome();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Cart List',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Colors.white,
          elevation: 4,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: GetBuilder<CartListController>(
            builder: (controller) {
              if(controller.inProgress==true){
                return const CenterCircularProgressIndicator();
              }
              if(controller.cartListModel.cartList==null){
                return const CenterCircularProgressIndicator();
              }
              return Column(
                  children: [
                    ListOfCartsItem(controller.cartListModel.cartList),
                    TotalPriceAndCheckSection(controller.totalPrice),
                  ],
              );
            }
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  TotalPriceAndCheckSection(RxDouble totalPrice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.15),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Price',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
             Obx(()=> Text(
               '\$$totalPrice', // Example calculation
               style: const TextStyle(
                 fontSize: 18,
                 fontWeight: FontWeight.w600,
                 color: AppColors.primaryColor,
               ),
             ),)
            ],
          ),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                Get.to(()=>const CheckoutScreen());
              },
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Expanded ListOfCartsItem(List<CartItem>? cartList) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 3,
        ),
        itemCount:cartList!.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 120,
            width: double.infinity,
            child: Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      cartList[index].product?.image??'',
                      fit: BoxFit.cover,
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              cartList[index].product?.title??'',
                              maxLines: 1,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black54,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            IconButton(
                              onPressed: ()async{
                                bool result=await Get.find<CartListController>().getDeletCart(cartList[index].productId??0);
                               if(result){
                                 Get.find<CartListController>().getCartList();
                               }
                               else{
                                 Get.showSnackbar(const GetSnackBar(
                                   title:'Failed',
                                   message:'Api Call not successful',
                                   duration:Duration(seconds: 2),
                                 ));
                               }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text( cartList[index].color??'',
                                style: Theme.of(context).textTheme.titleSmall),
                            const SizedBox(
                              width: 8,
                            ),
                            Text( cartList[index].size??'',
                                style: Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              '\$${cartList[index].price}',
                              style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            ItemCount(
                              initialValue:counts[index],
                              minValue: 0,
                              maxValue: 20,
                              decimalPlaces: 0,
                              onChanged: (value) {
                                setState(() {
                                  counts[index] = value.toInt();
                                  Get.find<CartListController>().updateQuantity(cartList[index].id,counts[index]);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
