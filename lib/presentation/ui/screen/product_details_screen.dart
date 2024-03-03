import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/color_selector.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/product_details_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/size_selector.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int itemCounter = 1;

  List<Color> colors = [
    Colors.blueGrey,
    Colors.redAccent,
    Colors.blue,
    Colors.amber,
    Colors.black,
  ];
  Color _selectedColor = Colors.blueGrey;

  List<String> size = [
    'S',
    'L',
    'M',
    'XL',
    'XXL',
    'XXXL',
  ];
  String _selectedSize = 'S';

  cartIncrement() {
    itemCounter++;
    setState(() {});
  }

  cartDecrement() {
    if (itemCounter > 1) {
      itemCounter--;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        elevation: 3,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ProductDetailsCarousel(),
                  productDetailsBody,
                ],
              ),
            ),
          ),
          totalPriceAndAddToCart,
        ],
      ),
    );
  }

  Padding get productDetailsBody {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Happy New Year Special Deal Save 30%",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: cartDecrement,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        color: AppColors.primaryColor,
                      ),
                      child: const Icon(
                        Icons.remove,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(itemCounter.toString()),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      cartIncrement();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        color: AppColors.primaryColor,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Wrap(
                children: [
                  Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amber,
                  ),
                  Text(
                    "4.5",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Text(
                "Review",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(width: 8),
              Card(
                color: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Colors",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          ColorSelector(
            colors: colors,
            onChange: (selectedColor) {
              _selectedColor = selectedColor;
            },
          ),
          const SizedBox(height: 16),
          const Text(
            "Size",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          SizeSelector(
            size: size,
            onChange: (selectedSize) {
              _selectedSize = selectedSize;
            },
          ),
          const SizedBox(height: 16),
          const Text(
            "Description",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Lorem Ipsum is simply dummy text of the printing and "
                "typesetting industry. Lorem Ipsum has been the "
                "industry's standard dummy text ever since the 1500s, "
                "when an unknown printer took a galley "
                "of type and scrambled it to make a type specimen book.",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Container get totalPriceAndAddToCart {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
        color: AppColors.primaryColor.withOpacity(0.15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ),
              Text(
                "\$1202453",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Add To Cart")),
        ],
      ),
    );
  }
}