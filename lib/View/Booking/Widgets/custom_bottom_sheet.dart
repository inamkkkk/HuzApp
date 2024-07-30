import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:huz/Model/Details.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Controller/pakagecontroller.dart';
import '../../../Loading/loading.dart';
import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';
import '../../../Widgets/date_picker/date_picker.dart';
import '../../../Widgets/snackbar.dart';
import '../../auth/controller/is_user_exist_controller.dart';
import '../Controller/BookingediteController/BookingEditeController.dart';
import 'Bookingeditecard.dart';

class CustomBottomSheet extends StatefulWidget {
  var adults, infants, childs, startDate, endDate, roomType, isFlexible;
  var isFromEdit, previousclasscontext;

  CustomBottomSheet(
      {super.key,
      required this.previousclasscontext,
      required this.isFromEdit,
      required this.isFlexible,
      required this.startDate,
      required this.endDate,
      required this.adults,
      required this.childs,
      required this.infants,
      required this.roomType});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}


class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  void initState() {
    Provider.of<Bookingedite>(context, listen: false).selectedRoom;
    super.initState();
  }
  num price = 0;
  int adultsCount = 1;
  int childsCount = 0;
  int infantCounts = 0;
  String singleRoom = "Single";
  String doubleRoom = "Double";
  String tripleRoom = "Triple";
  String quadRoom = "Quad";
  String sharingRoom = "Sharing";
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height /
          responsive(widget.isFlexible ? 2.5 : 2.5, context),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 20,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(responsive(20, context)))),
      child: Consumer3<Bookingedite, pakagecontrollers, IsUserExitsController>(
          builder: (contexts, booking, pkg, user, child) {
        if (price == 0) {
          price = booking.price;
        }
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
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                  SizedBox(
                    width: responsive(10, context),
                  ),
                  customFonts(
                      text: "Edit your trip",
                      size: 18,
                      fontWeight: FontWeight.w600,
                      context: context),
                ],
              ),
            ),
            Divider(
              height: responsive(2, context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: responsive(25, context),
                    vertical: responsive(widget.isFlexible ? 25 : 10, context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.isFlexible
                        ? InkWell(
                            onTap: () {
                              print("Date clicked");

                              showDialog(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (_) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.45),
                                      child: CustomDatePicker(
                                        title: 'Select Date',
                                        submite: (value) {
                                          Navigator.pop(context);
                                        },
                                        endDate: DateFormat('dd MMM yyyy')
                                            .parse(widget.endDate),
                                        mindate: DateFormat('dd MMM yyyy')
                                            .parse(widget.startDate),
                                        initialdate: DateFormat('dd MMM yyyy')
                                            .parse(widget.startDate),
                                        onselectchanged: (date) {
                                          String formattedDate =
                                              DateFormat('dd MMM yyyy').format(
                                                  date.value.startDate!);
                                          print(formattedDate);
                                          String edate =
                                              DateFormat('dd MMM yyyy')
                                                  .format(date.value.endDate);
                                          print(formattedDate);
                                          // startdate1 = edate;
                                          // enddate2 = formattedDate;
                                          booking.isedite = true;

                                          setState(() {
                                            startdate = formattedDate;
                                            enddate = edate;
                                          });
                                        },
                                      ),
                                    );
                                  });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customFonts(
                                          text: "Start Date",
                                          size: 16,
                                          fontWeight: FontWeight.bold,
                                          context: context),
                                      customFonts(
                                          text: startdate ?? widget.startDate,
                                          size: 14,
                                          context: context),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    customFonts(
                                        text: "End Date",
                                        size: 16,
                                        fontWeight: FontWeight.bold,
                                        context: context),
                                    customFonts(
                                        text: enddate ?? widget.endDate,
                                        size: 14,
                                        context: context),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
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
                                text: "Adults",
                                size: 16,
                                fontWeight: FontWeight.bold,
                                context: context),
                            customFonts(
                                text: "Age 13+", size: 14, context: context),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (adultsCount > 1) {
                                  setState(() {
                                    adultsCount--;
                                    price = price - booking.subtractprice;
                                  });
                                }
                                // booking.adults = adultCount;
                                booking.isedite = true;
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

                                    print("adult count: $adultCount");
                                    price = price + booking.subtractprice;
                                  });
                                }
                                // booking.adults = adultCount;
                                booking.isedite = true;
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
                    SizedBox(
                      height: responsive(25, context),
                    ),

                    // SizedBox(height: responsive(20, context),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customFonts(
                                text: "Children",
                                size: 16,
                                fontWeight: FontWeight.bold,
                                context: context),
                            customFonts(
                                text: "Age 2-12+", size: 14, context: context),
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
                                      price = price - booking.subtractprice;
                                    });
                                  }
                                });
                                // booking.childrens = childCount;
                                booking.isedite = true;
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
                                      price = price + booking.subtractprice;
                                    });
                                  }
                                });

                                booking.isedite = true;
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
                    SizedBox(
                      height: responsive(25, context),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customFonts(
                                text: "Infants",
                                size: 16,
                                fontWeight: FontWeight.bold,
                                context: context),
                            customFonts(
                                text: "Age 0-2", size: 14, context: context),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (infantCounts > 0) {
                                    setState(() {
                                      infantCounts--;
                                      price = price - booking.subtractprice;
                                    });
                                  }
                                });
                                // booking.childrens = childCount;
                                booking.isedite = true;
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
                                text: "$infantCounts",
                                size: 15,
                                context: context),
                            SizedBox(
                              width: responsive(15, context),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (infantCounts >= 0) {
                                    setState(() {
                                      infantCounts++;
                                      price = price + booking.subtractprice;
                                    });
                                  }
                                });

                                booking.isedite = true;
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
                    verticalSpace(25, context),
                    customFonts(
                        text: "Room Type",
                        size: 16,
                        fontWeight: FontWeight.bold,
                        context: context),
                    verticalSpace(10, context),
                    roomTypeRow(
                        roomTitle: singleRoom,
                        cost: pkg.details?.costForSingle,
                        value: widget.roomType,
                        booking: booking),

                    roomTypeRow(
                        roomTitle: doubleRoom,
                        cost: pkg.details?.costForDouble,
                        value: widget.roomType,
                        booking: booking),

                    roomTypeRow(
                        roomTitle: tripleRoom,
                        cost: pkg.details?.costForTriple,
                        value: widget.roomType,
                        booking: booking),

                    roomTypeRow(
                        roomTitle: quadRoom,
                        cost: pkg.details?.costForQuad,
                        value: widget.roomType,
                        booking: booking),

                    roomTypeRow(
                        roomTitle: sharingRoom,
                        cost: pkg.details?.costForSharing,
                        value: widget.roomType,
                        booking: booking),
                    verticalSpace(10, context),
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
                  top: 10,
                  right: responsive(20, context),
                  left: responsive(05, context),
                  bottom: responsive(15, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //       padding: EdgeInsets.symmetric(
                  //           horizontal: responsive(20, context)),
                  //       decoration: BoxDecoration(
                  //           color: Colors.transparent,
                  //           borderRadius:
                  //           BorderRadius.circular(responsive(5, context))),
                  //       height: responsive(60, context),
                  //       alignment: Alignment.center,
                  //       child: customFonts(
                  //           text: "Clear",
                  //           size: 15,
                  //           isUnderLine: true,
                  //           context: context)),
                  // ),
                  Spacer(),
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
                        newNights = daysBetween(
                            format.parse(startdate ?? booking.initialstartdate),
                            format.parse(enddate ?? booking.initialenddate));
                        booking.combineNights = newNights;
                        booking.startDate = startdate;
                        booking.endDate = enddate;
                        booking.isOpened = false;
                        booking.adults = adultsCount;
                        booking.childrens = childsCount;
                        booking.infents = infantCounts;
                        booking.price = price;
                        booking.finalRoom = booking.selectedRoom;
                        booking.notifyListeners();

                        print(booking.finalRoom);
                      });

                      if (widget.isFromEdit) {
                        booking.Updatebooking(
                                sessiontoken: user.isUser?.sessionToken,
                                partnertoken:
                                    booking.booking?.partnerSessionToken,
                                huztoken: booking.booking?.huzToken)
                            .then((value) {
                          endLoading();
                          if (value == true) {
                            showSnackbar(widget.previousclasscontext,
                                'Successfully Updated !');
                          } else {
                            showSnackbar(widget.previousclasscontext,
                                'Error Updating booking');
                          }
                        });
                      }

                      Get.back();
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
                            text: "Confirm",
                            size: 16,
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

  Widget roomTypeRow(
      {required roomTitle,
      required cost,
      required value,
      required Bookingedite booking}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio(
          activeColor: AppColors.GlobelColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: roomTitle,
          groupValue: booking.selectedRoom,
          onChanged: (dynamic value) {
           booking.roomChange(value);
           print(booking.selectedRoom);
           print(booking.finalRoom);
          },
        ),
        horizontalSpace(15, context),
        customFonts(text: "$roomTitle Room", size: 16, context: context),
        Spacer(),
        customFonts(text: " PKR $cost", size: 16, context: context),
      ],
    );
  }
}
