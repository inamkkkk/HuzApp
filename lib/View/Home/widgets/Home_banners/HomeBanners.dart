
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:huz/Constatns/Constants.dart';


import '../../../../Responsive/ResponsiveClass.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../TextStyles/styles.dart';
import '../../../Details/View/Details.dart';
import '../../../Details/View/detail_screen.dart';

class PageBuilder extends StatefulWidget {
  PageBuilder({
    super.key,
    required this.total,
    required this.package,
    required this.pageController,
    required this.tabList,
    required this.isSelect,
  });

  final PageController pageController;
  final List tabList;
  final int isSelect;
  final int total;

  var package;

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: responsive(190, context),
          child: Transform.translate(
            offset: currentPage == 0
                ? Offset(responsive(-20, context), 0)
                : currentPage == widget.total-1
                ? Offset(responsive(20, context), 0)
                : Offset(0, 0),
            child: PageView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: widget.package.package!.results!.length,
                clipBehavior: Clip.none,
                onPageChanged: (page) {
                  setState(() {
                    currentPage = page;
                    print(currentPage);
                  });
                },
                controller: widget.pageController,
                itemBuilder: (context, index) {
                  var pkg = widget.package.package?.results?[index];
                  var hotelimage;

                  if (widget.tabList[widget.isSelect] == 'Umrah') {
                    String hotelname =
                    pkg?.hotelInfoDetail?[1].hotelName.replaceAll(' ', '_');
                    hotelimage =
                    "https://hajjumrah.co/makkah/${hotelname}_image1.jpg";
                  } else {
                    String hotelname =
                    pkg?.hotelInfoDetail?[1].hotelName.replaceAll(' ', '_');
                    hotelimage =
                    "https://hajjumrah.co/madinah/${hotelname}_image1.jpg";
                  }

                  return Padding(
                      padding: EdgeInsets.only(right: responsive(10, context)),
                      child: GestureDetector(
                        onTap: (){
                          widget.package.details = null;
                          widget.package.isApiCalled = false;
                          widget.package.notifyListeners();

                          Get.to(() => DetailScreen(
                            token: pkg?.huzToken,
                          ));
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          margin: EdgeInsets.only(
                              top: currentPage == index
                                  ? 0
                                  : responsive(20, context)),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(responsive(6, context)),
                                child: Container(
                                  // height: responsive(200, context),

                                  child: CachedNetworkImage(
                                    imageUrl: hotelimage,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    placeholder: (context, url) => Image.asset(
                                      'images/placeholder-image.png',
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          'images/placeholder-image.png',
                                          fit: BoxFit.cover,
                                        ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: responsive(10, context),
                                left:responsive(0, context),
                                right:responsive(0, context),
                                child: Container(
                                  width: responsive(322, context),
                                  color: Colors.black.withOpacity(0.30),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: responsive(15, context),
                                    vertical: responsive(5, context),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          customFonts(
                                            text: pkg?.packageName,
                                            size: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            context: context,
                                          ),
                                          customFonts(
                                            text:
                                            "${formatDateString(pkg?.startDate)} to ${formatDateString(pkg?.endDate)}",
                                            size: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            context: context,
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      customFonts(
                                        text: "${formatCurrency(pkg?.packageCost.toInt())}",
                                        size: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                }),
          ),
        ),
        verticalSpace(20, context),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                widget.package.package!.results!.length,
                    (index) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: responsive(2, context)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: currentPage == index
                        ? responsive(8, context)
                        : responsive(6.4, context),
                    width: currentPage == index
                        ? responsive(8, context)
                        : responsive(6.4, context),
                    decoration: BoxDecoration(
                        color: currentPage == index
                            ? AppColors.GlobelColor
                            : const Color(0xFFB8CCC7),
                        shape: BoxShape.circle),
                  ),
                ))),
      ],
    );
  }
}