import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:huz/TextStyles/Color.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../../../Controller/pakagecontroller.dart';
import '../../../../../Loading/loading.dart';
import '../../../../../Responsive/ResponsiveClass.dart';
import '../../../../../TextStyles/styles.dart';
import '../../../../../Widgets/snackbar.dart';
import '../../../../Booking/Controller/BookingediteController/BookingEditeController.dart';

import '../../../../Booking/Widgets/Bookingeditecard.dart';
import '../../../../auth/controller/is_user_exist_controller.dart';
import '../../home_screen.dart';

class UploadRequiredDocs extends StatefulWidget {
  var bookingnumber;

  UploadRequiredDocs({super.key, this.bookingnumber});

  @override
  State<UploadRequiredDocs> createState() => _UploadRequiredDocsState();
}

class _UploadRequiredDocsState extends State<UploadRequiredDocs> {
  var _image;
  WidgetsToImageController controller = WidgetsToImageController();
  TextEditingController transferIDController = TextEditingController();
  Uint8List? bytes;

  _saveLocalImage(var image) async {
    if (image != null) {
      final result = await ImageGallerySaver.saveImage(image);
      print(result);
    }
  }

  Widget bottomBar() {
    return Consumer3<IsUserExitsController, Bookingedite, pakagecontrollers>(
        builder: (context, user, booking, pkg, child) {
      if (booking.booking == null) {}

      return InkWell(
        onTap: () {
          booking.Uploaduserdocs(
                  sessiontoken: user.isUser?.sessionToken,
                  bookingnumber: booking.booking?.bookingNumber,
                  amount: booking.booking?.packageCost)
              .then((value) {
            if (value == true) {

              // booking.Blist =[];
              booking.getbookingdetail(user.isUser?.sessionToken, booking.booking?.bookingNumber).then((value) {


                endLoading();
                booking.imageFileList = [];
                booking.filePaths = [];
                booking.Blist = [];
                booking.notifyListeners();
                Get.back();
              });

            } else {
              endLoading();
              showSnackbar(context, booking.uploadphotomessage);
            }
          });
        },
        child: Container(
            height: responsive(52, context),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(responsive(5, context)),
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
                text: "Submit",
                context: context,
                center: true,
                color: Colors.white,
              ),
            )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        // Get.off(Details(token: token));
        return true;
      },
      child: Consumer3<IsUserExitsController, Bookingedite, pakagecontrollers>(
          builder: (context, user, booking, pkg, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: AppBarText(
              text: 'Upload documents',
              context: context,
              center: false,
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  color: const Color(0xFFF2F2F2),
                  height: responsive(62, context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive(20, context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(33, context),
                      // status card
                      statusCard(
                          status: "${booking.booking?.bookingStatus}",
                          bookingNumber: booking.booking?.bookingNumber,
                          context: context),

                      verticalSpace(10, context),

                      // Price summery container
                      // transfer ID Textfield
                      SizedBox(
                        height: responsive(10, context),
                      ),

                      customFonts(
                          text:
                              "For verification purposes, please provide your Passport and ID:",
                          size: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlackColor.withOpacity(0.9),
                          context: context),

                      verticalSpace(15, context),

                      SizedBox(
                        height: responsive(15, context),
                      ),

                      // Upload snapshot container
                      InkWell(
                        onTap: () {
                          booking.pickImages();
                        },
                        child: DottedBorder(
                            radius: Radius.circular(responsive(10, context)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          // onTap: pickImage,
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                responsive(10, context)),
                                            height: responsive(48, context),
                                            width: responsive(48, context),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFF4B465C)
                                                    .withOpacity(0.08),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        responsive(
                                                            6, context))),
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
                                        customFonts(
                                            text:
                                                "Upload snapshot of Passport and ID",
                                            size: 17,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primaryBlackColor
                                                .withOpacity(0.9),
                                            context: context),
                                      ],
                                    )
                                  : Center(
                                      child: Image.file(
                                      _image!,
                                      fit: BoxFit.contain,
                                    )),
                            )),
                      ),
                      SizedBox(
                        height: responsive(10, context),
                      ),
                      booking.imageFileList.isEmpty
                          ? Container()
                          : Container(
                              height: responsive(300, context),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  primary: true,
                                  itemCount: booking.imageFileList!.length,
                                  itemBuilder: (context, index) {
                                    isImageSizeValid(
                                        booking.imageFileList![index].path);
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: responsive(05, context)),
                                      child: Container(
                                          height: responsive(60, context),
                                          width: responsive(290, context),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(05),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                // Shadow color
                                                // spreadRadius: , // Spread radius
                                                blurRadius: 1,
                                                // Blur radius
                                                offset: Offset(0,
                                                    3), // Offset in x and y direction
                                              ),
                                            ], // Set the radius here
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    responsive(10, context)),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          06.0),
                                                  child: AspectRatio(
                                                    aspectRatio: 1.0,
                                                    // Ensures the image is square
                                                    child: Image.file(
                                                      File(booking
                                                          .imageFileList![index]
                                                          .path),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      responsive(10, context),
                                                ),
                                                isshown
                                                    ? customFonts(
                                                        text:
                                                            'Exceeds more then 2 mb ',
                                                        size: 16,
                                                        context: context,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xffFCDDDD))
                                                    : customFonts(
                                                        text: booking
                                                            .imageFileList![
                                                                index]
                                                            .name,
                                                        size: 16,
                                                        context: context,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    booking.imageFileList
                                                        .removeAt(index);
                                                    booking.filePaths
                                                        .removeAt(index);
                                                    booking.notifyListeners();
                                                  },
                                                  child: SvgPicture.asset(
                                                    'images/delete.svg',
                                                    height:
                                                        responsive(25, context),
                                                    width:
                                                        responsive(25, context),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    );
                                  }),
                            ),
                      verticalSpace(30, context),
                      bottomBar(),

                      // or

                      // WidgetsToImage(
                      //   controller: controller,
                      //   child: Container(
                      //     width: size.width,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(responsive(05, context)),
                      //       ),
                      //       border: Border.all(
                      //         color: AppColors.grayboxcolor,
                      //         width: responsive(1, context),
                      //       ),
                      //     ),
                      //     padding: EdgeInsets.all(responsive(20, context)),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Heading3(
                      //           text: 'Your booking detail',
                      //           center: false,
                      //           context: context,
                      //           isbold: false,
                      //         ),
                      //         SizedBox(
                      //           height: responsive(10, context),
                      //         ),
                      //         detailRow(
                      //             title: "Package", data: "Economy", context: context),
                      //         SizedBox(
                      //           height: responsive(10, context),
                      //         ),
                      //         detailRow(
                      //             title: "Booking number",
                      //             data: "13373",
                      //             context: context),
                      //         SizedBox(
                      //           height: responsive(10, context),
                      //         ),
                      //         detailRow(
                      //             title: "Invoice number",
                      //             data: "1990223",
                      //             context: context),
                      //         SizedBox(
                      //           height: responsive(10, context),
                      //         ),
                      //         detailRowDate(
                      //             title: "Start date",
                      //             date: "Sat 25 jun 2024",
                      //             time: "12:00 pm - 1:00 pm",
                      //             context: context),
                      //         SizedBox(
                      //           height: responsive(10, context),
                      //         ),
                      //         detailRowDate(
                      //             title: "End date",
                      //             date: "Sat 1 july 2024",
                      //             time: "12:00 pm - 1:00 pm",
                      //             context: context),
                      //         SizedBox(
                      //           height: responsive(10, context),
                      //         ),
                      //         detailRow(
                      //             title: "Length of stay",
                      //             data: "30 nights",
                      //             context: context),
                      //         SizedBox(
                      //           height: responsive(10, context),
                      //         ),
                      //         detailRow(
                      //             title: "Package", data: "Economy", context: context),
                      //         SizedBox(
                      //           height: responsive(10, context),
                      //         ),
                      //         Divider(
                      //           color: Colors.black.withOpacity(0.30),
                      //           thickness: 0.5,
                      //         ),
                      //         SizedBox(
                      //           height: responsive(10, context),
                      //         ),
                      //         headlineSub(
                      //           text: "You selected",
                      //           context: context,
                      //         ),
                      //         SizedBox(
                      //           height: 5,
                      //         ),
                      //         Heading3(
                      //           text: '30 nights of stay with 4 members',
                      //           center: false,
                      //           context: context,
                      //           isbold: false,
                      //         ),
                      //         SizedBox(
                      //           height: responsive(10, context),
                      //         ),
                      //         Divider(
                      //           color: Colors.black.withOpacity(0.30),
                      //           thickness: 0.5,
                      //         ),
                      //         SizedBox(
                      //           height: responsive(10, context),
                      //         ),
                      //         headlineSub(
                      //           text: "Your price summery",
                      //           context: context,
                      //         ),
                      //         SizedBox(
                      //           height: responsive(5, context),
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Heading3(
                      //               text: 'Payment',
                      //               center: false,
                      //               context: context,
                      //               isbold: false,
                      //             ),
                      //             Heading3(
                      //               text: 'PKR 80,000',
                      //               center: false,
                      //               context: context,
                      //               isbold: false,
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: responsive(10, context),
                      ),
                      SizedBox(
                        height: responsive(10, context),
                      ),
                      // SizedBox(
                      //   width: size.width,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.end,
                      //     children: [
                      //       GestureDetector(
                      //         onTap:() async {
                      //           final bytes = await controller.capture();
                      //           setState(() {
                      //             this.bytes = bytes;
                      //           });
                      //           showDialog(context: context, builder: (context) => Container(
                      //
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.circular(responsive(20, context)),
                      //             ),
                      //             padding: EdgeInsets.symmetric(horizontal: responsive(20, context), vertical: responsive(20, context)),
                      //             alignment: Alignment.topCenter,
                      //             child: Column(
                      //               children: [
                      //                 SizedBox(height: responsive(20, context),),
                      //                 customFonts(text: "Save to Gallery", fontWeight: FontWeight.bold ,size: 15, context: context),
                      //                 SizedBox(height: responsive(20, context),),
                      //                 Image.memory(bytes!),
                      //                 SizedBox(height: responsive(20, context),),
                      //                 Row(
                      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     GestureDetector(
                      //                       onTap: () {
                      //                         Navigator.pop(context);
                      //                       },
                      //                       child: Container(
                      //                           padding: EdgeInsets.symmetric(
                      //                               horizontal: responsive(25, context)),
                      //                           decoration: BoxDecoration(
                      //                               color: AppColors.GlobelColor.withOpacity(0.2),
                      //                               borderRadius:
                      //                               BorderRadius.circular(responsive(5, context))),
                      //                           height: responsive(40, context),
                      //                           alignment: Alignment.center,
                      //                           child: customFonts(
                      //                               text: "Cancel",
                      //                               size: 15,
                      //                               context: context)),
                      //                     ),
                      //                     GestureDetector(
                      //                       onTap: () {
                      //                         _saveLocalImage(this.bytes);
                      //                         Navigator.pop(context);
                      //                       },
                      //                       child: Container(
                      //                           padding: EdgeInsets.symmetric(
                      //                               horizontal: responsive(25, context)),
                      //                           decoration: BoxDecoration(
                      //                               color: AppColors.GlobelColor,
                      //                               borderRadius:
                      //                               BorderRadius.circular(responsive(5, context))),
                      //                           height: responsive(40, context),
                      //                           alignment: Alignment.center,
                      //                           child: customFonts(
                      //                               text: "Save to galley",
                      //                               size: 15,
                      //                               color: Colors.white,
                      //                               context: context)),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ));
                      //         },
                      //         // onTap: () async {
                      //         //   final bytes = await controller.capture();
                      //         //   setState(() {
                      //         //     this.bytes = bytes;
                      //         //   });
                      //         //   _saveLocalImage(this.bytes);
                      //         // },
                      //         child: Heading3(
                      //           text: 'Download Slip',
                      //           center: false,
                      //           isunderline: true,
                      //           context: context,
                      //           isbold: false,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  var isshown = false;

  Future<void> isImageSizeValid(String imagePath) async {
    File imageFile = File(imagePath);
    int fileSizeInBytes = await imageFile.length();
    double fileSizeInMB = fileSizeInBytes / (1024 * 1024); // Convert to MB

    if (fileSizeInMB > 2) {
      // Image size exceeds 2 MB
      setState(() {
        isshown = true;
      });
    } else {
      // Image size is within limit
      setState(() {
        isshown = false;
      });
    }
  }

  Widget buildImage(Uint8List bytes) => Image.memory(bytes);

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

  Row detailRow({
    required String title,
    required String data,
    required BuildContext context,
  }) {
    return Row(
      children: [
        headlineSub(text: title, context: context),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: responsive(20, context)),
          child: const Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
        )),
        headlineSubRegular(text: data, context: context),
      ],
    );
  }

  Row detailRowDate(
      {required String title,
      required BuildContext context,
      required String date,
      required String time}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        headlineSub(text: title, context: context),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: responsive(20, context)),
          child: const Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
        )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            headlineSubRegular(text: date, context: context),
            headlineSub(text: time, context: context),
          ],
        )
      ],
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

  TextField textField(
      {required controller,
      required String title,
      required BuildContext context,
      var formater,
      onchanged}) {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(),
      controller: controller,
      onChanged: onchanged,
      style: TextStyle(
        fontSize: responsive(14, context),
        color: Color(0xFF867676),
        fontWeight: FontWeight.normal,
      ),
      cursorColor: AppColors.GlobelColor,
      textAlign: TextAlign.left,
      inputFormatters: formater,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: title,
          labelStyle: TextStyle(
              color: AppColors.grayboxcolor, fontSize: responsive(14, context)),
          hintStyle: TextStyle(
              color: Color(0xFF867676), fontSize: responsive(14, context))),
    );
  }

  Widget customContainer(
      {double height = 52,
      required Widget child,
      double? width,
      Alignment? alignment}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: responsive(5, context)),
      height: responsive(height, context),
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFDCDCDC),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(responsive(5, context)),
      ),
      child: child,
    );
  }
}
