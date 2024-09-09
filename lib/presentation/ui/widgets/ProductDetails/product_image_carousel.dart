import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/model/product_details_data.dart';
import 'package:flutter/material.dart';
import '../../utility/app_colors.dart';

class ProductImageCarousel extends StatefulWidget {
  ProductImageCarousel({super.key, required this.productDetailsList});
   List<ProductDetailsData> productDetailsList;
  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int _selectedIndex = 0;
  late List<String> imageUrlsList=[
        '${widget.productDetailsList[0].img1}',
        '${widget.productDetailsList[0].img2}',
        '${widget.productDetailsList[0].img3}',
        '${widget.productDetailsList[0].img4}',
  ];
  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 180.0,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _selectedIndex = index;
                });
              }),
          items: imageUrlsList.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  alignment: Alignment.center,
                  child:Image.network(url,
                    height:double.infinity,
                    width:double.infinity,
                    fit: BoxFit.fill,),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i <imageUrlsList.length; i++)
                Container(
                  height: 14,
                  width: 14,
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: i == _selectedIndex
                        ? AppColors.primaryColor
                        : Colors.white,
                    border: Border.all(
                      color: i == _selectedIndex
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
