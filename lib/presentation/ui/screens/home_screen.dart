import 'package:crafty_bay/data/model/product_model.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/category_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_banner_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/splash_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/product_list_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/category_item_card.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/banner_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utility/imagePath.dart';
import '../widgets/home/circle_icon_button.dart';
import '../widgets/home/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTEController = TextEditingController();
  AuthController controller=Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) => Get.find<MainBottomNavController>().backToHome,
      child: Scaffold(
        appBar: appBar,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                textFormField,
                const SizedBox(
                  height: 8,
                ),
                GetBuilder<HomeBannerController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress==false,
                        replacement:const CenterCircularProgressIndicator(),
                        child:BannerCarousel(banerList:controller.bannerListModel.bannerList??[],)
                    );
                  }
                ),
                const SizedBox(
                  height: 16,
                ),
                SectionTitle(
                    title: 'All Categories',
                    onTap: () {
                      Get.find<MainBottomNavController>().changeIndex(1);
                    }),
                const SizedBox(
                  height: 8,
                ),
                CategoryItemList,
                const SizedBox(
                  height: 8,
                ),
                SectionTitle(
                    title: 'Popular',
                    onTap: () {
                      Get.to( ProductListScreen
                        (name: 'Popular',
                        productList:Get.find<PopularProductController>().productListModel.productList??[],
                      ));
                    }),
                const SizedBox(
                  height: 8,
                ),
                GetBuilder<PopularProductController>(
                  builder: (controller) {
                    return Visibility(
                        visible:controller.inProgress==false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: productList(controller.productListModel.productList),);
                  }
                ),
                const SizedBox(
                  height: 8,
                ),
                SectionTitle(
                    title: 'Special',
                    onTap: () {
                      Get.to( ProductListScreen
                        (name: 'Special',
                        productList:Get.find<SpecialProductController>().productListModel.productList??[],
                      ));
                    }),
                const SizedBox(
                  height: 8,
                ),
                GetBuilder<SpecialProductController>(
                    builder: (controller) {
                      return Visibility(
                        visible:controller.inProgress==false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: productList(controller.productListModel.productList),);
                    }
                ),
                const SizedBox(
                  height: 8,
                ),
                SectionTitle(
                    title: 'New',
                    onTap: () {
                      Get.to( ProductListScreen
                        (name: 'New',
                        productList:Get.find<NewProductController>().productListModel.productList??[],
                      ));
                    }),
                const SizedBox(
                  height: 8,
                ),
                GetBuilder<NewProductController>(
                    builder: (controller) {
                      return Visibility(
                        visible:controller.inProgress==false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: productList(controller.productListModel.productList),);
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  SizedBox get CategoryItemList {
    return SizedBox(
      height: 120,
      child: GetBuilder<CategoryController>(
        builder: (controller) {
          return Visibility(
            visible:controller.inProgress==false,
            replacement: const CenterCircularProgressIndicator(),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                width: 8,
              ),
              itemCount:controller.categoryListModel.categoryList?.length??0,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CategoryItemCard(category:controller.categoryListModel.categoryList![index]);
              },
            ),
          );
        }
      ),
    );
  }

  SizedBox productList(List<Product>?productList) {
    return SizedBox(
      height:190,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
        itemCount:productList?.length??0,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ProductCardItem(product: productList![index],);
        },
      ),
    );
  }
  TextFormField get textFormField {
    return TextFormField(
      controller: searchTEController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none),
        fillColor: Colors.grey.shade300,
        filled: true,
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.all(8),
        enabled: true,
      ),
    );
  }

  AppBar get appBar {
    return AppBar(
      title: Image.asset(ImagePath.logoNav),
      actions: [
        CircleIconButton(
          onTap: () async {
            await controller.clearAuthData();
              Get.offAll(()=>const VerifyEmailScreen());
          },
          iconData: const Icon(Icons.person),
        ),
        const SizedBox(
          width: 8,
        ),
        CircleIconButton(
          onTap: () {},
          iconData: const Icon(Icons.phone),
        ),
        const SizedBox(
          width: 8,
        ),
        CircleIconButton(
          onTap: () {},
          iconData: const Icon(Icons.notification_add_outlined),
        ),
      ],
    );
  }
}
