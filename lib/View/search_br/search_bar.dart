

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huz/View/Details/View/detail_screen.dart';
import 'package:huz/View/search_br/widgets/range_slider.dart';
import 'package:huz/Widgets/custom_app_bar.dart';

import 'package:huz/Widgets/date_picker/date_picker.dart';
import 'package:huz/Widgets/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Constatns/Constants.dart';
import '../../Controller/pakagecontroller.dart';
import '../../Responsive/ResponsiveClass.dart';
import '../../TextStyles/Color.dart';
import '../../TextStyles/styles.dart';
import '../Booking/Controller/BookingediteController/BookingEditeController.dart';
import '../Booking/Widgets/Bookingeditecard.dart';

class SearchBarScreen extends StatefulWidget {
  // var startDate, endDate;
  const SearchBarScreen({
    super.key,
  });

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  int adultsCount = 1;
  int childsCount = 0;

  var searchList = [];

  var selectedStartDate;
  var selectedEndDate;
  var isFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          title: "Search your Trip",
        ),
      ),
      body: Consumer2<Bookingedite, pakagecontrollers>(
          builder: (context, booking, package, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isFound
                ? Expanded(
                  child: Column(
                      // height: responsive(300, context),
                      children: List.generate(searchList.length, (index) => searchList[index]),
                    ),
                )
                : Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(bottom: responsive(20, context)),
                      children: [
                        // Flight search Bar

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive(20, context),
                              vertical: responsive(20, context)),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  responsive(50, context)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.12),

                                  blurRadius: responsive(10,
                                      context), // Assuming responsive() function returns the responsive blur radius
                                ),
                              ],
                            ),
                            child: TextFormField(
                              // focusNode: partnerFocusNode,
                              // controller: partnerCommentController,

                              maxLines: 1,
                              onFieldSubmitted: (value) {},
                              validator: (value) {
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  fontFamily: GoogleFonts.cairo().fontFamily,
                                  fontSize: responsive(15, context)),
                              cursorColor: AppColors.GlobelColor,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: responsive(20, context),
                                ),
                                hintText: 'Flight from',
                                hintStyle: TextStyle(
                                  fontFamily: GoogleFonts.cairo().fontFamily,
                                  fontSize: responsive(15, context),
                                  color: Colors.black,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),

                        // Adjust Pricing

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive(20, context)),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.12),

                                    blurRadius:
                                    10, // Assuming responsive() function returns the responsive blur radius
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                    responsive(20, context),
                                  ),
                                  bottom: Radius.circular(
                                    responsive(20, context),
                                  ),
                                )),
                            padding: EdgeInsets.symmetric(vertical: responsive(30, context)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: responsive(30, context)),
                                  child: customFonts(
                                      text: "Your budget",
                                      size: 18,
                                      fontWeight: FontWeight.w600,
                                      context: context),
                                ),
                                verticalSpace(10, context),

                                Column(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: responsive(10, context)),
                                      child: PriceRangeSlider(),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: responsive(30, context)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          customFonts(text: "80,000", size: 16, context: context),
                                          customFonts(text: "10,000,00", size: 16, context: context),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        verticalSpace(20, context),


                        // Adjust date

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive(20, context)),
                          child: CustomDatePicker(
                            isSearch: true,
                            title: "When's your trip",
                            submite: (value) {
                              Navigator.pop(context);
                            },
                            endDate:
                                DateFormat('dd MMM yyyy').parse("19 Oct 2023"),
                            mindate:
                                DateFormat('dd MMM yyyy').parse("19 Oct 2023"),
                            initialdate:
                                DateFormat('dd MMM yyyy').parse("19 Oct 2023"),
                            onselectchanged: (date) {
                              String formattedDate = DateFormat('dd MMM yyyy')
                                  .format(date.value.startDate!);
                              print(formattedDate);
                              String edate = DateFormat('dd MMM yyyy')
                                  .format(date.value.endDate);
                              print(formattedDate);
                              // startdate1 = edate;
                              // enddate2 = formattedDate;
                              booking.isedite = true;

                              setState(() {
                                package.isApiCalled = true;

                                selectedStartDate = formattedDate;

                                print("Start date : $selectedStartDate");
                                selectedEndDate = edate;

                                print(
                                    "Start date from pakcgae : ${booking.startDate}");

                                print("End date : $selectedEndDate");
                              });
                            },
                          ),
                        ),



                        verticalSpace(20, context),
                        // adjust guests
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive(20, context)),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.12),

                                    blurRadius:
                                        10, // Assuming responsive() function returns the responsive blur radius
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                    responsive(20, context),
                                  ),
                                  bottom: Radius.circular(
                                    responsive(20, context),
                                  ),
                                )),
                            padding: EdgeInsets.all(responsive(30, context)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customFonts(
                                    text: "Who's coming",
                                    size: 18,
                                    fontWeight: FontWeight.w600,
                                    context: context),
                                verticalSpace(20, context),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customFonts(
                                            text: "Adults",
                                            size: 15,
                                            fontWeight: FontWeight.bold,
                                            context: context),
                                        customFonts(
                                            text: "Age 13+",
                                            size: 13,
                                            context: context),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (adultsCount > 1) {
                                              setState(() {
                                                adultsCount--;
                                              });
                                            }
                                            // booking.adults = adultCount;
                                            // booking.isedite = true;
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: responsive(42, context),
                                            width: responsive(42, context),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child: SvgPicture.asset(
                                              "images/minus.svg",
                                              height: responsive(2, context),
                                              width: responsive(2, context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: responsive(15, context),
                                        ),
                                        customFonts(
                                            text: "$adultsCount",
                                            size: 15,
                                            context: context),
                                        SizedBox(
                                          width: responsive(15, context),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (adultsCount >= 1) {
                                              setState(() {
                                                adultsCount++;

                                                print(
                                                    "adult count: $adultCount");
                                              });
                                            }
                                            // booking.adults = adultCount;
                                            // booking.isedite = true;
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: responsive(42, context),
                                            width: responsive(42, context),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child: SvgPicture.asset(
                                              "images/plus.svg",
                                              height: responsive(12, context),
                                              width: responsive(12, context),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: responsive(20, context),
                                ),

                                // SizedBox(height: responsive(20, context),),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customFonts(
                                            text: "Children",
                                            size: 15,
                                            fontWeight: FontWeight.bold,
                                            context: context),
                                        customFonts(
                                            text: "Age 2-12+",
                                            size: 13,
                                            context: context),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (childsCount > 0) {
                                                setState(() {
                                                  childCount--;
                                                });
                                              }
                                            });
                                            // booking.childrens = childCount;
                                            // booking.isedite = true;
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: responsive(42, context),
                                            width: responsive(42, context),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child: SvgPicture.asset(
                                              "images/minus.svg",
                                              height: responsive(2, context),
                                              width: responsive(2, context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: responsive(15, context),
                                        ),
                                        customFonts(
                                            text: "$childsCount",
                                            size: 15,
                                            context: context),
                                        SizedBox(
                                          width: responsive(15, context),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (childsCount >= 0) {
                                                setState(() {
                                                  childsCount++;
                                                });
                                              }
                                            });

                                            // booking.isedite = true;
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: responsive(42, context),
                                            width: responsive(42, context),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child: SvgPicture.asset(
                                              "images/plus.svg",
                                              height: responsive(12, context),
                                              width: responsive(12, context),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10,
                  right: responsive(20, context),
                  left: responsive(20, context),
                  bottom: responsive(25, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFound = false;
                        searchList.clear();
                        selectedStartDate = null;
                        selectedEndDate = null;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: responsive(25, context),
                            vertical: responsive(04, context)),
                        decoration: BoxDecoration(
                            color: AppColors.GlobelColor.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(responsive(5, context))),
                        height: responsive(40, context),
                        alignment: Alignment.center,
                        child: customFonts(
                            text: "Clear", size: 15, context: context)),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      var packageLists = package.package?.results;

                      // var newNights;
                      //
                      // int daysBetween(DateTime from, DateTime to) {
                      //   from = DateTime(from.year, from.month, from.day);
                      //   to = DateTime(to.year, to.month, to.day);
                      //   return (to.difference(from).inHours / 24).round();
                      // }

                        for (var m = 0; m <= packageLists!.length - 1; m++) {
                          var pkg = package.package?.results?[m];
                          var pStartDate =
                          formatDateString(packageLists[m].startDate);
                          var pEndate = formatDateString(packageLists[m].endDate);
                          if (selectedStartDate == pStartDate ||
                              selectedEndDate == pEndate) {
                            setState(() {
                              isFound = true;
                            });
                            searchList.add(packagesContainer(
                                id: pkg?.huzToken,
                                isFav: true,
                                onTapFav: () {},
                                inlcudes: package.allincludes[m],
                                image: "",
                                packageName: pkg?.packageName,
                                startDate: pkg?.startDate,
                                endDate: pkg?.endDate,
                                amount: pkg?.packageCost));
                          }

                          print("Start date from pakcgae : ${pStartDate}");
                        }


                      //
                      // setState(() {
                      //   newNights = daysBetween(
                      //       format.parse(
                      //           startdate ?? booking.initialstartdate),
                      //       format.parse(
                      //           enddate ?? booking.initialenddate));
                      //   booking.combineNights = newNights;
                      //   booking.startDate = startdate;
                      //   booking.endDate = enddate;
                      //   booking.isOpened = false;
                      //   booking.adults = adultsCount;
                      //   booking.childrens = childsCount;
                      //   booking.price = price;
                      //   booking.notifyListeners();
                      //
                      // });

                      // if(widget.isFromEdit) {
                      //   booking.Updatebooking(sessiontoken: user.isUser?.sessionToken,partnertoken: booking.booking?.partnerSessionToken,huztoken: booking.booking?.huzToken).then((value){
                      //     endLoading();
                      //     if(value ==true){
                      //       showSnackbar(widget.previousclasscontext,'Successfully Updated !');
                      //     }else{
                      //       showSnackbar(widget.previousclasscontext,'Error Updating booking');
                      //
                      //     }
                      //
                      //
                      //   });
                      // }
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: responsive(25, context),
                            vertical: responsive(04, context)),
                        decoration: BoxDecoration(
                            color: AppColors.GlobelColor,
                            borderRadius:
                                BorderRadius.circular(responsive(5, context))),
                        height: responsive(40, context),
                        alignment: Alignment.center,
                        child: customFonts(
                            text: "Save",
                            size: 15,
                            color: Colors.white,
                            context: context)),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Container packagesContainer({
    required var id,
    required var isFav,
    required var onTapFav,
    required var image,
    required var packageName,
    required var startDate,
    required var endDate,
    var includeList,
    var excludeList,
    required var amount,
    var rating,
    var inlcudes,
  }) {
    print('images are ${image}');
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
            children: [
              Container(
                height: responsive(118, context),
                width: responsive(139, context),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(responsive(10, context)),
                    topRight: Radius.circular(responsive(10, context)),
                    bottomRight: Radius.circular(responsive(10, context)),
                    bottomLeft: Radius.circular(responsive(10, context)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "${image}",
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
                ),
              ),
              Positioned(
                top: responsive(0, context),
                right: responsive(0, context),
                child: GestureDetector(
                  onTap: onTapFav,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: responsive(08, context),
                        right: responsive(08, context),
                        left: responsive(50, context),
                        bottom: responsive(50, context)),
                    child: Container(
                      alignment: Alignment.center,
                      height: responsive(20, context),
                      width: responsive(20, context),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: isFav
                          ? SvgPicture.asset(
                              "images/heart_icon_fill.svg",
                              height: responsive(13, context),
                            )
                          : SvgPicture.asset(
                              "images/Shape.svg",
                              height: responsive(13, context),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: responsive(10, context),
                  vertical: responsive(5, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customFonts(
                          text: packageName,
                          size: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlackColor.withOpacity(0.90),
                          context: context),
                      customFonts(
                          text:
                              "${formatDateString(startDate)} to ${formatDateString(endDate)}",
                          size: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlackColor,
                          context: context),
                    ],
                  ),
                  Wrap(
                    spacing: 0.0,
                    children: List.generate(
                      inlcudes.length,
                      (index) => index == 0
                          ? customFonts(
                              text: "Includes: ",
                              size: 12,
                              color: AppColors.primaryBlackColor,
                              fontWeight: FontWeight.bold,
                              context: context)
                          : customFonts(
                              text: "${inlcudes[index]}",
                              size: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryBlackColor,
                              context: context),
                    ),
                  ),
                  // Wrap(
                  //   spacing: 10,
                  //   children: List.generate(
                  //     7,
                  //         (index) =>  customFonts(
                  //         text: "Dinner",
                  //         size: 10,
                  //         fontWeight: FontWeight.w500,
                  //         color: AppColors.primaryBlackColor,
                  //         context: context),
                  //   ),
                  // ),

                  SizedBox(
                    width: responsive(300, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customFonts(
                            text: 'PKR $amount',
                            size: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF484848),
                            context: context),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "images/star.svg",
                            ),
                            horizontalSpace(5, context),
                            customFonts(
                                text: "$rating",
                                size: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryBlackColor
                                    .withOpacity(0.9),
                                context: context),
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
  }
}
