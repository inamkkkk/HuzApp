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
import '../../../../../utils/servecies.dart';
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
        Get.back();
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

            child: Center(
              child: Heading3(
                text: "Previous page",
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

                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          primary: true,
                          itemCount: booking.booking?.adults,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: responsive(10, context)),
                              child: DocsContainer(
                                  index: index, traveler: 'Adult'),
                            );
                          }),

                      booking.booking?.child != 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              primary: true,
                              itemCount: booking.booking?.child,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: responsive(10, context)),
                                  child: DocsContainer(
                                      index: index, traveler: 'Child'),
                                );
                              })
                          : Container(),
                      // Upload snapshot container

                      verticalSpace(30, context),
                      bottomBar(),

                      SizedBox(
                        height: responsive(10, context),
                      ),
                      SizedBox(
                        height: responsive(10, context),
                      ),
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
      padding: EdgeInsets.symmetric(
          horizontal: responsive(20, context),
          vertical: responsive(8, context)),
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
                  size: 13,
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
                  size: 13,
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

class DocsContainer extends StatefulWidget {
  var index, traveler;

  DocsContainer({super.key, required this.index, required this.traveler});

  @override
  State<DocsContainer> createState() => _DocsContainerState();
}

class _DocsContainerState extends State<DocsContainer> {
  var _image;
  var userphoto, passportphoto, userid, passportid;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer3<IsUserExitsController, Bookingedite, pakagecontrollers>(
        builder: (context, user, booking, pkg, child) {
          if(userphoto==null||passportphoto ==null){
            if (booking.booking!.userDocuments!.isNotEmpty) {
              for (var m in booking.booking!.userDocuments!) {
                if (m.documentType == "user_passport") {
                  if (m.comment ==
                      "Traveler_${widget.index + 1}-${widget.traveler}_${widget.index + 1}") {
                    userphoto = m.userDocument;
                    userid = m.userDocumentId;
                  }
                }
              }
            }
            if (booking.booking!.userDocuments!.isNotEmpty) {
              for (var m in booking.booking!.userDocuments!) {
                if (m.documentType == "user_passport_photo") {
                  if (m.comment ==
                      "Traveler_${widget.index + 1}-${widget.traveler}_${widget.index + 1}") {
                    passportphoto = m.userDocument;
                    passportid = m.userDocumentId;
                  }
                }
              }
            }
          }

      return Container(
        decoration: BoxDecoration(
          // Background color of the container
          border: Border.all(
            color: AppColors.grayboxcolor, // Border color
            width: 0.5, // Border width
          ),
          borderRadius: BorderRadius.circular(06.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(responsive(10, context)),
              child: customFonts(
                  text:
                      "Upload documents for ${widget.traveler} ${widget.index + 1}",
                  size: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryBlackColor.withOpacity(0.9),
                  context: context),
            ),
            SizedBox(
              height: responsive(10, context),
            ),
            userphoto == null
                ?   InkWell(
              onTap: () {
                booking.pickImage(
                    doctype: 'user_passport',
                    numb:
                    'Traveler_${widget.index + 1}-${widget.traveler}_${widget.index + 1}',
                    context: context);
              },
              child: Padding(
                padding: EdgeInsets.all(responsive(10, context)),
                child: DottedBorder(
                    radius: Radius.circular(responsive(20, context)),
                    strokeWidth: 0.5,
                    color: AppColors.grayboxcolor,
                    dashPattern: [
                      responsive(10, context),
                    ],
                    child: SizedBox(
                      width: size.width,
                      height: responsive(60, context),
                      child: _image == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customFonts(
                                    text: "Upload Photos",
                                    size: 13,
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
            ): Padding(
              padding: EdgeInsets.symmetric(
                  vertical: responsive(10, context),horizontal: responsive(10, context)),
              child: Container(
                  height: responsive(60, context),
                  // width: responsive(290, context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(05),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 1,
                        offset:
                        Offset(0, 3), // Offset in x and y direction
                      ),
                    ], // Set the radius here
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: responsive(10, context)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(06.0),
                          child: AspectRatio(
                              aspectRatio: 1.0,
// Ensures the image is square
                              child: Image.network(
                                  '${NetworkServices.ibaseUrl}${userphoto}')),
                        ),
                        SizedBox(
                          width: responsive(30, context),
                        ),
                        customFonts(
                            text: 'User photo',
                            size: 16,
                            context: context,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Loading();
                            booking.deletedoc(id: userid,bookingnumber: booking?.booking?.bookingNumber, sessiontoken: booking?.booking?.userSessionToken).then((value){
                              if(value = true){
                                endLoading();
                                userphoto = null;
                                setState(() {

                                });

                              } else {
                                showSnackbar(context, 'Could not delete image ');
                              }
                            });
                          },
                          child: SvgPicture.asset(
                            'images/delete.svg',
                            height: responsive(25, context),
                            width: responsive(25, context),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: responsive(10, context),
            ),
            passportphoto == null
                ?  InkWell(
              onTap: () {
                booking.pickImage(
                    doctype: 'user_passport_photo',
                    numb:
                        'Traveler_${widget.index + 1}-${widget.traveler}_${widget.index + 1}',
                    context: context);
              },
              child: Padding(
                      padding: EdgeInsets.only(
                          left: responsive(10, context),
                          right: responsive(10, context),
                          bottom: responsive(10, context)),
                      child: DottedBorder(
                          radius: Radius.circular(responsive(10, context)),
                          strokeWidth: 0.5,
                          color: AppColors.grayboxcolor,
                          dashPattern: [
                            responsive(10, context),
                          ],
                          child: SizedBox(
                            width: size.width,
                            height: responsive(60, context),
                            child: _image == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      customFonts(
                                          text: "Upload snapshot of Passport",
                                          size: 13,
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
                    )

            ): Padding(
              padding: EdgeInsets.symmetric(
                  vertical: responsive(10, context),horizontal: responsive(10, context)),
              child: Container(
                  height: responsive(60, context),
                  // width: responsive(290, context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(05),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 1,
                        offset:
                        Offset(0, 3), // Offset in x and y direction
                      ),
                    ], // Set the radius here
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: responsive(10, context)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(06.0),
                          child: AspectRatio(
                              aspectRatio: 1.0,
// Ensures the image is square
                              child: Image.network(
                                  '${NetworkServices.ibaseUrl}${passportphoto}')),
                        ),
                        SizedBox(
                          width: responsive(30, context),
                        ),
                        customFonts(
                            text: 'User Passport photo',
                            size: 16,
                            context: context,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                        Spacer(),
                        InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'images/delete.svg',
                            height: responsive(25, context),
                            width: responsive(25, context),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      );
    });
  }
}
