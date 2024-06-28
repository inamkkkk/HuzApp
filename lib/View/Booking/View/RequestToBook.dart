import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/View/Booking/View/verify_payment.dart';
import 'package:huz/View/Booking/View/verify_payment_voiucer.dart';
import 'package:huz/View/Booking/Widgets/CustomContainer.dart';
import 'package:huz/View/Booking/Widgets/otp_pop_up.dart';
import 'package:huz/View/Details/View/detail_screen.dart';
import 'package:huz/View/auth/controller/otp_message_controller.dart';
import 'package:huz/View/auth/view/finish_signing_up/finish_signing_up.dart';
import 'package:huz/Widgets/animatedText/animatedText.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../Constatns/Constants.dart';
import '../../../Controller/pakagecontroller.dart';
import '../../../Loading/loading.dart';
import '../../../TextStyles/AppFonts.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';
import '../../../Widgets/custom_app_bar.dart';
import '../../Home/View/Home.dart';
import '../../auth/controller/country_picker.dart';
import '../../auth/controller/is_user_exist_controller.dart';
import '../../auth/model/country_model/country_model.dart';
import '../../auth/view/sign_up_with_mobile_number/signup_with_number.dart';
import '../Controller/BookingediteController/BookingEditeController.dart';
import '../Widgets/Bookingeditecard.dart';

class RequestToBook extends StatefulWidget {
  const RequestToBook({super.key});

  @override
  State<RequestToBook> createState() => _RequestToBookState();
}

class _RequestToBookState extends State<RequestToBook> {
  int index = 0;
  bool isUserLogin = false;
  var pMask = MaskTextInputFormatter(
      mask: '##########',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var isColored = true;
  var currentCode = '';
  var num = "";

  var country = "Pakistan", flag, code = "+92", name, dialCode;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController _countryNameController = TextEditingController();
  final TextEditingController specialreqcontroller = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  String _selectedMethod = 'Bank Transfer';
  bool isphone = false;

  Widget bottombar() {
    return Container(
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
        child: Consumer3<IsUserExitsController, OtpMessageControllerss,
            Bookingedite>(builder: (context, user, otp, booking, child) {
          return Center(
            child: booking.isApiCalled == true && booking.booking==null
                ?
            Container(
              height: responsive(20, context),
              width: responsive(20, context),
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: responsive(1.5, context),
              ),
            )
                : Heading3(
              text: "Request to book",
              context: context,
              center: true,
              color: Colors.white,
            ),
          );
        }));
  }

  var countrycode, countryname = "Pakistan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer4<IsUserExitsController,
          OtpMessageControllerss, Bookingedite, pakagecontrollers>(
          builder: (context, user, otp, booking, pkg, child) {
            return booking.isOpened ? SizedBox() :  GestureDetector(
                onTap: () {
                  booking.specialreq = specialreqcontroller.text == null ? "N/A" :  specialreqcontroller.text == "" ? "N/A" : specialreqcontroller.isNull?specialreqcontroller.text=='N/A':specialreqcontroller.text;
                  booking.paymathod = _selectedMethod;
                  booking.phonenumber = "${code}${phoneNumberController.text}";
                  booking.notifyListeners();

                  user.userfrombooking = true;
                  user.notifyListeners();
                  if(user.isUser == null){
                    Get.to(()=>SignUpWithNumber());
                  } else {
                    booking.createbookings(sessiontoken: user.isUser?.sessionToken,huztoken: pkg.details?.huzToken,partnertoken: pkg.details?.partnerSessionToken).then((value){
                      if(value == true){
                        booking.initialstartdate = null;
                        booking.initialenddate = null;
                        booking.startDate = null;
                        booking.endDate = null;
                        booking.childrens = 0;
                        booking.adults = 1;
                        Get.off(()=> VerifyPaymentScreen());
                      }
                    });

                  }

                },
                child:   Visibility(
                    visible:  booking.isedite,
                    child: bottombar()));
          }),
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          title: "Request to book",

        ),
      ),
      body: SingleChildScrollView(
        child: Consumer2<Bookingedite, pakagecontrollers>(
            builder: (context, booking, pkg, child) {
              return Stack(
                children: [
                  Container(
                    color: Color(0xFFF2F2F2),
                    height: responsive(85, context),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: responsive(20, context),
                        vertical: responsive(10, context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(29, context),
                        CustomContainer(
                          onView: (){
                            Get.to(()=> DetailScreen(token: pkg.details?.huzToken, isView: true));
                          },
                          pkg:pkg,
                          title: pkg.details?.packageName,
                          madinanights: pkg.details?.madinahNights,
                          meccanights: pkg.details?.meccaNights,
                          starDate: DateFormat('dd MMM yyyy')
                              .format(DateTime.parse(pkg.details?.startDate)),
                          endDate: DateFormat('dd MMM yyyy')
                              .format(DateTime.parse(pkg.details?.endDate)),
                          amount: formatCurrency(pkg?.details?.packageCost.toInt()),
                        ),
                        SizedBox(
                          height: responsive(10, context),
                        ),
                        bookingdetail(
                          // isFlex: pkg.details?.isPackageOpenForOtherDate,
                          isFlex: true,



                          startdate: booking.startDate ??
                              DateFormat('dd MMM yyyy')
                                  .format(DateTime.parse(pkg.details?.startDate)),
                          enddate: booking.endDate ??
                              DateFormat('dd MMM yyyy')
                                  .format(DateTime.parse(pkg.details?.endDate)),
                          adults: booking.adults,
                          child: booking.childrens,
                          infent: booking.infents,
                          combineNights: booking.combineNights,
                          packageName: pkg.details?.packageName,
                        ),
                        SizedBox(
                          height: responsive(15, context),
                        ),
                        customFonts(
                            text: "Your Price summary",
                            size: 16,
                            fontWeight: FontWeight.bold,
                            context: context),
                        verticalSpace(10, context),
                        PriceSummery(
                          price: formatCurrency(booking.price.toInt()) ?? formatCurrency(pkg?.details?.packageCost.toInt()),
                        ),
                        SizedBox(
                          height: responsive(10, context),
                        ),
                        Visibility(
                          visible:  booking.isedite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customFonts(
                                  text: "Special request",
                                  size: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryBlackColor.withOpacity(0.9),
                                  context: context),
                              SizedBox(
                                height: responsive(05, context),
                              ),
                              RoundedBorderTextField(
                                controller: specialreqcontroller,
                                hintText: 'Write a special request',
                              ),
                              SizedBox(
                                height: responsive(10, context),
                              ),
                              customFonts(
                                  text:
                                  "Special requests cannot be guaranteed - but the organization will do its best to meet your needs.",
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryBlackColor.withOpacity(0.9),
                                  context: context),
                              SizedBox(
                                height: responsive(10, context),
                              ),
                              customFonts(
                                  text: "How would you like to pay?",
                                  size: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryBlackColor.withOpacity(0.9),
                                  context: context),
                              SizedBox(
                                height: responsive(10, context),
                              ),
                              _buildPaymentMethodTile(
                                  'Bank Transfer', _selectedMethod, 0),
                              _buildPaymentMethodTile('By Cheque', _selectedMethod, 1),
                              _buildPaymentMethodTile('By Voucher', _selectedMethod, 2),
                              SizedBox(
                                height: responsive(20, context),
                              ),
                              Container(
                                height: responsive(74, context),
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE6F4F0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: responsive(20, context),
                                      vertical: responsive(10, context)),
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: responsive(13, context),
                                        fontFamily: GoogleFonts.cairo(
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.normal))
                                            .fontFamily,
                                        // fontFamily: AppFonts.poppinsMedium,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      children: [
                                        TextSpan(
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.primaryBlackColor
                                                .withOpacity(0.8),
                                          ),
                                          text:
                                          "By selecting the button below, I agree to the Hajjumrah.co ",
                                        ),
                                        TextSpan(
                                          text: "Refund policy",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.GlobelColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => print("Clicked!"),
                                        ),
                                        TextSpan(
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.primaryBlackColor
                                                  .withOpacity(0.8),
                                            ),
                                            text: " and "),
                                        TextSpan(
                                          text: "Cancelation policy.",
                                          style: const TextStyle(
                                            color: AppColors.GlobelColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => print("Clicked!"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsive(20, context),
                              ),
                            ],

                          ),
                        )



                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget validator({
    required String title,
  }) {
    return Row(
      children: [
        Icon(
          Icons.info,
          color: Colors.red,
          size: responsive(15, context),
        ),
        SizedBox(
          width: responsive(05, context),
        ),
        textPoppins(context: context, text: title, size: 12, color: Colors.red),
      ],
    );
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
        fontSize: responsive(15, context),
        color: Colors.black,
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
              color: AppColors.grayboxcolor,
              fontSize: responsive(14, context))),
    );
  }

  Widget customContainer(
      {double height = 52,
        required Widget child,
        double? width,
        Alignment? alignment}) {
    return Container(
      alignment: alignment,
      height: responsive(height, context),
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(responsive(10, context)),
      ),
      child: child,
    );
  }

  Widget otpPopUp() {
    return Consumer4<
        IsUserExitsController,
        OtpMessageControllerss,
        Bookingedite,
        pakagecontrollers>(builder: (context, user, otp, booking, pkg, child) {
      return Container(
        height: responsive(420, context),
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
            horizontal: responsive(20, context),
            vertical: responsive(20, context)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(responsive(10, context)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF4B465C).withOpacity(0.25),
                  blurRadius: responsive(24, context),
                  offset: Offset(
                    0,
                    responsive(4, context),
                  ))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(
            //   height: 40,
            // ),
            SizedBox(
                width: responsive(72, context),
                child: Image.asset("images/otp_icon.png")),
            SizedBox(
              height: responsive(15, context),
            ),
            textPoppins(
                context: context,
                text: "Verifying your number to proceed",
                size: 15,
                fontFamily: AppFonts.poppinsSemiBold,
                color: const Color(0xFF4B465C)),
            SizedBox(
              height: responsive(10, context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                textPoppins(
                    context: context,
                    text: 'Enter 6 digit OTP Code sent to ',
                    size: 12,
                    color: const Color(0xFF4B465C)),
                Text(
                  '${code}${phoneNumberController.text}',
                  style: TextStyle(
                      fontFamily: AppFonts.poppinsSemiBold,
                      color: const Color(0xFF4B465C),
                      fontSize: responsive(12, context)),
                ),
              ],
            ),
            SizedBox(
              height: responsive(20, context),
            ),
            PinFieldAutoFill(
              decoration: BoxLooseDecoration(
                hintText: "------",
                gapSpace: responsive(10, context),
                radius: Radius.circular(responsive(5, context)),
                strokeColorBuilder: PinListenColorBuilder(
                    const Color(0xFFDEDDDD), const Color(0xFFDEDDDD)),
              ),
              currentCode: currentCode,
              // UnderlineDecoration, BoxLooseDecoration or BoxTightDecoration see https://github.com/TinoGuo/pin_input_text_field for more info,

              cursor: Cursor(
                color: AppColors.GlobelColor,
                width: 1,
                height: 20,
              ),
              onCodeSubmitted: (value) {
                // std.getSchools('${widget.num}');
                Get.offAll(FinishSignUp());
                if (code == '+90002') {
                  // otp.match(value,context,);
                } else //SigninController.verifyOTP(value,widget.num,context);
                  debugPrint('the code $value');
              },
              onCodeChanged: (value) async {
                setState(() {
                  currentCode = value!;
                });

                if (value?.length == 6) {
                  if (currentCode == '123456') {
                    if (user.isUser?.sessionToken == null) {
                      Get.off(FinishSignUp());
                    } else {
                      booking.createbookings(
                          sessiontoken: user.isUser?.sessionToken,
                          partnertoken: pkg.details?.partnerSessionToken,
                          huztoken: pkg.details?.huzToken);
                    }
                  }

                  // setState(() {
                  //   widget.currentCode = value!;
                  // });

                  // // print("number is${widget.num}");
                  // // std.getSchools('${widget.num}');
                  //
                  // otp.Matchotp(
                  //     context, widget.num, widget.currentCode);
                  // if (widget.code == '+90002') {
                  //   // otp.match(value,context,widget.num);
                  // } else //otp.Matchotp(context, widget.num );
                  //   debugPrint('the code is $value');
                }
              },
              keyboardType: TextInputType.number,
              // autoFocus: true,
              codeLength: 6,
            ),

            // OtpTextField(
            //   numberOfFields: 6,
            //   // borderColor: Colors.black,
            //   // focusedBorderColor: Colors.black,
            //   // cursorColor: Colors.black,
            //
            //   disabledBorderColor: Colors.black,
            //   //set to true to show as box or false to show as dash
            //   showFieldAsBox: false,
            //   //runs when a code is typed in
            //   onCodeChanged: (String code) {
            //     //handle validation or checks here
            //   },
            //   //runs when every textfield is filled
            //   onSubmit: (String verificationCode){
            //
            //     SigninController.verifyOTP(verificationCode,widget.num,context);
            //
            //
            //   }, // end onSubmit
            // ),

            // NumberInputTextField(
            //   cursorHeight: 0,
            //   readOnly: true,
            // ),
            SizedBox(
              height: responsive(20, context),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textPoppins(
                    context: context, text: "Didn't receive code? ", size: 12),
                InkWell(
                    onTap: () {
                      if (code == '+90002') {
                        // otp.ReSendoTP(widget.num);
                      } else {
                        // SigninController.resendOtp(widget.num,widget.code);
                      }
                    },
                    child: Text(
                      'Resend',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: AppFonts.poppinsSemiBold,
                          color: AppColors.GlobelColor,
                          fontSize: responsive(13, context)),
                    )),
              ],
            ),
            SizedBox(
              height: responsive(20, context),
            ),
            InkWell(
              onTap: () {
                currentCode = "";
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                height: responsive(52, context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(responsive(5, context)),
                  color: AppColors.GlobelColor,
                ),
                child: booking.isApiCalled == true
                    ? Container(
                  height: responsive(20, context),
                  width: responsive(20, context),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: responsive(1.5, context),
                  ),
                )
                    : textPoppins(
                    context: context,
                    text: "Continue",
                    size: 15,
                    color: Colors.white,
                    fontFamily: AppFonts.poppinsBold),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPaymentMethodTile(String method, String selectedMethod, int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
          index = i;
        });
      },
      child: Container(
        height: responsive(52, context),
        decoration: BoxDecoration(
          color: method == selectedMethod
              ? AppColors.GlobelColor.withOpacity(0.2)
              : Colors.white,
          border: i == 1
              ? Border(
            top: BorderSide(
              color: method == selectedMethod
                  ? AppColors.GlobelColor
                  : Colors.transparent,
              width: 1,
            ),
            bottom: BorderSide(
              color: method == selectedMethod
                  ? AppColors.GlobelColor
                  : Colors.transparent,
              width: 1,
            ),
            left: BorderSide(
              color: method == selectedMethod
                  ? AppColors.GlobelColor
                  : Colors.grey.shade300,
              width: 1,
            ),
            right: BorderSide(
              color: method == selectedMethod
                  ? AppColors.GlobelColor
                  : Colors.grey.shade300,
              width: 1,
            ),
          )
              : Border.all(
            color: method == selectedMethod
                ? AppColors.GlobelColor
                : Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: i == 0
              ? BorderRadius.only(
              topLeft: Radius.circular(responsive(5, context)),
              topRight: Radius.circular(responsive(5, context)))
              : i == 2
              ? BorderRadius.only(
              bottomLeft: Radius.circular(responsive(5, context)),
              bottomRight: Radius.circular(responsive(5, context)))
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: responsive(08, context)),
          child: Row(
            children: [
              cardtrailingsubtitle(
                text: '$method',
                center: false,
                context: context,
                isbold: false,
              ),
              const Spacer(),
              _buildCustomRadio(method == selectedMethod),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomRadio(bool isSelected) {
    return Container(
      width: responsive(20, context),
      height: responsive(20, context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.GlobelColor : Colors.grey,
          width: isSelected ? responsive(06.5, context) : 2.0,
        ),
      ),
      child: isSelected
          ? Center(
        child: Container(
          width: responsive(12, context),
          height: responsive(12, context),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      )
          : null,
    );
  }
}