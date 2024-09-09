
import 'package:crafty_bay/data/model/product_details_data.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/create_cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/reviews_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/ProductDetails/color_selector.dart';
import 'package:crafty_bay/presentation/ui/widgets/ProductDetails/product_image_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/ProductDetails/size_selector.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({super.key, required this.id});
  final int? id;

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  int counts = 0;
  String size = '';
  String color = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Get.find<ProductDetailsController>().getProductDetails(widget.id!);
    });
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
          'Product details',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: GetBuilder<ProductDetailsController>(builder: (controller) {
        if (controller.inProgress) {
          return const CenterCircularProgressIndicator();
        }
        if(controller.productDetailsModel.productDetailsDataList==null||
            controller.productDetailsModel.productDetailsDataList!.isEmpty){
          return const CenterCircularProgressIndicator();
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProductImageCarousel(
                      productDetailsList:
                      controller.productDetailsModel.productDetailsDataList!,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ProductDetailsBody(
                        controller.productDetailsModel.productDetailsDataList!),
                  ],
                ),
              ),
            ),
            addToCartScreen
          ],
        );
      }),
    );
  }

  Padding ProductDetailsBody(List<ProductDetailsData> productDetailsDataList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  productDetailsDataList[0].product?.title ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              ItemCount(
                initialValue: counts,
                minValue: 0,
                maxValue: 20,
                decimalPlaces: 0,
                onChanged: (value) {
                  setState(() {
                    counts = value.toInt();
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ReviewAndRatingRow(productDetailsDataList[0].product?.star ?? 0.0),
          const SizedBox(
            height: 8,
          ),

          Text(
            'Color',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          ColorSelector(
            colors: productDetailsDataList[0].color ?? '',
            onChanged: (selectedColor) {
              color = selectedColor;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Size',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          SizeSelector(
            sizes: productDetailsDataList[0].size ?? '',
            onChanged: (selectedSize) {
              size = selectedSize;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            productDetailsDataList[0].des ?? '',
            style: const TextStyle(
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }

  Row ReviewAndRatingRow(star) {
    return Row(
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.star,
              size: 16,
              color: Colors.amber,
            ),
            Text(
              star.toStringAsPrecision(2),
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 16),
            )
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        TextButton(
            onPressed: () {
              Get.to(const ReviewsScreen());
            },
            child: const Text(
              'Reviews',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            )),
        const SizedBox(
          width: 8,
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
              size: 18,
            ),
          ),
        )
      ],
    );
  }

  Container get addToCartScreen {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.15),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              Text(
                '\$10000000',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 100,
            child: GetBuilder<CreateCartListController>(builder: (controller) {
              return Visibility(
                visible: controller.inProgress == false,
                replacement: const CenterCircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: () async {
                    if (color != null && size != null) {
                      if (AuthController.token != null) {
                        bool result = await controller.postCreatCartList(
                            widget.id,counts,color, size, AuthController.token);
                        if (result) {
                          Get.showSnackbar(const GetSnackBar(
                            title: 'Successful',
                            message: 'Add to Cart Successful',
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          Get.showSnackbar(const GetSnackBar(
                            title: 'Failed',
                            message: 'Api call not successful',
                            duration: Duration(seconds: 2),
                          ));
                        }
                       }
                       else {
                          AuthController.backToLogin();
                       }
                    } else {
                      Get.showSnackbar(const GetSnackBar(
                        title: 'Failed',
                        message: 'Give the color and size',
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  child: const Text('Add to Cart'),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
