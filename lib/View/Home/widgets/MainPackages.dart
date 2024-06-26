
import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../../../Controller/pakagecontroller.dart';
import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';
import '../../../utils/servecies.dart';
import '../../Details/View/Details.dart';

class MainPackages extends StatefulWidget {
  var url, title, subtitle, amount,rating,start,end;
  MainPackages({super.key, this.url, this.title, this.subtitle, this.amount,this.rating,required this.start,required this.end});

  @override
  State<MainPackages> createState() => _MainPackagesState();
}

class _MainPackagesState extends State<MainPackages> {


  var isselcted = false;
  var randomIndex;
  var currentImageUrl ="";


  final PageController pageController = PageController();
  int currentIndex = 0;
  @override
  void initState() {
    // startRandomImageTimer();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<pakagecontrollers>(
        builder: (context, packages, child){
          var data = packages.package?.results![widget.url].hotelInfoDetail;

          return Padding(
          padding:  EdgeInsets.symmetric(vertical: responsive(20, context)),
          child: Column(
            children: [

              Stack(
                alignment: Alignment.center,
                children: [

                  Container(
                      width: responsive(400, context),
                      height: responsive(374, context),
                      color: Colors.white,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(responsive(15, context)),
                          child: PageView(
                            controller: pageController,
                            scrollDirection: Axis.horizontal,
                            clipBehavior: Clip.none,
                            children: data!.map((item) => Container(
                              width: double.infinity,
                              // color: currentIndex == context.watch<int>() ? Colors.blue : Colors.white,
                              child: item.hotelPhotos!.isEmpty?CachedNetworkImage(
                                imageUrl: "1231",
                                placeholder: (context, url) => Image.asset('images/placeholder-image.png',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) => Image.asset('images/placeholder-image.png',
                                  fit: BoxFit.cover,
                                ),
                                fit: BoxFit.cover,
                              ): CachedNetworkImage(
                                imageUrl: "${NetworkServices.ibaseUrl}${item.hotelPhotos?[0].hotelPhotos}",
                                placeholder: (context, url) => Image.asset('images/placeholder-image.png',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) => Image.asset('images/placeholder-image.png',
                                  fit: BoxFit.cover,
                                ),
                                fit: BoxFit.cover,
                              ),
                            )).toList(),
                            onPageChanged: (int index) => setState(() => currentIndex = index),
                          ),

                      )

                  ),



                  isselcted?Positioned(
                    top: responsive(20, context),
                    right: responsive(15, context),
                    child: InkWell(
                      onTap: (){
                        setState(() {

                          isselcted = false;
                        });
                      },
                      child: Image.asset(
                        width: responsive(40, context),
                        height: responsive(40, context),
                        'images/heart2.png',



                      ),
                    ),
                  ):  Positioned(
                    top: responsive(20, context),
                    right: responsive(15, context),
                    child: InkWell(
                      onTap: (){
                        setState(() {

                          isselcted = true;
                        });
                      },
                      child: Image.asset(
                        width: responsive(40, context),
                        height: responsive(40, context),
                        'images/heart1.png',



                      ),
                    ),
                  ),
                  Positioned(
                    bottom: responsive(10, context),
                    child: Row(
                      children:  List.generate(data.length, (index) => round(context, index != currentIndex)),
                    ),
                  )

                ],
              ),
              SizedBox(height: responsive(30, context),),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: responsive(5, context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Dcardtrailing(
                      text: '${widget.title}',
                      center: false,
                      context: context,
                    ),

                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          altcardsubtitle(
                              context: context,
                              // center: false,
                              color: AppColors.black,
                              text: '${formatDateString(widget.start)} to ${formatDateString(widget.end)}'
                          ),

                          Tcardtrailing(
                            text: 'Stay 20 days',
                            center: false,
                            context: context,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Dcardtrailing(
                          text: 'PKR ',
                          center: false,
                          context: context,
                        ),

                        cardtrailing(
                          text: '${widget.amount.toStringAsFixed(0)}',
                          center: false,
                          context: context,
                        ),
                      ],
                    ),

                  ],
                ),
              )


            ],
          ),
        );
      }
    );
  }}




Widget round(context,isSelected){
  print(isSelected);
  return Padding(
    padding:  EdgeInsets.only(left: responsive(03, context)),
    child: Container(
      height: responsive(10, context),
      width: responsive(10, context),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          // color: Colors.white
          color: isSelected ?  AppColors.grayboxcolor:AppColors.grayboxcolor

      ),
    ),
  );
}
Widget round2(context,isSelected){
  print(isSelected);
  return Padding(
    padding:  EdgeInsets.only(left: responsive(03, context)),
    child: Container(
      height: responsive(05, context),
      width: responsive(05, context),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          // color: Colors.white
          color: isSelected ?  AppColors.grayboxcolor:AppColors.grayboxcolor

      ),
    ),
  );
}