
import 'package:crafty_bay/presentation/state_holders/product_list_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  final String? category;
  final int? categoryId;

  const ProductListScreen({super.key, this.category, this.categoryId});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      Get.find<ProductListController>().getProductList(widget.categoryId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category ?? "Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child:
        GetBuilder<ProductListController>(builder: (productListController) {
          return Visibility(
            visible: productListController.inProgress == false,
            replacement: const CenterCircularProgressIndicator(),
            child: Visibility(
              visible: productListController
                  .productListModel.productList?.isNotEmpty ??
                  false,
              replacement: const Center(child: Text("No Product")),
              child: GridView.builder(
                itemCount: productListController
                    .productListModel.productList?.length ??
                    0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.90,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return FittedBox(
                      child: ProductCardItem(
                        productList: productListController
                            .productListModel.productList![index],
                      ));
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}