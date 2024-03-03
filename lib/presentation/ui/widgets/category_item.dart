import 'package:crafty_bay/data/models/category.dart';
import 'package:crafty_bay/presentation/ui/screen/product_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatefulWidget {
  final Category categoryList;

  const CategoryItem({
    super.key,
    required this.categoryList,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductListScreen(
          category: widget.categoryList.categoryName.toString() ?? '',
          categoryId: widget.categoryList.id,
        ));
      },
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: AppColors.primaryColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                widget.categoryList.categoryImg.toString() ?? '',
                width: 40,
              ),
            ),
          ),
          Text(
            widget.categoryList.categoryName ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}