import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Get.find<WishListController>().getWishList();
    });
  }
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
            'Wish List',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Colors.white,
          elevation: 4,
        ),
        body: GetBuilder<WishListController>(
          builder: (controller) {
            return Visibility(
              visible: controller.inProgress==false,
              replacement:const CenterCircularProgressIndicator(),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 4),
                  itemCount:controller.wishListModel.wishList?.length??0,
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return FittedBox(child: ProductCardItem(wishProduct:controller.wishListModel.wishList![index].product, product: null,));
                  }),
            );
          }
        ),
      ),
    );
  }
}
