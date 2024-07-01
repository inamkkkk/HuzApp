
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:huz/View/Booking/Widgets/custom_bottom_sheet.dart';

import 'package:provider/provider.dart';


import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';

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

  bookingdetail({
    super.key,
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


int adultCount = 1;
int childCount = 0;

var startdate, enddate;

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
                                return CustomBottomSheet(
                                  previousclasscontext: context,
                                  isFromEdit: false,
                                  isFlexible: widget.isFlex,
                                  startDate: widget.startdate,
                                  endDate: widget.enddate,
                                  adults: widget.adults,
                                  childs: widget.child,
                                );
                              });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: responsive(25, context),
                          width: responsive(50, context),
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
                              size: 14,
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
                            // customFonts(
                            //     text: "${widget.packageName} - ",
                            //     size: 14,
                            //     fontWeight: FontWeight.w500,
                            //     color: AppColors.primaryBlackColor
                            //         .withOpacity(0.9),
                            //     context: context),
                            customFonts(
                                text:
                                    '${widget.combineNights} nights with ${widget.child + widget.adults + widget.infent} members',
                                size: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryBlackColor
                                    .withOpacity(0.9),
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
                size: 16,
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




