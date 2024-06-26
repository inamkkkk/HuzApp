import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:huz/View/Booking/View/payment_verification.dart';
import 'package:huz/View/auth/controller/is_user_exist_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Controller/pakagecontroller.dart';
import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';
import '../Controller/BookingediteController/BookingEditeController.dart';

class VerifyVoucherScreen extends StatefulWidget {
  const VerifyVoucherScreen({super.key});

  @override
  State<VerifyVoucherScreen> createState() => _VerifyVoucherScreenState();
}

class _VerifyVoucherScreenState extends State<VerifyVoucherScreen> {
  var _image;

  Widget bottomBar() {
    return Container(
        height: responsive(45, context),
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
          child: Heading3(
            text: "Verify Payment",
            context: context,
            center: true,
            color: Colors.white,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer3<Bookingedite, pakagecontrollers,IsUserExitsController>(
        builder: (context, booking, pkg,user, child) {
          return Scaffold(
            bottomNavigationBar: GestureDetector(
                onTap: () {
                  Get.to(() =>  PaymentVerification());
                },
                child: bottomBar()),
            appBar: AppBar(
              elevation: 2,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: AppBarText(
                text: 'Verify Payment',
                context: context,
                center: false,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: responsive(20, context),
                    vertical: responsive(10, context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Heading3(
                      text: 'Thank you Muhammad Bilal',
                      center: false,
                      context: context,
                      isbold: false,
                    ),
                    headlineSub(
                      text: "Your booking has been Reserved.",
                      context: context,
                    ),
                    SizedBox(
                      height: responsive(10, context),
                    ),

                    // Booking detail container
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(responsive(05, context)),
                        ),
                        border: Border.all(
                          color: AppColors.grayboxcolor,
                          width: responsive(1, context),
                        ),
                      ),
                      padding: EdgeInsets.all(responsive(20, context)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              headlineSub(
                                  text: "Booking number", context: context),
                              Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: responsive(20, context)),
                                    child: const Divider(
                                      color: Colors.black,
                                      thickness: 0.5,
                                    ),
                                  )),
                              headlineSubRegular(
                                  text: "70082", context: context),
                            ],
                          ),
                          SizedBox(
                            height: responsive(5, context),
                          ),
                          Row(
                            children: [
                              headlineSub(
                                  text: "Invoice number", context: context),
                              Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: responsive(20, context)),
                                    child: const Divider(
                                      color: Colors.black,
                                      thickness: 0.5,
                                    ),
                                  )),
                              headlineSubRegular(
                                  text: "334455", context: context),
                            ],
                          ),
                          SizedBox(
                            height: responsive(5, context),
                          ),
                          Row(
                            children: [
                              headlineSub(
                                  text: "Total amount", context: context),
                              Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: responsive(20, context)),
                                    child: const Divider(
                                      color: Colors.black,
                                      thickness: 0.5,
                                    ),
                                  )),
                              headlineSubRegular(
                                  text: "80,000", context: context),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsive(10, context),
                    ),
                    Heading3(
                      text: 'Download voucher where you can make the payment:',
                      center: false,
                      context: context,
                      isbold: false,
                    ),
                    SizedBox(
                      height: responsive(10, context),
                    ),

                    // voucher download container
                    InkWell(
                      onTap: () {
                        Get.to(
                              () =>
                              SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                      padding: EdgeInsets.all(
                                          responsive(10, context)),
                                      child: Voucher(
                                          chalanNo: "10782",
                                          reqNo: "00992233442",
                                          cniCNo: "1002-3934-2992-1",
                                          name: "Saqib Khan",
                                          payType: "Cash",
                                          issueDate: "24 jun 2024",
                                          amount: "80,000"))),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width,
                        padding: EdgeInsets.only(left: responsive(
                            20, context)),
                        height: responsive(52, context),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4B465C).withOpacity(0.08),
                          borderRadius: BorderRadius.all(
                            Radius.circular(responsive(05, context)),
                          ),
                          border: Border.all(
                            color: AppColors.grayboxcolor,
                            width: responsive(1, context),
                          ),
                        ),
                        child: Heading3(
                          text: 'Download voucher here',
                          center: false,
                          context: context,
                          isbold: false,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsive(10, context),
                    ),
                    Heading3(
                      text:
                      'For verification purposes, please provide your transfer ID:',
                      center: false,
                      context: context,
                      isbold: false,
                    ),

                    SizedBox(
                      height: responsive(10, context),
                    ),

                    // transfer ID Textfield
                    Container(
                        alignment: Alignment.centerLeft,
                        width: size.width,
                        padding: EdgeInsets.only(
                            left: responsive(20, context)),
                        height: responsive(52, context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(responsive(05, context)),
                          ),
                          border: Border.all(
                            color: AppColors.grayboxcolor,
                            width: responsive(1, context),
                          ),
                        ),
                        child: TextField(
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Transfer ID",
                              labelStyle: TextStyle(
                                  color: AppColors.grayboxcolor,
                                  fontSize: responsive(14, context)),
                              hintStyle: TextStyle(
                                  color: AppColors.grayboxcolor,
                                  fontSize: responsive(14, context))),
                        )),
                    SizedBox(
                      height: responsive(10, context),
                    ),

                    // or
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: AppColors.grayboxcolor,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive(20, context)),
                          child: headlineSub(text: "or", context: context),
                        ),
                        const Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: AppColors.grayboxcolor,
                            )),
                      ],
                    ),

                    SizedBox(
                      height: responsive(10, context),
                    ),
                    DottedBorder(
                        strokeWidth: 0.5,
                        color: AppColors.grayboxcolor,
                        dashPattern: [
                          responsive(10, context),
                        ],
                        child: SizedBox(
                          width: size.width,
                          height: responsive(180, context),
                          child: _image == null
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: pickImage,
                                child: Container(
                                  padding:
                                  EdgeInsets.all(responsive(10, context)),
                                  height: responsive(48, context),
                                  width: responsive(48, context),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF4B465C)
                                          .withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(
                                          responsive(6, context))),
                                  child: SvgPicture.asset(
                                    height: responsive(28, context),
                                    width: responsive(28, context),
                                    'images/upload.svg',
                                    semanticsLabel: 'vector',
                                    // fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsive(10, context),
                              ),
                              headlineSub(
                                text: "Upload snapshot of the payment slip",
                                context: context,
                              ),
                            ],
                          )
                              : Center(
                              child: Image.file(
                                _image!,
                                fit: BoxFit.contain,
                              )),
                        ))
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}

class Voucher extends StatelessWidget {
  final String chalanNo;
  final String reqNo;
  final String cniCNo;
  final String name;
  final String payType;
  final String issueDate;
  final String amount;

  const Voucher({
    required this.chalanNo,
    required this.reqNo,
    required this.cniCNo,
    required this.name,
    required this.payType,
    required this.issueDate,
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: Image.asset('images/vocher_empty.png', fit: BoxFit.cover),
        ),
        Padding(
            padding: EdgeInsets.only(
                top: responsive(187, context), left: responsive(120, context)),
            child: Row(
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textPoppins(context: context, text: chalanNo, size: 15),
                      SizedBox(
                        height: responsive(124, context),
                      ),
                      textPoppins(context: context, text: reqNo, size: 15),
                      SizedBox(
                        height: responsive(18, context),
                      ),
                      textPoppins(context: context, text: cniCNo, size: 15),
                      SizedBox(
                        height: responsive(17, context),
                      ),
                      textPoppins(context: context, text: name, size: 15),
                      SizedBox(
                        height: responsive(16, context),
                      ),
                      textPoppins(context: context, text: payType, size: 15),
                      SizedBox(
                        height: responsive(16, context),
                      ),
                      textPoppins(context: context, text: issueDate, size: 15),
                      SizedBox(
                        height: responsive(16, context),
                      ),
                      textPoppins(context: context, text: amount, size: 15),
                    ],
                  ),
                ),
                SizedBox(
                  width: responsive(240, context),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textPoppins(context: context, text: chalanNo, size: 15),
                      SizedBox(
                        height: responsive(124, context),
                      ),
                      textPoppins(context: context, text: reqNo, size: 15),
                      SizedBox(
                        height: responsive(18, context),
                      ),
                      textPoppins(context: context, text: cniCNo, size: 15),
                      SizedBox(
                        height: responsive(17, context),
                      ),
                      textPoppins(context: context, text: name, size: 15),
                      SizedBox(
                        height: responsive(16, context),
                      ),
                      textPoppins(context: context, text: payType, size: 15),
                      SizedBox(
                        height: responsive(16, context),
                      ),
                      textPoppins(context: context, text: issueDate, size: 15),
                      SizedBox(
                        height: responsive(16, context),
                      ),
                      textPoppins(context: context, text: amount, size: 15),
                    ],
                  ),
                ),
                SizedBox(
                  width: responsive(240, context),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textPoppins(context: context, text: chalanNo, size: 15),
                      SizedBox(
                        height: responsive(124, context),
                      ),
                      textPoppins(context: context, text: reqNo, size: 15),
                      SizedBox(
                        height: responsive(18, context),
                      ),
                      textPoppins(context: context, text: cniCNo, size: 15),
                      SizedBox(
                        height: responsive(17, context),
                      ),
                      textPoppins(context: context, text: name, size: 15),
                      SizedBox(
                        height: responsive(16, context),
                      ),
                      textPoppins(context: context, text: payType, size: 15),
                      SizedBox(
                        height: responsive(16, context),
                      ),
                      textPoppins(context: context, text: issueDate, size: 15),
                      SizedBox(
                        height: responsive(16, context),
                      ),
                      textPoppins(context: context, text: amount, size: 15),
                    ],
                  ),
                ),
              ],
            )),
        Positioned(
          bottom: responsive(20, context),
          left: responsive(50, context),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: responsive(50, context),
                vertical: responsive(15, context)),
            decoration: BoxDecoration(
              color: AppColors.GlobelColor,
              borderRadius: BorderRadius.circular(responsive(10, context))
            ),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: headlineSubRegular(text: "Cancel", context: context, color: Colors.white)),
                SizedBox(width: responsive(130, context),),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: headlineSubRegular(text: "Download", context: context, color: Colors.white,))
              ],
            ),
          ),
        )
      ],
    );
  }
}
