import 'package:crafty_bay/presentation/state_holders/category_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/category_item_card.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) => Get.find<MainBottomNavController>().backToHome(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.find<MainBottomNavController>().backToHome();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.white,
          elevation: 4,
        ),
        body: RefreshIndicator(
          onRefresh:()async{},
          child: GetBuilder<CategoryController>(
            builder: (controller) {
              return Visibility(
                visible:controller.inProgress==false,
                replacement: const CenterCircularProgressIndicator(),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 12),
                    itemCount:controller.categoryListModel.categoryList?.length,
                    padding: const EdgeInsets.all(8),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return FittedBox(child: CategoryItemCard(category:controller.categoryListModel.categoryList![index]));
                    }),
              );
            }
          ),
        ),
      ),
    );
  }
}
