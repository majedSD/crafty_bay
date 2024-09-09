import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/model/bannerItem.dart';
import 'package:crafty_bay/presentation/state_holders/home_banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import '../../utility/app_colors.dart';

class BannerCarousel extends StatefulWidget {
  BannerCarousel({super.key,required this.banerList});
  List<BannerItem>banerList;
  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _selectedIndex = 0;
  HomeBannerController homeBannerController=Get.find<HomeBannerController>();
  @override

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 160.0,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _selectedIndex = index;
                });
              }),
          items:widget.banerList.map((banner) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                     child:Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(16.0),
                           child: Column(
                             mainAxisAlignment:MainAxisAlignment.center,
                             children: [
                               SizedBox(
                                 width: 100,
                                 child:Text(banner.title??'',style:const TextStyle(
                                     fontWeight:FontWeight.w600,
                                     fontSize:12,
                                     color: Colors.white
                                 ),),
                               ),
                               const SizedBox(height: 8,),
                               SizedBox(
                                 width: 100,
                                 child:Text(banner.shortDes??'',style:const TextStyle(
                                     fontWeight:FontWeight.w500,
                                     fontSize:10,
                                     color: Colors.white
                                 ),),
                               ),
                             ],
                           ),
                         ),
                         Expanded(child:Image.network(banner.image??'',
                           height: double.infinity,
                           width: double.infinity,
                           fit: BoxFit.fill,),),
                       ],
                     )
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i <widget.banerList.length; i++)
              Container(
                height: 14,
                width: 14,
                margin: const EdgeInsets.all(5),
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
      ],
    );
  }
}
