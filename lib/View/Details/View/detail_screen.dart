import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:huz/Rating/Controller/RatingController.dart';
import 'package:huz/Rating/rating.dart';
import 'package:huz/Rating/show_review_rating.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/TextStyles/AppFonts.dart';
import 'package:huz/View/Booking/View/RequestToBook.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Constatns/Constants.dart';
import '../../../Controller/pakagecontroller.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';
import '../../../Widgets/custom_app_bar.dart';
import '../../../Widgets/snackbar.dart';
import '../../../utils/servecies.dart';
import '../../Booking/Controller/BookingediteController/BookingEditeController.dart';
import '../../Home/widgets/CustomTabs.dart';
import '../../Home/widgets/MainPackages.dart';
import '../../auth/controller/is_user_exist_controller.dart';
import '../../auth/view/sign_up_with_mobile_number/signup_with_mobile_num.dart';
import '../../wishlist/controller/wishlist_controller.dart';
import '../../wishlist/model/wishlist_model.dart';

class DetailScreen extends StatefulWidget {
  var token;
  var isView;

  DetailScreen({super.key, required this.token, this.isView = false});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var selected = 0;

  final WishListController wishController = WishListController();

  Widget bottombar() {
    return Consumer3<pakagecontrollers, Bookingedite, IsUserExitsController>(
        builder: (context, packages, booking, user, child) {
      return InkWell(
        onTap: () {
          booking.price = packages.details?.packageCost;
          booking.subtractprice = packages.details?.packageCost;
          booking.initialstartdate =
              formatDateString(packages.details?.startDate);

          booking.initialenddate = formatDateString(packages.details?.endDate);

          booking.startDate = formatDateString(packages.details?.startDate);
          print(booking.initialstartdate);
          booking.endDate = formatDateString(packages.details?.endDate);
          booking.combineNights =
              packages.details?.madinahNights + packages.details?.meccaNights;
          booking.isedite = false;
          booking.notifyListeners();
          // Get.to(SignUpWithMobile());
          Get.to(const RequestToBook());
        },
        child: packages.details == null
            ? SizedBox()
            : Container(
                height: responsive(55, context),
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.GlobelColor,
                      width: 2.0, // Adjust border width as needed
                    ),
                  ),
                  color: AppColors.GlobelColor,
                ),

                // notchMargin: 20,
                // shape: const CircularNotchedRectangle(),
                // notchMargin: 20,
                child: Center(
                  child: Heading44(
                      text: 'Book Now',
                      context: context,
                      center: true,
                      color: Colors.white),
                )),
      );
    });
  }

  void _loadTasks() async {
    final loadedTasks = await wishController.getTasks();
    setState(() {
      wishController.list = loadedTasks;
    });
  }

  void _addTask(
      {required var packageImage,
      required var id,
      required var packageName,
      required var startDate,
      required var endDate,
      required var include,
      required var cost}) async {
    final wish = WishList(
        packageImage: packageImage,
        id: id,
        packageName: packageName,
        startDate: startDate,
        endDate: endDate,
        incldues: include,
        cost: cost);
    await wishController.addTask(wish);
    wishController.notifyListeners();

    print("************");
    print("$packageName $startDate $endDate $cost)");

    _loadTasks();
  }

  void _removeTask(WishList wish) async {
    // wishController.isFav = false;
    await wishController.removeTask(wish);
    wishController.notifyListeners();
    _loadTasks();
  }

  bool toggle(List wishlist, String packageId, isDelete) {
    for (var m in wishlist) {
      if (m.id == packageId) {
        if (isDelete) _removeTask(m);
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<pakagecontrollers>(builder: (context, packages, child) {
      if (packages.details == null) {
        packages.GetDetails(widget.token, context);
      }
      var pkg = packages.details?.hotelDetail;
      return Scaffold(
        bottomNavigationBar: widget.isView ? const SizedBox() : bottombar(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: CustomAppBar(
            title: "Package Detail",
          ),
        ),
        body: packages.isApiCalled == false
            ? Container(
                height: MediaQuery.sizeOf(context).height,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.GlobelColor,
                  ),
                ),
              )
            : Stack(alignment: Alignment.bottomCenter, children: [
                SingleChildScrollView(
                  // physics: BouncingScrollPhysics(),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Divider(
                                thickness: responsive(4.0, context),
                                color: const Color(0xffF2F2F2),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: responsive(0, context),
                                    horizontal: responsive(20, context)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: responsive(20, context),),
                                    //  MainPicture(url: packages.details?.hotelDetail,),
                                    SizedBox(
                                      height: responsive(20, context),
                                    ),

                                    Headertitle(
                                      context,
                                      packages.details?.packageName,
                                      "${formatDateString(packages.details?.startDate ?? "2023-01-01T00:00")} to ${formatDateString(packages.details?.endDate ?? "2023-01-01T00:00")}",
                                      formatCurrency(packages
                                              .details?.packageCost
                                              .toInt() ??
                                          0),
                                      () {
                                        // isFav = toggle(wishController.list, pkg?.huzToken, true);
                                        // if (isFav) {
                                        // } else {
                                        //
                                        //   _addTask(
                                        //     packageImage: hotelimage,
                                        //     id: pkg?.huzToken,
                                        //     packageName: pkg?.packageName,
                                        //     include: packagecontroller?.allincludes[index],
                                        //     startDate: pkg?.startDate,
                                        //     endDate: pkg?.endDate,
                                        //     cost: pkg?.packageCost,
                                        //   );
                                        // }
                                      },
                                      SvgPicture.asset(
                                        "images/Shape.svg",
                                      ),
                                      // packages.isFav ? SvgPicture.asset(
                                      //   "images/heart_icon_fill.svg",
                                      // ) : SvgPicture.asset(
                                      //   "images/Shape.svg",
                                      // ),
                                    ),

                                    SizedBox(
                                      height: responsive(3, context),
                                    ),
                                    customFonts(
                                        text:
                                            packages.details?.description ?? "",
                                        size: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryBlackColor,
                                        context: context),

                                    SizedBox(
                                      height: responsive(10, context),
                                    ),
                                    Row(
                                      children: [
                                        BoxWidget(
                                          '${packages.details?.madinahNights}',
                                          'Medina Nights',
                                          context,
                                        ),
                                        SizedBox(
                                          width: responsive(10, context),
                                        ),
                                        BoxWidget(
                                          '${packages.details?.meccaNights}',
                                          'Meca Nights',
                                          context,
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: responsive(10, context),
                                    ),
                                    Container(
                                      // width: responsive(350, context),
                                      child: Wrap(
                                        spacing: 0.0,
                                        children: List.generate(
                                          packages.include.length,
                                          (index) => index == 0
                                              ? customFonts(
                                                  text: "Includes: ",
                                                  size: 14,
                                                  color: AppColors
                                                      .primaryBlackColor,
                                                  fontWeight: FontWeight.bold,
                                                  context: context)
                                              : customFonts(
                                                  text:
                                                      "${packages.include[index]}",
                                                  size: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors
                                                      .primaryBlackColor,
                                                  context: context),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: responsive(10, context),
                                    ),

                                    SizedBox(
                                      height: responsive(0, context),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        ListView.builder(
                            shrinkWrap: true,
                            primary: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: pkg?.length,
                            itemBuilder: (context, index) {
                              print(pkg?[index].hotelName);
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: responsive(20, context),
                                    vertical: responsive(04, context)),
                                child: HotelContainer(
                                    index: index,
                                    roomType: pkg?[index].roomSharingType,
                                    hotelName: pkg?[index].hotelName,
                                    city: pkg?[index].hotelCity,
                                    distance: pkg?[index].hotelDistance,
                                    rating: pkg?[index].hotelRating,
                                    context: context),
                              );
                            }),

                        // MainPackagess(
                        //     url: 1,
                        //     title: pkg?[1].hotelName,
                        //     subtitle: pkg?[0].roomSharingType,
                        //     amount: pkg?[1].hotelRating,
                        //     service: pkg?[1].isShuttleServicesIncluded,
                        //     distance:
                        //         "${pkg?[1].hotelDistance}${pkg?[1].distanceType}",
                        //     city: pkg?[1].hotelCity),
                        verticalSpace(20, context),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive(20, context)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  customFonts(
                                      text:
                                          "${packages.details?.airlineDetail?[0].airlineName} Airline",
                                      size: 14,
                                      color: AppColors.primaryBlackColor
                                          .withOpacity(0.9),
                                      fontWeight: FontWeight.w700,
                                      context: context),
                                  SizedBox(
                                    width: responsive(05, context),
                                  ),
                                  SvgPicture.asset(
                                    width: responsive(20, context),
                                    height: responsive(15, context),
                                    'images/airplance.svg',
                                    semanticsLabel: 'vector',
                                    // fit: BoxFit.fitHeight,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: responsive(04, context),
                              ),
                              // customFonts(text: "Islamabad to Jeddah",
                              //     size: 12,
                              //     color: AppColors.primaryBlackColor,
                              //     fontWeight: FontWeight.w500,
                              //     context: context),
                              // verticalSpace(5, context),
                              Wrap(
                                spacing: responsive(5.0, context),
                                // Adjust spacing between elements
                                // runSpacing: .0,
                                children: [
                                  SizedBox(
                                      width: responsive(140, context),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            width: responsive(12, context),
                                            height: responsive(12, context),
                                            'images/include.svg',
                                            semanticsLabel: 'vector',
                                            // fit: BoxFit.fitHeight,
                                          ),
                                          SizedBox(
                                            width: responsive(08, context),
                                          ),
                                          customFonts(
                                              text:
                                                  '${packages.details?.airlineDetail?[0].ticketType} Ticket',
                                              size: 14,
                                              color:
                                                  AppColors.primaryBlackColor,
                                              fontWeight: FontWeight.w500,
                                              context: context),
                                          SizedBox(
                                            width: responsive(08, context),
                                          )
                                        ],
                                      )),
                                  SizedBox(
                                      width: responsive(150, context),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            width: responsive(12, context),
                                            height: responsive(12, context),
                                            packages.details?.airlineDetail?[0]
                                                    .isReturnFlightIncluded
                                                ? 'images/include.svg'
                                                : 'images/exclude.svg',
                                            semanticsLabel: 'vector',
                                            // fit: BoxFit.fitHeight,
                                          ),
                                          SizedBox(
                                            width: responsive(8, context),
                                          ),
                                          customFonts(
                                              text: '${'Return flight'}',
                                              size: 14,
                                              color:
                                                  AppColors.primaryBlackColor,
                                              fontWeight: FontWeight.w500,
                                              context: context),
                                        ],
                                      )),
                                ],
                              ),
                              //-----------------------//
                              SizedBox(
                                height: responsive(10, context),
                              ),
                              Row(
                                children: [
                                  customFonts(
                                      text: "Shared Luxury Bus ",
                                      size: 14,
                                      color: AppColors.primaryBlackColor
                                          .withOpacity(0.9),
                                      fontWeight: FontWeight.w700,
                                      context: context),
                                  SizedBox(
                                    width: responsive(05, context),
                                  ),
                                  SvgPicture.asset(
                                    width: responsive(16, context),
                                    height: responsive(14.2, context),
                                    'images/bus_icon.svg',
                                    semanticsLabel: 'vector',
                                    // fit: BoxFit.fitHeight,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: responsive(04, context),
                              ),
                              Container(
                                child: Wrap(
                                  spacing: 04.0,
                                  // Adjust spacing between elements
                                  // runSpacing: 5.0,

                                  children: packages.routs,
                                ),
                              ),
                              SizedBox(
                                height: responsive(20, context),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      packages.ziarat.isNotEmpty
                                          ? showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          responsive(
                                                              15, context)),
                                                      topRight: Radius.circular(
                                                          responsive(
                                                              15, context)),
                                                    ),
                                                  ),
                                                  // height: responsive(100, context),
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                          .width,

                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                responsive(20,
                                                                    context),
                                                            horizontal:
                                                                responsive(20,
                                                                    context)),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          Heading4(
                                                            center: false,
                                                            context: context,
                                                            text:
                                                                'Mecca & Madina Ziyarah',
                                                          ),
                                                          Container(
                                                            child: Wrap(
                                                              spacing: 10.0,
                                                              // Adjust spacing between elements
                                                              // runSpacing: 5.0,

                                                              children: packages
                                                                  .ziarat,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })
                                          : showSnackbar(
                                              context, "No places found ");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: responsive(10, context)),
                                      height: responsive(35, context),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: AppColors.GlobelColor,
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            responsive(05, context)),
                                      ),
                                      child: Center(
                                        child: customFonts(
                                            text: "Mecca & Madinah Ziyarah",
                                            size: 16,
                                            context: context,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(7, context),
                                  InkWell(
                                    onTap: () {
                                      // showModalBottomSheet(
                                      //   context: context,
                                      //   builder: (BuildContext context) {
                                      //     return Container(
                                      //       decoration: BoxDecoration(
                                      //         color: Colors.white,
                                      //         borderRadius: BorderRadius.only(
                                      //           topLeft: Radius.circular(
                                      //               responsive(15, context)),
                                      //           topRight: Radius.circular(
                                      //               responsive(15, context)),
                                      //         ),
                                      //       ),
                                      //       // height: responsive(100, context),
                                      //       width: MediaQuery.sizeOf(context)
                                      //           .width,
                                      //
                                      //       child: Padding(
                                      //         padding: EdgeInsets.symmetric(
                                      //             vertical:
                                      //             responsive(20, context),
                                      //             horizontal:
                                      //             responsive(20, context)),
                                      //         child: SingleChildScrollView(
                                      //           child: Column(
                                      //             children: [
                                      //               Heading4(
                                      //                 center: false,
                                      //                 context: context,
                                      //                 text:
                                      //                 'Reviews & Rating',
                                      //               ),
                                      //               Container(
                                      //                 // child: Wrap(
                                      //                 //   spacing: 10.0,
                                      //                 //   // Adjust spacing between elements
                                      //                 //   // runSpacing: 5.0,
                                      //                 //
                                      //                 //   children:
                                      //                 //
                                      //                 // ),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     );
                                      //   },
                                      // );
                                      Get.to(() => ShowReviewRating(
                                          response: 4.5,
                                          quality: 4.2,
                                          platform: 3.5,
                                          conierge: 5.0,
                                          support: 3.4,
                                          huzComment: "Our prayers are with huz. they brought us best platform",
                                          partnerComment: "We are very satisfied by their service",
                                          huzplatform: 5.0,
                                          pStars: 5.0));
                                      // showSnackbar(context, "No Reviews or Rating found !");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: responsive(10, context)),
                                      height: responsive(35, context),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: AppColors.GlobelColor,
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            responsive(05, context)),
                                      ),
                                      child: Center(
                                          child: customFonts(
                                              text: "Reviews & Rating",
                                              size: 16,
                                              context: context,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: responsive(30, context),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
      );
    });
  }

  Widget HotelWidget(var url, status, context, color, ontap()) {
    return InkWell(
      onTap: ontap,
      child: Container(
          // height: MediaQuery.of(context).size.height * (82 / 667),
          width: MediaQuery.of(context).size.width * (145 / 375),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            color: color,
            border: Border.all(
              color: const Color(0xff00936C),
              width: 2,
            ),
          ),
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: responsive(05, context),
                  horizontal: responsive(20, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: responsive(07, context)),
                    child: Text(
                      '$status',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color.fromRGBO(55, 55, 55, 1),
                          fontFamily: 'Poppins',
                          fontSize: responsive(14, context),
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.w500,
                          height: 1),
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    width: responsive(30, context),
                    height: responsive(30, context),
                    '$url',
                    // fit: BoxFit.fitHeight,
                  ),
                ],
              ))),
    );
  }

  var clicklist = [
    true,
    false,
  ];
}

Widget Circualbutton(context, url) {
  return Padding(
    padding: EdgeInsets.only(right: responsive(10, context)),
    child: Container(
      width: responsive(40, context),
      height: responsive(40, context),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 1),
              blurRadius: 20)
        ],
        color: Color.fromRGBO(242, 245, 250, 1),
        borderRadius: BorderRadius.all(Radius.elliptical(46.125, 45)),
      ),
      child: Padding(
        padding: EdgeInsets.all(responsive(13, context)),
        child: SvgPicture.asset(
          width: responsive(12, context),
          height: responsive(12, context),
          '$url',
          semanticsLabel: 'vector',
          // fit: BoxFit.fitHeight,
        ),
      ),
    ),
  );
}

Widget Headertitle(context, title, subtitle, amount, onTapFav, icon) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customFonts(
              text: title ?? "",
              size: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlackColor.withOpacity(0.9),
              context: context),
          SizedBox(
            height: responsive(2, context),
          ),
          customFonts(
              text: subtitle,
              size: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryBlackColor,
              context: context),
          SizedBox(
            height: responsive(2, context),
          ),
          customFonts(
              text: "PKR ${amount}",
              size: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF484848),
              context: context),
        ],
      ),
      Row(
        children: [
          GestureDetector(
            onTap: onTapFav,
            child: Container(
                alignment: Alignment.center,
                height: responsive(24, context),
                width: responsive(24, context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE3E1E1))),
                child: icon),
          ),
          horizontalSpace(5, context),
          SvgPicture.asset(
            width: responsive(61, context),
            height: responsive(26, context),
            'images/share.svg',
            semanticsLabel: 'vector',
            // fit: BoxFit.fitHeight,
          ),
        ],
      ),
    ],
  );
}

Widget detailscedualbox(context, date) {
  return Container(
      width: responsive(100, context),
      height: responsive(40, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(responsive(10, context)),
        ),
        color: const Color.fromRGBO(255, 253, 253, 1),
        border: Border.all(
          color: AppColors.grayboxcolor,
          width: 1,
        ),
      ));
}

String formatDateString(String inputString) {
  // Parse the input string into a DateTime object
  DateTime dateTime = DateTime.parse(inputString);

  // Format the DateTime object into the desired format
  String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);

  return formattedDate;
}

Widget BoxWidget(var number, status, context) {
  return Container(
      // height: MediaQuery.of(context).size.height * (82 / 667),
      width: MediaQuery.of(context).size.width * (164 / 375),
      height: responsive(30, context),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        color: const Color(0xffF1F1F1),
        border: Border.all(
          color: const Color(0xffE5E4E4),
          width: 2,
        ),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: responsive(20, context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$status',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primaryBlackColor,
                    fontFamily: 'Poppins',
                    fontSize: responsive(12, context),
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.w400,
                    height: 1),
              ),
              horizontalSpace(5, context),
              Text(
                "$number",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.GlobelColor,
                    fontFamily: AppFonts.poppinsExtraBold,
                    fontSize: responsive(12, context),
                    letterSpacing:
                        0 /*p6ercentages not used in flutter. defaulting to zero*/,
                    height: 1),
              ),
            ],
          )));
}

Widget HotelWidget(var url, status, context) {
  return Container(
      // height: MediaQuery.of(context).size.height * (82 / 667),
      width: MediaQuery.of(context).size.width * (145 / 375),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        color: const Color(0xffF2F2F3),
        border: Border.all(
          color: const Color(0xff00936C),
          width: 2,
        ),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: responsive(10, context),
              horizontal: responsive(20, context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: responsive(07, context)),
                child: Text(
                  '$status',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: const Color.fromRGBO(55, 55, 55, 1),
                      fontFamily: 'Poppins',
                      fontSize: responsive(14, context),
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.w500,
                      height: 1),
                ),
              ),
              const Spacer(),
              Image.asset(
                width: responsive(30, context),
                height: responsive(30, context),
                '$url',
                // fit: BoxFit.fitHeight,
              ),
            ],
          )));
}

class HotelContainer extends StatefulWidget {
  var image;
  var hotelName;
  var city;
  var roomType;
  var index;
  var includeList;
  var excludeList;
  var distance;
  var rating;
  var context;

  HotelContainer(
      {super.key,
      required this.index,
      required this.hotelName,
      required this.roomType,
      required this.city,
      required this.distance,
      this.includeList,
      this.excludeList,
      this.rating,
      required this.context});

  @override
  State<HotelContainer> createState() => _HotelContainerState();
}

class _HotelContainerState extends State<HotelContainer> {
  int currentPage = 0;
  var currentImageUrl = "";
  var randomIndex;

  final PageController pageController = PageController();
  int currentIndex = 0;
  var hotelList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<pakagecontrollers>(builder: (context, packages, child) {
      String hotelname = widget.hotelName.replaceAll(' ', '_');
      var data = packages.details?.hotelDetail?[widget.index].hotelPhotos;
      hotelList = widget.city == "Madinah"
          ? [
              "https://hajjumrah.co/madinah/${hotelname}_image1.jpg",
              "https://hajjumrah.co/madinah/${hotelname}_image2.jpg",
              "https://hajjumrah.co/madinah/${hotelname}_image3.jpg",
              "https://hajjumrah.co/madinah/${hotelname}_image4.jpg"
            ]
          : [
              "https://hajjumrah.co/makkah/${hotelname}_image1.jpg",
              "https://hajjumrah.co/makkah/${hotelname}_image2.jpg",
              "https://hajjumrah.co/makkah/${hotelname}_image3.jpg",
              "https://hajjumrah.co/makkah/${hotelname}_image4.jpg",
            ];

      print(hotelList);

      print('${NetworkServices.ibaseUrl}');
      return Container(
        padding: EdgeInsets.all(responsive(5, context)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(responsive(6, context)),
            border: Border.all(color: const Color(0xFFDEDEDE))),
        height: responsive(128, context),
        width: responsive(382, context),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width: responsive(118, context),
                    height: responsive(129, context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(responsive(10, context)),
                        topRight: Radius.circular(responsive(10, context)),
                        bottomRight: Radius.circular(responsive(10, context)),
                        bottomLeft: Radius.circular(responsive(10, context)),
                      ),
                      child: PageView(
                        controller: pageController,
                        scrollDirection: Axis.horizontal,
                        children: hotelList!.map((item) {
                          return Container(
                            width: double.infinity,
                            // color: currentIndex == context.watch<int>() ? Colors.blue : Colors.white,
                            child: CachedNetworkImage(
                              imageUrl: "${item}",
                              placeholder: (context, url) => Image.asset(
                                'images/placeholder-image.png',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'images/placeholder-image.png',
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                        onPageChanged: (int index) =>
                            setState(() => currentIndex = index),
                      ),
                    )),
                Positioned(
                  bottom: responsive(10, context),
                  child: Row(
                    children: List.generate(
                        hotelList.isEmpty ? 1 : hotelList.length,
                        (index) => round2(context, index != currentIndex)),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: responsive(10, context),
                  top: responsive(5, context),
                  bottom: responsive(5, context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customFonts(
                            text: widget.hotelName,
                            size: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlackColor,
                            context: context),
                        customFonts(
                            text: widget.roomType,
                            size: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryBlackColor,
                            context: context),
                      ],
                    ),
                    Wrap(
                      spacing: 00.0,
                      children: [
                        customFonts(
                            text: "Includes: ",
                            size: 12,
                            color: AppColors.primaryBlackColor,
                            fontWeight: FontWeight.bold,
                            context: context),
                        Visibility(
                          visible: packages.details?.hotelDetail?[widget.index]
                                  .isAirCondition
                              ? true
                              : false,
                          child: customFonts(
                              text: "Air Condition - ",
                              size: 12,
                              color: AppColors.primaryBlackColor,
                              fontWeight: FontWeight.w500,
                              context: context),
                        ),
                        Visibility(
                            visible: packages
                                    .details
                                    ?.hotelDetail?[widget.index]
                                    .isAttachBathroom
                                ? true
                                : false,
                            child: customFonts(
                                text: "Attached Bathroom - ",
                                size: 12,
                                color: AppColors.primaryBlackColor,
                                fontWeight: FontWeight.w500,
                                context: context)),
                        Visibility(
                            visible: packages.details
                                    ?.hotelDetail?[widget.index].isElevator
                                ? true
                                : false,
                            child: customFonts(
                                text: "Elevator - ",
                                size: 12,
                                color: AppColors.primaryBlackColor,
                                fontWeight: FontWeight.w500,
                                context: context)),
                        Visibility(
                            visible: packages.details
                                    ?.hotelDetail?[widget.index].isLaundry
                                ? true
                                : false,
                            child: customFonts(
                                text: "Laundry - ",
                                size: 12,
                                color: AppColors.primaryBlackColor,
                                fontWeight: FontWeight.w500,
                                context: context)),
                        Visibility(
                            visible: packages.details
                                    ?.hotelDetail?[widget.index].isTelevision
                                ? true
                                : false,
                            child: customFonts(
                                text: "Television - ",
                                size: 12,
                                color: AppColors.primaryBlackColor,
                                fontWeight: FontWeight.w500,
                                context: context)),
                        Visibility(
                            visible: packages.details
                                    ?.hotelDetail?[widget.index].isEnglishToilet
                                ? true
                                : false,
                            child: customFonts(
                                text: "English Toilet - ",
                                size: 12,
                                color: AppColors.primaryBlackColor,
                                fontWeight: FontWeight.w500,
                                context: context)),
                        Visibility(
                            visible: packages.details
                                    ?.hotelDetail?[widget.index].isIndianToilet
                                ? true
                                : false,
                            child: customFonts(
                                text: "Indian Toilet - ",
                                size: 12,
                                color: AppColors.primaryBlackColor,
                                fontWeight: FontWeight.w500,
                                context: context)),
                        Visibility(
                            visible: packages
                                    .details
                                    ?.hotelDetail?[widget.index]
                                    .isShuttleServicesIncluded
                                ? true
                                : false,
                            child: customFonts(
                                text: "Shuttle Services - ",
                                size: 12,
                                color: AppColors.primaryBlackColor,
                                fontWeight: FontWeight.w500,
                                context: context)),
                        Visibility(
                            visible: packages
                                    .details
                                    ?.hotelDetail?[widget.index]
                                    .isWashroomAmenities
                                ? true
                                : false,
                            child: customFonts(
                                text: "Amentites - ",
                                size: 12,
                                color: AppColors.primaryBlackColor,
                                fontWeight: FontWeight.w500,
                                context: context)),
                        Visibility(
                            visible: packages
                                    .details?.hotelDetail?[widget.index].isWifi
                                ? true
                                : false,
                            child: customFonts(
                                text: "Wifi",
                                size: 12,
                                color: AppColors.primaryBlackColor,
                                fontWeight: FontWeight.w500,
                                context: context)),
                      ],
                    ),
                    SizedBox(
                      width: responsive(300, context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: responsive(130, context),
                            child: customFonts(
                                text:
                                    "${widget.distance} km from ${widget.city}",
                                size: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryBlackColor
                                    .withOpacity(0.9),
                                context: context),
                          ),
                          Row(
                            children: [
                              customFonts(
                                  text: widget.rating,
                                  size: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryBlackColor
                                      .withOpacity(0.9),
                                  context: context),
                              horizontalSpace(5, context),
                              SvgPicture.asset(
                                "images/star.svg",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class MainPackagess extends StatefulWidget {
  var url, title, subtitle, amount, service, distance, city;

  MainPackagess(
      {super.key,
      this.url,
      this.title,
      this.subtitle,
      this.amount,
      required this.service,
      required this.distance,
      required this.city});

  @override
  State<MainPackagess> createState() => _MainPackagessState();
}

class _MainPackagessState extends State<MainPackagess> {
  var currentImageUrl = "";
  var randomIndex;

  final PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<pakagecontrollers>(builder: (context, packages, child) {
      var data = packages.details?.hotelDetail?[widget.url].hotelPhotos;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: responsive(20, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width: responsive(405, context),
                    height: responsive(374, context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(responsive(10, context)),
                        topRight: Radius.circular(responsive(10, context)),
                      ),
                      child: PageView(
                        controller: pageController,
                        scrollDirection: Axis.horizontal,
                        children: data!
                            .map((item) => Container(
                                  width: double.infinity,
                                  // color: currentIndex == context.watch<int>() ? Colors.blue : Colors.white,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "${NetworkServices.ibaseUrl}${item.hotelPhotos}",
                                    placeholder: (context, url) => Image.asset(
                                      'images/placeholder-image.png',
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'images/placeholder-image.png',
                                      fit: BoxFit.cover,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ))
                            .toList(),
                        onPageChanged: (int index) =>
                            setState(() => currentIndex = index),
                      ),
                    )),
                Positioned(
                  bottom: responsive(10, context),
                  child: Row(
                    children: List.generate(data.length,
                        (index) => round(context, index != currentIndex)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: responsive(15, context),
            ),
            Row(
              children: [
                Heading4(
                  text: '${widget.title}',
                  context: context,
                  center: false,
                ),
                SizedBox(
                  width: responsive(10, context),
                ),
                SvgPicture.asset(
                  width: responsive(12, context),
                  height: responsive(12, context),
                  'images/${widget.amount}.svg',
                  semanticsLabel: 'vector',
                  // fit: BoxFit.fitHeight,
                ),
              ],
            ),
            SizedBox(
              height: responsive(03, context),
            ),
            Padding(
              padding: EdgeInsets.only(right: responsive(02, context)),
              child: Wrap(
                spacing: 04.0,
                children: [
                  widgts('${widget.subtitle}', context, 80),
                  widgts(
                    '${widget.distance ?? 0} from ${widget.city}',
                    context,
                    210,
                  ),
                  Visibility(
                    visible: packages
                            .details?.hotelDetail?[widget.url].isAirCondition
                        ? true
                        : false,
                    child: widgts(
                      'Air Condition',
                      context,
                      140,
                    ),
                  ),
                  Visibility(
                    visible: packages
                            .details?.hotelDetail?[widget.url].isAttachBathroom
                        ? true
                        : false,
                    child: widgts('Attached Bathroom', context, 150),
                  ),
                  Visibility(
                    visible:
                        packages.details?.hotelDetail?[widget.url].isElevator
                            ? true
                            : false,
                    child: widgts('Elevator', context, 80),
                  ),
                  Visibility(
                    visible:
                        packages.details?.hotelDetail?[widget.url].isLaundry
                            ? true
                            : false,
                    child: widgts('Laundry', context, 80),
                  ),
                  Visibility(
                    visible:
                        packages.details?.hotelDetail?[widget.url].isTelevision
                            ? true
                            : false,
                    child: widgts('Television', context, 100),
                  ),
                  Visibility(
                    visible: packages
                            .details?.hotelDetail?[widget.url].isEnglishToilet
                        ? true
                        : false,
                    child: widgts('English toilet', context, 140),
                  ),
                  Visibility(
                    visible: packages
                            .details?.hotelDetail?[widget.url].isIndianToilet
                        ? true
                        : false,
                    child: widgts('Indian toilet', context, 105),
                  ),
                  Visibility(
                    visible: packages.details?.hotelDetail?[widget.url]
                            .isShuttleServicesIncluded
                        ? true
                        : false,
                    child: widgts('Shuttel service', context, 150),
                  ),
                  Visibility(
                    visible: packages.details?.hotelDetail?[widget.url]
                            .isWashroomAmenities
                        ? true
                        : false,
                    child: widgts('Amentities', context, 100),
                  ),
                  Visibility(
                    visible: packages.details?.hotelDetail?[widget.url].isWifi
                        ? true
                        : false,
                    child: widgts('wifi', context, 80),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

Widget widgts(name, context, size) {
  return Container(
    width: responsive(size, context),
    child: Row(
      children: [
        SvgPicture.asset(
          width: responsive(12, context),
          height: responsive(12, context),
          'images/include.svg',
          semanticsLabel: 'vector',
          // fit: BoxFit.fitHeight,
        ),
        SizedBox(
          width: responsive(06, context),
        ),
        Discription(
          center: false,
          text: '$name',
          context: context,
        ),
        SizedBox(
          width: responsive(04, context),
        )
      ],
    ),
  );
}
