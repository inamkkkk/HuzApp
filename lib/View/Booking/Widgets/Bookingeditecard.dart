import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huz/View/Details/View/detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Controller/pakagecontroller.dart';
import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';
import '../../../Widgets/date_picker/date_picker.dart';
import '../Controller/BookingediteController/BookingEditeController.dart';

class bookingdetail extends StatefulWidget {

  var startdate,
      isFlex,
      packageName,
      combineNights,
      enddate,
      adults,
      child,
      infent,
      descriptions;

  bookingdetail(
      {super.key,
        required this.isFlex,
        required this.startdate,
        this.enddate,
        this.combineNights,
        this.packageName,
        this.adults,
        this.child,
        this.infent,
        this.descriptions,

      });

  @override
  State<bookingdetail> createState() => _bookingdetailState();
}

class _bookingdetailState extends State<bookingdetail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Bookingedite>(
      builder: (BuildContext context, bookingDetail, Widget? child) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            // borderRadius : BorderRadius.all(
            //   Radius.circular(responsive(05, context)),
            // ),
            color: Colors.white,
            border: Border.all(
              color: Color(0xFFDCDCDC),
              width: responsive(2, context),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: responsive(20, context),
                vertical: responsive(10, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    customFonts(
                        text: "Your Booking details",
                        size: 16,
                        fontWeight: FontWeight.bold,
                        context: context),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          bookingDetail.isOpened = true;
                          bookingDetail.notifyListeners();
                          showBottomSheet(
                              context: context,
                              enableDrag: false,
                              builder: (context) {
                                return bottomSheet(
                                    startDate: widget.startdate,
                                    endDate: widget.enddate,
                                    adults: widget.adults,
                                    childs: widget.child,
                                    infent: widget.infent,
                                    contexts: context,
                                    isFlexible: widget.isFlex);
                              });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: responsive(21, context),
                          width: responsive(46, context),
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive(6, context)),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(responsive(6, context)),
                              border: Border.all(
                                color: Color(0xFFBBBBBB),
                              )),
                          child: customFonts(
                              text: "Edit",
                              size: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.GlobelColor,
                              context: context),
                        )),
                  ],
                ),
                SizedBox(
                  height: responsive(20, context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customFonts(
                            text: "Start Date",
                            size: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlackColor.withOpacity(0.8),
                            context: context),
                        SizedBox(
                          height: responsive(03, context),
                        ),
                        customFonts(
                            text: widget.startdate,
                            size: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryBlackColor.withOpacity(0.9),
                            context: context),
                      ],
                    ),
                    horizontalSpace(40, context),
                    Container(
                      height: responsive(31, context),
                      width: responsive(2, context),
                      color: Color(0xFFB2ABAB),
                    ),
                    horizontalSpace(40, context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customFonts(
                            text: "End Date",
                            size: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlackColor.withOpacity(0.8),
                            context: context),
                        SizedBox(
                          height: responsive(03, context),
                        ),
                        customFonts(
                            text: widget.enddate,
                            size: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryBlackColor.withOpacity(0.9),
                            context: context),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: responsive(20, context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customFonts(
                        text: "Total length of stay",
                        size: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlackColor.withOpacity(0.8),
                        context: context),
                    SizedBox(
                      height: responsive(03, context),
                    ),
                    customFonts(
                        text: "${widget.combineNights} nights",
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryBlackColor.withOpacity(0.9),
                        context: context),
                  ],
                ),
                verticalSpace(20, context),
                Container(
                  height: responsive(1, context),
                  color: Color(0xFFB2ABAB),
                ),
                SizedBox(
                  height: responsive(20, context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customFonts(
                            text: "You Selected",
                            size: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlackColor.withOpacity(0.8),
                            context: context),
                        SizedBox(
                          height: responsive(05, context),
                        ),
                        Row(
                          children: [
                            customFonts(
                                text: "${widget.packageName} - ",
                                size: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryBlackColor.withOpacity(0.9),
                                context: context),
                            customFonts(
                                text:
                                '${widget.combineNights} nights with ${widget.child + widget.adults + widget.infent} members',
                                size: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryBlackColor.withOpacity(0.9),
                                context: context),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var initialdate = DateTime.now();
  var startdate, enddate;
  int adultCount = 1;
  int childCount = 0;
  int infentCount = 0;



  Widget bottomSheet(
      {
        required bool isFlexible,
        required String startDate,
        required String endDate,
        required int adults,
        required int childs,
        required int infent,
        required BuildContext contexts}) {
    return Container(
      height: MediaQuery.of(context).size.height / responsive(isFlexible ? 2.8 : 3.3, context),
      width: MediaQuery.of(contexts).size.width,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 20,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(responsive(20, contexts)))),
      child: Consumer2<Bookingedite, pakagecontrollers>(
          builder: (context, booking, pkg, child) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: responsive(10, context),
                      vertical: responsive(03, context)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            booking.isOpened = false;
                            booking.notifyListeners();
                            Navigator.pop(contexts);
                          },
                          icon: Icon(Icons.close)),
                      SizedBox(
                        width: responsive(10, contexts),
                      ),
                      customFonts(
                          text: "Edit your trip",
                          size: 18,
                          fontWeight: FontWeight.w600,
                          context: contexts),
                    ],
                  ),
                ),
                Divider(
                  height: responsive(2, contexts),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: responsive(25, contexts),
                        vertical: responsive(widget.isFlex ? 30 : 10, contexts)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // GestureDetector(
                        //   onTap: (){
                        //     print("pressed");
                        //     showDatePicker(context: context, firstDate: DateTime(2024), lastDate: DateTime(2025));
                        //
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       color: AppColors.grayboxcolor.withOpacity(0.2),
                        //       borderRadius: BorderRadius.circular(responsive(5, context))
                        //     ),
                        //     height: responsive(60, context),
                        //
                        //       alignment: Alignment.center,
                        //       child: customFonts(text: "$startdate   to   $enddate", size: 18, context: context)),
                        // ),



                        isFlexible ? InkWell(
                          onTap: () {
                            print("Date clicked");

                            showDialog(
                              barrierColor: Colors.transparent,
                                context: context, builder: (_){
                              return  Padding(
                                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.45),
                                child: CustomDatePicker(
                                  title: 'Select Date',
                                  submite: (value){
                                    Navigator.pop(context);
                                  },
                                  endDate: DateFormat('dd MMM yyyy').parse(endDate),
                                  mindate:DateFormat('dd MMM yyyy').parse(startDate),
                                  initialdate:
                                  DateFormat('dd MMM yyyy').parse(startDate),
                                  onselectchanged: (date) {
                                    String formattedDate = DateFormat('dd MMM yyyy')
                                        .format(date.value.startDate!);
                                    print(formattedDate);
                                    String edate= DateFormat('dd MMM yyyy').format(date.value.endDate);
                                    print(formattedDate);
                                    booking.endDate = edate;
                                    booking.startDate = formattedDate;
                                    booking.isedite = true;
                                    booking.notifyListeners();

                                    setState(() {
                                      startdate = formattedDate;
                                      enddate = edate;
                                    });
                                  },
                                ),
                              );
                            });


                            // showBottomSheet(
                            //     context: context,
                            //     builder: (context) {
                            //       return CustomDatePicker(
                            //         title: 'Select Date',
                            //         submite: (value){
                            //           Navigator.pop(context);
                            //         },
                            //         endDate: DateFormat('dd MMM yyyy').parse(endDate),
                            //         mindate:DateFormat('dd MMM yyyy').parse(startDate),
                            //         initialdate:
                            //         DateFormat('dd MMM yyyy').parse(startDate),
                            //         onselectchanged: (date) {
                            //           String formattedDate = DateFormat('dd MMM yyyy')
                            //               .format(date.value.startDate!);
                            //           print(formattedDate);
                            //           String edate= DateFormat('dd MMM yyyy').format(date.value.endDate);
                            //           print(formattedDate);
                            //           booking.endDate = edate;
                            //           booking.startDate = formattedDate;
                            //           booking.isedite = true;
                            //           booking.notifyListeners();
                            //
                            //           setState(() {
                            //             startdate = formattedDate;
                            //             enddate = edate;
                            //           });
                            //         },
                            //       );
                            //     }
                            // );
                            // Get.to(CustomDatePicker(
                            //   title: 'Start Date',
                            //   submite: (value) {
                            //     String formattedDate =
                            //     DateFormat('dd MMM yyyy').format(value!);
                            //     print(formattedDate);
                            //     booking.startDate = formattedDate;
                            //     booking.isedite = true;
                            //     booking.notifyListeners();
                            //
                            //     setState(() {
                            //       startdate = formattedDate;
                            //     });
                            //
                            //     Navigator.pop(context);
                            //   },
                            //   // mindate:DateFormat('dd MMM yyyy').parse(startDate),
                            //   initialdate:
                            //   DateFormat('dd MMM yyyy').parse(startDate),
                            //   onselectchanged: (date) {
                            //     String formattedDate = DateFormat('dd MMM yyyy')
                            //         .format(date.value!);
                            //     print(formattedDate);
                            //     booking.startDate = formattedDate;
                            //     booking.isedite = true;
                            //     booking.notifyListeners();
                            //
                            //     setState(() {
                            //       startdate = formattedDate;
                            //     });
                            //   },
                            // ));

                            // showDatePicker(
                            //         context: context,
                            //         firstDate: DateTime.now(),
                            //         lastDate: DateTime(2050))
                            //     .then((value) {
                            //   String formattedDate =
                            //       DateFormat('dd MMM yyyy').format(value!);
                            //   print(formattedDate);
                            //
                            //   booking.startDate = formattedDate;
                            //   booking.notifyListeners();
                            //   setState(() {
                            //     startdate = formattedDate;
                            //     initialdate = value;
                            //   });
                            // });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customFonts(
                                        text: "Start Date",
                                        size: 15,
                                        fontWeight: FontWeight.bold,
                                        context: context),
                                    customFonts(
                                        text: startdate ?? startDate,
                                        size: 15,
                                        context: context),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  customFonts(
                                      text: "End Date",
                                      size: 15,
                                      fontWeight: FontWeight.bold,
                                      context: context),
                                  customFonts(
                                      text: enddate ?? endDate,
                                      size: 15,
                                      context: context),
                                ],
                              ),
                            ],
                          ),
                        ) : SizedBox(),
                        SizedBox(height: responsive(20, context),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customFonts(
                                    text: "Adults",
                                    size: 15,
                                    fontWeight: FontWeight.bold,
                                    context: context),
                                customFonts(
                                    text: "Age 13+", size: 13, context: context),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (adultCount > 1) {
                                      adultCount--;
                                      booking.price =
                                          booking.price - booking.subtractprice;
                                    }
                                    booking.adults = adultCount;
                                    booking.isedite = true;
                                    booking.notifyListeners();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: responsive(42, context),
                                    width: responsive(42, context),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black12)),
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
                                    text: adultCount.toString(),
                                    size: 15,
                                    context: context),
                                SizedBox(
                                  width: responsive(15, context),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (adultCount >= 1) {
                                        adultCount++;
                                        booking.price =
                                            booking.price + booking.subtractprice;
                                      }
                                    });
                                    booking.adults = adultCount;
                                    booking.isedite = true;
                                    booking.notifyListeners();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: responsive(42, context),
                                    width: responsive(42, context),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black12)),
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
                        SizedBox(height: responsive(25, context),),

                        // SizedBox(height: responsive(20, context),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customFonts(
                                    text: "Children",
                                    size: 15,
                                    fontWeight: FontWeight.bold,
                                    context: context),
                                customFonts(
                                    text: "Age 2-12+", size: 13, context: context),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (childCount > 0) {
                                        childCount--;
                                        booking.price =
                                            booking.price - booking.subtractprice;
                                      }
                                    });
                                    booking.childrens = childCount;
                                    booking.isedite = true;
                                    booking.notifyListeners();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: responsive(42, context),
                                    width: responsive(42, context),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black12)),
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
                                    text: childCount.toString(),
                                    size: 15,
                                    context: context),
                                SizedBox(
                                  width: responsive(15, context),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (childCount >= 0) {
                                        childCount++;
                                        booking.price =
                                            booking.price + booking.subtractprice;
                                      }
                                    });
                                    booking.childrens = childCount;
                                    booking.isedite = true;
                                    booking.notifyListeners();
                                  },

                                  child: Container(
                                    alignment: Alignment.center,
                                    height: responsive(42, context),
                                    width: responsive(42, context),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black12)),
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
                        // SizedBox(height: responsive(20, context),),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: responsive(2, context),
                ),
                SizedBox(
                  height: responsive(05, context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: responsive(20, context),
                      left: responsive(05, context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: responsive(20, context)),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                BorderRadius.circular(responsive(5, context))),
                            height: responsive(60, context),
                            alignment: Alignment.center,
                            child: customFonts(
                                text: "Clear",
                                size: 15,
                                isUnderLine: true,
                                context: context)),
                      ),
                      GestureDetector(
                        onTap: () {
                          var newNights;

                          int daysBetween(DateTime from, DateTime to) {
                            from = DateTime(from.year, from.month, from.day);
                            to = DateTime(to.year, to.month, to.day);
                            return (to.difference(from).inHours / 24).round();
                          }

                          DateFormat format = DateFormat("dd MMM yyyy");

                          setState(() {
                            newNights = daysBetween(format.parse(booking.startDate??booking.initialstartdate),
                                format.parse(booking.endDate??booking.initialenddate));
                            booking.combineNights = newNights;
                            booking.isOpened = false;
                            booking.notifyListeners();
                            Get.back();
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: responsive(25, context)),
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

  Row addGuests(
      {bool isAdult = false,
        bool isChild = false,
        bool isInfent = false,
        required var count,
        required Function minus,
        required Function add,
        required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customFonts(
                text: isAdult
                    ? "Adults"
                    : isChild
                    ? "Children"
                    : "Infent",
                size: 15,
                fontWeight: FontWeight.bold,
                context: context),
            customFonts(
                text: isAdult
                    ? "Age 13+"
                    : isChild
                    ? "Age 2-12+"
                    : "Age 0-1",
                size: 13,
                context: context),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: minus(),
              child: Container(
                alignment: Alignment.center,
                height: responsive(42, context),
                width: responsive(42, context),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black12)),
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
            customFonts(text: count.toString(), size: 15, context: context),
            SizedBox(
              width: responsive(15, context),
            ),
            InkWell(
              onTap: add(),
              child: Container(
                alignment: Alignment.center,
                height: responsive(42, context),
                width: responsive(42, context),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black12)),
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
    );
  }
}

// --------------  booking price summary ------------------//
//todo: booking price summary is here !!!
class PriceSummery extends StatelessWidget {
  var price, meccanights, enddate, descriptions;

  PriceSummery(
      {super.key,
        required this.price,
        this.enddate,
        this.meccanights,
        this.descriptions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsive(74, context),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Color(0xFFE6F4F0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: responsive(20, context),
            vertical: responsive(10, context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customFonts(
                text: "Price",
                size: 14,
                color: AppColors.primaryBlackColor.withOpacity(0.9),
                fontWeight: FontWeight.w500,
                context: context),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                customFonts(
                    text: "PKR $price",
                    size: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.GlobelColor,
                    context: context),
                customFonts(
                    text: '+PKR $price taxes and charges',
                    size: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlackColor.withOpacity(0.9),
                    context: context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ------------ Special request -------------------//
class RoundedBorderTextField extends StatelessWidget {
  var hintText;
  var borderColor;
  var focusedBorderColor;
  var borderRadius;
  var borderWidth;
  var controller;

  RoundedBorderTextField({
    this.controller,
    this.hintText,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: MediaQuery.sizeOf(context).width,
      height: responsive(100, context),
      decoration: BoxDecoration(
        // borderRadius : BorderRadius.all(
        //   Radius.circular(responsive(05, context)),
        // ),
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFDCDCDC),
          width: responsive(2, context),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: responsive(10, context), vertical: 5),
        child: TextField(
          maxLines: 20,
          textAlign: TextAlign.start,
          controller: controller,
          style: TextStyle(
            fontSize: responsive(14, context),
            color: AppColors.primaryBlackColor.withOpacity(0.9),
            fontFamily: GoogleFonts.cairo(
                textStyle: TextStyle(
                  // fontWeight: FontWeight.bold
                ))
                .fontFamily,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            hintText: hintText,
            border: InputBorder.none,
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(responsive(05, context))),
            //   borderSide: BorderSide(color: AppColors.grayboxcolor, width: 1),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(responsive(05, context))),
            //   borderSide: BorderSide(color: AppColors.grayboxcolor, width: 1),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(responsive(05, context))),
            //   borderSide: BorderSide(color: AppColors.grayboxcolor, width: 1),
            // ),
          ),
        ),
      ),
    );
  }
}