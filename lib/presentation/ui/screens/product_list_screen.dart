import 'package:crafty_bay/data/model/product_model.dart';
import 'package:crafty_bay/presentation/state_holders/product_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
   ProductListScreen({super.key, this.name,required this.productList,this.id});

   String? name;
  List<Product>?productList;
  int?id;
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}
class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    if(widget.id!=null){
      Get.find<ProductController>().getProductList(widget.id!);
    }
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
          widget.name ?? 'Products',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: GetBuilder<ProductController>(
        builder: (controller) {
          return Visibility(
            visible:controller.inProgress==false,
            replacement:const CenterCircularProgressIndicator(),
            child:GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 4),
                itemCount:controller.productListModel.productList?.length??widget.productList?.length,
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                 return  FittedBox(child: ProductCardItem(product:controller.productListModel.productList?[index]??widget.productList![index]));
                },),
          );
        }
      ),
    );
  }
}
