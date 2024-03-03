import 'package:crafty_bay/data/models/product.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/category_item_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_banner_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screen/auth/login_screen.dart';
import 'package:crafty_bay/presentation/ui/screen/product_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:crafty_bay/presentation/ui/widgets/category_item.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/banner_carosule.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/circular_icon_button.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/section_title.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 8),
              searchTextField,
              const SizedBox(height: 16),
              GetBuilder<HomeBannerController>(builder: (homeBannerController) {
                return Visibility(
                  visible: homeBannerController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: BannerCarousel(
                    bannerList:
                    homeBannerController.bannerListModel.bannerList ?? [],
                  ),
                );
              }),
              const SizedBox(height: 16),
              SectionTitle(
                title: 'All Categories',
                onTap: () {
                  Get.find<MainBottomNavController>().changeIndex(1);
                },
              ),
              categoryList,
              SectionTitle(
                title: 'Popular',
                onTap: () {
                  Get.to(const ProductListScreen());
                },
              ),
              GetBuilder<PopularProductListController>(
                  builder: (popularProductListController) {
                    return Visibility(
                      visible: popularProductListController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: productList(popularProductListController
                          .productListModel.productList ??
                          []),
                    );
                  }),
              const SizedBox(height: 16),
              SectionTitle(
                title: 'Special',
                onTap: () {},
              ),
              GetBuilder<SpecialProductListController>(
                  builder: (specialProductListController) {
                    return Visibility(
                      visible: specialProductListController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: productList(specialProductListController
                          .productListModel.productList ??
                          []),
                    );
                  }),
              const SizedBox(height: 16),
              SectionTitle(
                title: 'New',
                onTap: () {},
              ),
              GetBuilder<NewProductListController>(
                  builder: (newProductListController) {
                    return Visibility(
                      visible: newProductListController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: productList(
                          newProductListController.productListModel.productList ??
                              []),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox productList(List<Product> productList) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ProductCardItem(
            productList: productList[index],
          );
        },
      ),
    );
  }

  SizedBox get categoryList {
    return SizedBox(
      height: 110,
      child:
      GetBuilder<CategoryItemController>(builder: (categoryItemController) {
        return Visibility(
          visible: categoryItemController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            primary: false,
            shrinkWrap: true,
            itemCount:
            categoryItemController.categoryItemModel.categoryList?.length ??
                0,
            itemBuilder: (context, index) {
              return CategoryItem(
                categoryList: categoryItemController
                    .categoryItemModel.categoryList![index],
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(width: 8);
            },
          ),
        );
      }),
    );
  }

  TextFormField get searchTextField {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  AppBar get appBar {
    return AppBar(
      title: Image.asset(AssetsPath.logoNav),
      actions: [
        CircularIconButton(
          iconData: Icons.person_outline,
          onTap: () async {
            await AuthController.clearAuthData();
            Get.offAll(() => const LoginScreen());
          },
        ),
        const SizedBox(width: 8),
        CircularIconButton(
          iconData: Icons.call_outlined,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        CircularIconButton(
          iconData: Icons.notifications_active_outlined,
          onTap: () {},
        ),
        const SizedBox(width: 8)
      ],
    );
  }
}