import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:huz/Constatns/Constants.dart';
import 'package:huz/View/Details/View/Details.dart';
import 'package:huz/View/Home/View/Home.dart';
import 'package:huz/View/Home/View/home_screen.dart';
import 'package:huz/View/Home/View/trips/view/trips.dart';
import 'package:huz/Widgets/snackbar.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../Controller/pakagecontroller.dart';
import '../../../Loading/loading.dart';
import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';
import '../../../Widgets/custom_app_bar.dart';
import '../../auth/controller/is_user_exist_controller.dart';
import '../Controller/BookingediteController/BookingEditeController.dart';
import '../Controller/BookingediteController/UploadTransectionsController/transectioncontroller.dart';
import '../Widgets/Bookingeditecard.dart';

class PaymentVerification extends StatefulWidget {
  var bookingnumber;
  PaymentVerification({super.key,this.bookingnumber});

  @override
  State<PaymentVerification> createState() => _PaymentVerificationState();
}

class _PaymentVerificationState extends State<PaymentVerification> {
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
    return Consumer4<IsUserExitsController, Bookingedite, pakagecontrollers,transectioncontroller>(
        builder: (context, user,  booking, pkg,transection, child) {
          if(booking.booking == null){

          }

          return InkWell(
            onTap: (){
   if(transection.filePaths.isEmpty&& transferIDController.text.isEmpty){
     showSnackbar(context, 'Please Select one Either Transection id or transection photes');

   }
              if(transection.filePaths.isNotEmpty && transferIDController.text.isEmpty){
                transection.uploadtransection(sessiontoken:user.isUser?.sessionToken,bookingnumber: booking.booking?.bookingNumber,amount: booking.booking?.totalPrice).then((value) {
                  if(value == true){
                    endLoading();
                    booking.price = null;
                    transection.imageFileList = [];
                    transection.filePaths = [];
                    transection.notifyListeners();
                    booking.Blist = [];
                    booking.bListsapi = false;
                    booking.notifyListeners();
                    Get.to(() => HomeScreen(
                      selectedIndex: 2,
                    ));


                  }
                  else {
                    endLoading();
                    showSnackbar(context, transection.trasectionmessage);
                  }
                });
              } else if(transection.filePaths.isEmpty && transferIDController.text.isNotEmpty){

                transection.uploadtransectionbynumber(sessiontoken:user.isUser?.sessionToken,bookingnumber: booking.booking?.bookingNumber,amount: booking.booking?.totalPrice,id: transferIDController.text).then((value) {
                  if(value == true){
                    endLoading();
                    transection.imageFileList = [];
                    transection.filePaths = [];
                    transection.notifyListeners();
                    booking.Blist = [];
                    booking.bListsapi = false;
                    booking.notifyListeners();
                    Get.offAll(() => HomeScreen(
                      selectedIndex: 2,
                    ));

                    print("**************** totasl price: ${booking.booking?.totalPrice}");
                    print("****************  package cost price: ${booking.booking?.totalPrice}");
                    print("****************  ptransfer id: ${transferIDController.text}");


                  }
                  else {
                    endLoading();
                    showSnackbar(context, transection.trasectionmessage);
                    print("**************** totasl price: ${booking.booking?.totalPrice}");
                    print("****************  package cost price: ${booking.booking?.totalPrice}");
                    print("****************  ptransfer id: ${transferIDController.text}");
                  }
                });
              } else {
                showSnackbar(context, 'Please Select one Either Transection id or transection photes');
                print("**************** totasl price: ${booking.booking?.totalPrice}");
                print("****************  package cost price: ${booking.booking?.totalPrice}");
                print("****************  ptransfer id: ${transferIDController.text}");
              }


              // transection.uploadtransection(sessiontoken:user.isUser?.sessionToken,bookingnumber: booking.booking?.bookingNumber,amount: booking.booking?.packageCost).then((value) {
              //   if(value == true){
              //     endLoading();
              //     transection.imageFileList = [];
              //     transection.filePaths = [];
              //     transection.notifyListeners();
              //     booking.Blist =[];
              //     booking.bListsapi = false;
              //     booking.notifyListeners();
              //     Get.to(() => HomeScreen(
              //       selectedIndex: 2,
              //     ));
              //   }
              //   else {
              //     endLoading();
              //     showSnackbar(context, 'An error Occured');
              //   }
              // });
            },
            child: Container(
                height: responsive(52, context),
                width: MediaQuery.sizeOf(context).width,
                decoration:  BoxDecoration(
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
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        // Get.off(Details(token: token));
        return true;
      },
      child: Consumer4<IsUserExitsController, Bookingedite, pakagecontrollers,transectioncontroller>(
          builder: (context, user,  booking, pkg,transection, child) {



            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: CustomAppBar(
                  title: "Verify Payment",

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
                              status: "Reserved",
                              bookingNumber: booking.booking?.bookingNumber,
                              context: context),

                          verticalSpace(10, context),

                          // Price summery container
                          PriceSummery(
                            price: formatCurrency(booking.booking?.totalPrice.toInt()),
                          ),
                          SizedBox(
                            height: responsive(10, context),
                          ),
                          // transfer ID Textfield


                          customFonts(
                              text:
                              "For verification purposes, please provide your transfer ID:",
                              size: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryBlackColor.withOpacity(0.9),
                              context: context),

                          verticalSpace(10, context),

                          customContainer(


                              child: Padding(
                                padding:  EdgeInsets.only(left: responsive(10, context)),
                                child: textField(controller: transferIDController, title: "Transfer ID", context: context),
                              )),

                          verticalSpace(15, context),


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
                                child: customFonts(
                                    text: "OR",
                                    size: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.GlobelColor,
                                    context: context),
                              ),
                              const Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: AppColors.grayboxcolor,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: responsive(15, context),
                          ),

                          // Upload snapshot container
                          InkWell(
                            onTap: (){
                              transection.pickImages();
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      customFonts(
                                          text: "Upload snapshot of the payment slip",
                                          size: 19,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryBlackColor.withOpacity(0.9),
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
                          SizedBox(height: responsive(10, context),),
                          transection.imageFileList.isEmpty?Container(): Container(
                            // height: responsive(300, context),
                            child: ListView.builder(
                                shrinkWrap: true,
                                primary: true,
                                itemCount: transection.imageFileList!.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder:(context,index){
                                  isImageSizeValid(transection.imageFileList![index].path);
                                  return Padding(
                                    padding:  EdgeInsets.symmetric(vertical: responsive(05, context)),
                                    child: Container(
                                        height: responsive(60, context),
                                        width: responsive(290, context),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(05),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2), // Shadow color
                                              spreadRadius: 2, // Spread radius
                                              blurRadius: 5, // Blur radius
                                              offset: Offset(0, 3), // Offset in x and y direction
                                            ),
                                          ],// Set the radius here
                                        ),


                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: responsive(10, context)),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(06.0),
                                                child: AspectRatio(
                                                  aspectRatio: 1.0, // Ensures the image is square
                                                  child: Image.file(
                                                    File(transection.imageFileList![index].path),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:responsive(10, context),
                                              ),
                                              isshown?customFonts(text: 'Exceeds more then 2 mb ', size: 16, context: context,fontWeight: FontWeight.bold,color: Color(0xffFCDDDD)):customFonts(text: transection.imageFileList![index].name, size: 16, context: context,fontWeight: FontWeight.bold),
                                              Spacer(),
                                              InkWell(
                                                onTap: (){
                                                  transection.imageFileList.removeAt(index);
                                                  transection.filePaths.removeAt(index);
                                                  transection.notifyListeners();
                                                },
                                                child: SvgPicture.asset(
                                                  'images/delete.svg',
                                                  height: responsive(25, context),
                                                  width: responsive(25, context),
                                                ),
                                              )
                                            ],
                                          ),
                                        )


                                    ),
                                  );


                                }),
                          ),
                          verticalSpace(30, context),
                          bottomBar(

                          ),

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
          }
      ),
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

      padding: EdgeInsets.symmetric(horizontal: responsive(20, context), vertical: responsive(8, context)),
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
              verticalSpace(3, context),
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
              verticalSpace(3, context),
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
      textAlignVertical: TextAlignVertical.center,
      inputFormatters: formater,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: title,
          labelStyle: TextStyle(
              color: AppColors.grayboxcolor, fontSize: responsive(14, context)),
          hintStyle: TextStyle(
              color: Color(0xFF867676),
              fontSize: responsive(14, context))),
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
  }}