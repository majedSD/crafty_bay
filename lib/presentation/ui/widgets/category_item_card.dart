import 'package:crafty_bay/data/model/category.dart';
import 'package:crafty_bay/presentation/ui/screens/product_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItemCard extends StatelessWidget {
   CategoryItemCard({
    super.key,
    required this.category,
  });
   Category category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
              Get.to(ProductListScreen(
                name:category.categoryName,
                productList:[],
                id: category.id
              ),);
          },
          borderRadius: BorderRadius.circular(16),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: AppColors.primaryColor.withOpacity(0.1),
            child:  Padding(
              padding: const EdgeInsets.all(20),
              child:Image.network(category.categoryImg??'',height:50,width: 60,),
            ),
          ),
        ),
        Text(
          category.categoryName??'',
          style: const TextStyle(
            color: AppColors.primaryColor,
          ),
        )
      ],
    );
  }
}
