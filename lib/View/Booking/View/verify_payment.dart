import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:huz/View/Booking/View/payment_verification.dart';
import 'package:huz/View/Details/View/detail_screen.dart';
import 'package:huz/View/Home/View/home_screen.dart';
import 'package:huz/View/auth/view/user_location_screen/EditeLocation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Controller/pakagecontroller.dart';
import '../../../Loading/loading.dart';
import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/AppFonts.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';
import '../../../Widgets/custom_app_bar.dart';
import '../../../Widgets/date_picker/date_picker.dart';
import '../../../Widgets/error_message_popup/error_message.dart';
import '../../../Widgets/snackbar.dart';
import '../../auth/controller/is_user_exist_controller.dart';
import '../../auth/view/sign_up_with_mobile_number/signup_with_mobile_num.dart';
import '../Controller/BookingediteController/BookingEditeController.dart';
import '../Widgets/Bookingeditecard.dart';

class VerifyPaymentScreen extends StatefulWidget {
  const VerifyPaymentScreen({super.key});

  @override
  State<VerifyPaymentScreen> createState() => _VerifyPaymentScreenState();
}

class _VerifyPaymentScreenState extends State<VerifyPaymentScreen> {

  var initialdate = DateTime.now();
  var startdate, enddate;
  int adultCount = 1;
  int childCount = 0;
  int infentCount = 0;

  Widget bottomBar() {
    return Container(
        height: responsive(52, context),

        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(responsive(5, context)),
          border: const Border(
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
          child: Heading3(
            text: "Verify Transaction",
            context: context,
            center: true,
            color: Colors.white,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return

      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: CustomAppBar(
            title: "Verify Transaction",
            onPress: (){

            },

          ),
        ),
          body: Consumer3<IsUserExitsController, Bookingedite, pakagecontrollers>(
              builder: (context, user,  booking, pkg, child) {

                return  SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      color: const Color(0xFFF2F2F2),
                      height: responsive(62, context),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: responsive(20, context),
                          vertical: responsive(10, context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          SizedBox(
                            child: ErrorMesssage(isVisible: booking.edite, message: booking.editemessage,onTap: () {
                              booking.edite= false;
                              booking.editemessage = "error";
                              booking.notifyListeners();
                            }
                            ),
                          ),
                          verticalSpace(responsive(25, context), context),

                          //Thanks giving card
                          thanksGivingCard(name: "${user.isUser?.name}", context: context),

                          verticalSpace(10, context),

                          // status card
                          statusCard(
                              status: "Reserved",
                              bookingNumber: booking.booking?.bookingNumber,
                              context: context),

                          verticalSpace(10, context),

                          // Booking detail container
                          bookingCard(
                            isFlex: pkg.details?.isPackageOpenForOtherDate,
                            contexts: context,
                            startdate: booking.startDate??formatDateString(booking.booking?.startDate),
                            enddate: booking.startDate??formatDateString(booking.booking?.endDate),
                            adults:booking.adults!=1?booking.adults: booking.booking?.adults,
                            childs:booking.childrens!=0?booking.childrens:booking.booking?.child,
                            infent: 0,
                            madinanights: booking.booking?.madinahNights,
                            meccanights: booking.booking?.meccaNights,
                            packageName: booking.booking?.packageName,
                            description: ""
                          ),

                          verticalSpace(10, context),

                          // Price summery container
                          PriceSummery(
                            price: booking.price ?? booking.booking?.totalPrice,
                          ),

                          verticalSpace(10, context),

                          customFonts(
                              text:
                                  "Here are the bank account details where you can make the payment:",
                              size: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryBlackColor.withOpacity(0.8),
                              context: context),

                          verticalSpace(10, context),

                          // Bank detail container
                          bankDetailContainer(size, context),
                          SizedBox(
                            height: responsive(10, context),
                          ),
                          customFonts(
                              text:
                                  'Once you have sent the money, please click the button below for verification and enter your transfer ID or receipt.',
                              size: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryBlackColor.withOpacity(0.8),
                              context: context),

                          SizedBox(
                            height: responsive(20, context),
                          ),

                          // Button

                          GestureDetector(
                              onTap: () {
                                Get.to(() =>  PaymentVerification());
                              },
                              child: bottomBar()),
                          // transfer ID Textfield
                          // SizedBox(
                          //   height: responsive(10, context),
                          // ),
                          //
                          // // or
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Expanded(
                          //         child: Divider(
                          //           thickness: 0.5,
                          //           color: AppColors.grayboxcolor,
                          //         )),
                          //     Padding(
                          //       padding: EdgeInsets.symmetric(
                          //           horizontal: responsive(20, context)),
                          //       child: headlineSub(text: "or", context: context),
                          //     ),
                          //     const Expanded(
                          //         child: Divider(
                          //           thickness: 0.5,
                          //           color: AppColors.grayboxcolor,
                          //         )),
                          //   ],
                          // ),
                          //
                          // SizedBox(
                          //   height: responsive(10, context),
                          // ),
                          // DottedBorder(
                          //     strokeWidth: 0.5,
                          //     color: AppColors.grayboxcolor,
                          //     dashPattern: [
                          //       responsive(10, context),
                          //     ],
                          //     child: SizedBox(
                          //       width: size.width,
                          //       height: responsive(180, context),
                          //       child: _image == null
                          //           ? Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           InkWell(
                          //             onTap: pickImage,
                          //             child: Container(
                          //               padding: EdgeInsets.all(
                          //                   responsive(10, context)),
                          //               height: responsive(48, context),
                          //               width: responsive(48, context),
                          //               decoration: BoxDecoration(
                          //                   color: const Color(0xFF4B465C)
                          //                       .withOpacity(0.08),
                          //                   borderRadius: BorderRadius.circular(
                          //                       responsive(6, context))),
                          //               child: SvgPicture.asset(
                          //                 height: responsive(28, context),
                          //                 width: responsive(28, context),
                          //                 'images/upload.svg',
                          //                 semanticsLabel: 'vector',
                          //                 // fit: BoxFit.fitHeight,
                          //               ),
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             height: responsive(10, context),
                          //           ),
                          //           headlineSub(
                          //             text:
                          //             "Upload snapshot of the payment slip",
                          //             context: context,
                          //           ),
                          //         ],
                          //       )
                          //           : Center(
                          //           child: Image.file(
                          //             _image!,
                          //             fit: BoxFit.contain,
                          //           )),
                          //     ))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        );

  }

  Container bankDetailContainer(Size size, BuildContext context) {
    return Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(responsive(10, context)),
          ),
          border: Border.all(
            color: AppColors.grayboxcolor,
            width: responsive(1, context),
          ),
        ),
        padding: EdgeInsets.all(responsive(20, context)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Image.asset(
                    "images/bop.png",
                    height: responsive(41, context),
                    width: responsive(69, context),
                  ),
                  SizedBox(
                    width: responsive(15, context),
                  ),
                  customFonts(
                      text:
                          "Bank name: The Bank of Punjab\nAccount Title: HUZ Solutions (Pvt) Limited.\nAccount #: 092349328Z234\nIBFA: 03409349034903439490",
                      size: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBlackColor.withOpacity(0.9),
                      context: context),
                ],
              ),
            ),
            SvgPicture.asset(
              width: responsive(18, context),
              height: responsive(20, context),
              'images/copy_icon.svg',
              semanticsLabel: 'vector',
              // fit: BoxFit.fitHeight,
            ),
          ],
        ));
  }

  Widget thanksGivingCard({required var name, required BuildContext context}) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: responsive(72, context),
      padding: EdgeInsets.only(left: responsive(20, context)),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        // borderRadius : BorderRadius.all(
        //   Radius.circular(responsive(05, context)),
        // ),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFDCDCDC),
          width: responsive(2, context),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customFonts(
              text: "Thank you $name !.",
              size: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.GlobelColor,
              context: context),
          customFonts(
              text: "Your booking has been Reserved.",
              size: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryBlackColor.withOpacity(0.9),
              context: context)
        ],
      ),
    );
  }

  Widget bookingCard(
      {required var startdate,
      required var isFlex,
      required var packageName,
      required var madinanights,
      required var meccanights,
      required var enddate,
      required var adults,
      required int childs,
      required var infent,
      required var description,
      required var contexts}
      ) {
    return Consumer3<IsUserExitsController, Bookingedite, pakagecontrollers>(
        builder: (context, user,  booking, pkg, child) {

          return  Container(
          width: MediaQuery.sizeOf(contexts).width,
          decoration: BoxDecoration(
            // borderRadius : BorderRadius.all(
            //   Radius.circular(responsive(05, context)),
            // ),
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFDCDCDC),
              width: responsive(2, context),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: responsive(20, context),
                vertical: responsive(15, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    customFonts(
                        text: "You have reserved the ",
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryBlackColor.withOpacity(0.9),
                        context: context),
                    customFonts(
                        text: "$packageName",
                        size: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.GlobelColor,
                        context: context),
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
                            text: "$startdate",
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
                      color: const Color(0xFFB2ABAB),
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
                            text: "$enddate",
                            size: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryBlackColor.withOpacity(0.9),
                            context: context),
                      ],
                    ),
                  ],
                ),
                verticalSpace(20, context),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customFonts(
                        text:
                            '${booking.combineNights??meccanights + meccanights } nights with ${childs + adults + infent} members',
                        size: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlackColor.withOpacity(0.9),
                        context: context),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          booking.initialstartdate = startdate;
                          booking.initialenddate = enddate;
                          booking.adults = adults;
                          booking.childrens = childs;
                          booking.startDate = startdate;
                          booking.endDate = enddate;
                          showDialog(
                          context: context,
                       builder: (context) {
                           return  AlertDialog
                          (
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0))),
                            actions: [
                              Padding(
                                padding:
                                const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your booking number :',
                                      style: TextStyle(
                                        fontFamily: AppFonts
                                            .poppinsRegular,
                                        fontSize: responsive(
                                            14, context),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      '${booking.booking?.bookingNumber}',
                                      style: TextStyle(
                                          fontFamily: AppFonts
                                              .poppinsSemiBold,
                                          fontSize: responsive(
                                              14, context),
                                          color: AppColors
                                              .GlobelColor),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Are you sure? You want to cancel your booking',
                                      style: TextStyle(
                                        fontFamily: AppFonts
                                            .poppinsRegular,
                                        fontSize: responsive(
                                            13, context),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        CustomTextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context);
                                          },
                                          text: 'Cancel',
                                        ),
                                        CustomTextButton(
                                            text: 'OK',
                                            onPressed: () {
                                              booking.deleteBooking(user.isUser?.sessionToken,booking?.booking?.bookingNumber).then((value)
                                              {
                                                if(value == true){
                                                  endLoading();
                                                  showSnackbar(context,'Your booking has been Deleted');
                                                  booking.Blist=[];
                                                  booking.bListsapi=false;
                                                  booking.notifyListeners();
                                                  Get.offAll(HomeScreen(selectedIndex: 2,))
                                                  // Navigator.pop(context);

;                                                } else {
                                                  endLoading();
                                                  showSnackbar(context,'error occured in deleting booking');
                                                  Get.back();
                                                }

                                              });


                                            }


                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: responsive(21, context),
                          width: responsive(56, context),
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive(6, context)),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(responsive(6, context)),
                              border: Border.all(
                                color: const Color(0xFFBBBBBB),
                              )),
                          child: customFonts(
                              text: "Cancel",
                              size: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFF0606),
                              context: context),
                        )),
                    horizontalSpace(5, context),
                    InkWell(
                        onTap: () {
                          showBottomSheet(
                              context: contexts,
                              enableDrag: false,
                              builder: (context) {
                                booking.initialstartdate = startdate;
                                booking.initialenddate = enddate;
                                booking.adults = adults;
                                booking.childrens = childs;
                                booking.startDate = startdate;
                                booking.endDate = enddate;
                                booking.specialreq = booking.booking?.specialRequest;
                                return bottomSheet(
                                  // isFlexible: isFlex,
                                  isFlexible: true,
                                    startDate: booking.startDate??booking.initialstartdate,
                                    endDate:  booking.endDate??booking.initialenddate,
                                    adults: booking.adults,
                                    childs: booking.childrens,
                                    infent: infent,
                                    context: contexts);
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
                                color: const Color(0xFFBBBBBB),
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
              ],
            ),
          ),
        );
      }
    );
  }

  Widget bottomSheet(
      {required String startDate,
        required bool isFlexible,
      required String endDate,
      required int adults,
      required int childs,
      required int infent,
      required BuildContext context}) {
    return Container(
      height: MediaQuery.sizeOf(context).height / responsive(isFlexible ? 3 : 3.2, context),
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
      child: Consumer3<Bookingedite, pakagecontrollers,IsUserExitsController>(
          builder: (context, booking, pkg,user, child) {
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
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)),
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
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: responsive(25, context),
                    vertical: responsive(20, context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                    isFlexible ?   InkWell(
                      onTap: () {
                        print("Date clicked");
                        showBottomSheet(
                            context: context,
                            builder: (context) {
                              return CustomDatePicker(
                                title: 'Select Date',
                                submite: (value) {
                                  print(value.startDate);
                                  String formattedDate =
                                  DateFormat('dd MMM yyyy').format(value.startDate);
                                  print(formattedDate);
                                  String edate= DateFormat('dd MMM yyyy').format(value.endDate);
                                  print(formattedDate);
                                  booking.endDate = edate;
                                  booking.startDate = formattedDate;
                                  booking.isedite = true;
                                  booking.notifyListeners();

                                  setState(() {
                                    startdate = formattedDate;
                                    enddate = edate;
                                  });

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
                              );
                            }
                        );
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
                          Column(
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
                    // SizedBox(height: responsive(10, context),),

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
                                if (adults > 1) {
                                  adults--;
                                  booking.price = booking.price - booking.subtractprice;
                                }
                                booking.adults = adults;

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
                                text: adults.toString(),
                                size: 15,
                                context: context),
                            SizedBox(
                              width: responsive(15, context),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (adults != 0) {
                                    adults++;
                                    booking.price =
                                        booking.price + booking.subtractprice;
                                  }
                                });

                                booking.adults = adults;

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
                                  if (childs > 0) {
                                    childs--;
                                    booking.price =
                                        booking.price - booking.subtractprice;
                                  }
                                });
                                booking.childrens = childs;

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
                                text: childs.toString(),
                                size: 15,
                                context: context),
                            SizedBox(
                              width: responsive(15, context),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (childs >= 0) {
                                    childs++;
                                    booking.price =
                                        booking.price + booking.subtractprice;
                                  }
                                });
                                booking.childrens = childs;

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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         customFonts(
                    //             text: "Infent",
                    //             size: 15,
                    //             fontWeight: FontWeight.bold,
                    //             context: context),
                    //         customFonts(
                    //             text: "Age 0-1", size: 13, context: context),
                    //       ],
                    //     ),
                    //     Row(
                    //       children: [
                    //         InkWell(
                    //           onTap: () {
                    //             setState(() {
                    //               if (infentCount > 0) {
                    //                 infentCount--;
                    //               }
                    //             });
                    //             booking.infents = infentCount;
                    //             booking.notifyListeners();
                    //           },
                    //           child: Container(
                    //             alignment: Alignment.center,
                    //             height: responsive(42, context),
                    //             width: responsive(42, context),
                    //             decoration: BoxDecoration(
                    //                 shape: BoxShape.circle,
                    //                 border: Border.all(color: Colors.black12)),
                    //             child: SvgPicture.asset(
                    //               "images/minus.svg",
                    //               height: responsive(2, context),
                    //               width: responsive(2, context),
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           width: responsive(15, context),
                    //         ),
                    //         customFonts(
                    //             text: infentCount.toString(),
                    //             size: 15,
                    //             context: context),
                    //         SizedBox(
                    //           width: responsive(15, context),
                    //         ),
                    //         InkWell(
                    //           onTap: () {
                    //             setState(() {
                    //               if (infentCount >= 0) {
                    //                 infentCount++;
                    //               }
                    //             });
                    //             booking.infents = infentCount;
                    //             booking.notifyListeners();
                    //           },
                    //           child: Container(
                    //             alignment: Alignment.center,
                    //             height: responsive(42, context),
                    //             width: responsive(42, context),
                    //             decoration: BoxDecoration(
                    //                 shape: BoxShape.circle,
                    //                 border: Border.all(color: Colors.black12)),
                    //             child: SvgPicture.asset(
                    //               "images/plus.svg",
                    //               height: responsive(12, context),
                    //               width: responsive(12, context),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     )
                    //   ],
                    // ),
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
                    onTap: () {
                      booking.childrens = 0;
                      booking.adults = 1;

                      booking.initialenddate;
                      booking.startDate = formatDateString(booking.booking?.startDate);
                      booking.endDate = formatDateString(booking.booking?.endDate);
                      booking.notifyListeners();
                     adults = booking.booking?.adults;
                     booking.combineNights =null;
                       childs= booking.booking?.child;

                      // booking.d

                    },
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

                      });
                      booking.Updatebooking(sessiontoken: user.isUser?.sessionToken,partnertoken: booking.booking?.partnerSessionToken,huztoken: booking.booking?.huzToken).then((value){
                        if(value ==true){
                          endLoading();
                          showSnackbar(context,'Successfully Updated !');
                          Get.back();
                        }else{
                          endLoading();
                         showSnackbar(context,'Error Updating booking');
                          Get.back();
                        }
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











  Widget statusCard(
      {required var status,
      required var bookingNumber,
      required BuildContext context}) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: responsive(51, context),
      padding: EdgeInsets.symmetric(horizontal: responsive(20, context)),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: AppColors.GlobelColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customFonts(
                  text: "Status",
                  size: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  context: context),
              customFonts(
                  text: status,
                  size: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  context: context)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customFonts(
                  text: "Booking number",
                  size: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  context: context),
              customFonts(
                  text: "$bookingNumber",
                  size: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  context: context)
            ],
          ),
        ],
      ),
    );
  }

  // Future<void> pickImage() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }
}
