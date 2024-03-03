import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:flutter/material.dart';

class CartProductItem extends StatefulWidget {
  const CartProductItem({
    super.key,
  });

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  int itemCounter = 0;

  cartIncrement() {
    itemCounter++;
    setState(() {});
  }

  cartDecrement() {
    if (itemCounter > 0) {
      itemCounter--;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Image.asset(
            AssetsPath.dummyProductImage,
            width: 100,
          ),
          Expanded(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "New Year Special Shoe",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Color: Red"),
                                    SizedBox(width: 8),
                                    Text("Size: X"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 8,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "\$100",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
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
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}