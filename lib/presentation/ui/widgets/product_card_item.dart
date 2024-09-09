import 'package:crafty_bay/data/model/product_model.dart';
import 'package:crafty_bay/data/model/wish_product.dart';
import 'package:crafty_bay/presentation/ui/screens/products_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({
    super.key, required this.product, this.wishProduct,
  });
  final Product?product;
  final WishProduct?wishProduct;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: 160,
      child: InkWell(
        onTap: () {
          Get.to(ProductsDetailsScreen(id:product?.id??wishProduct!.id!));
        },
        borderRadius: BorderRadius.circular(16),
        child: Card(
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
                child: Image.network(
                  product?.image??wishProduct!.image!,
                  fit: BoxFit.cover,
                  width: 160,
                  height: 120,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      product?.title??wishProduct!.title!,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         Text(
                          '\$${product?.price??wishProduct!.price!}',
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                         Wrap(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            Text(
                              '${product?.star??wishProduct!.star!}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                            )
                          ],
                        ),
                        Card(
                          color: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.favorite_border_sharp,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
