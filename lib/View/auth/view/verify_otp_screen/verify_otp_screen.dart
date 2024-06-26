import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huz/Loading/loading.dart';
import 'package:huz/View/Home/View/home_screen.dart';
import 'package:huz/View/auth/controller/is_user_exist_controller.dart';
import 'package:huz/View/auth/view/finish_signing_up/finish_signing_up.dart';
import 'package:huz/Widgets/primary_button.dart';

import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../Responsive/ResponsiveClass.dart';
import '../../../../TextStyles/AppFonts.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../TextStyles/styles.dart';
import '../../../../Widgets/back_button.dart';
import '../../../../Widgets/error_message_popup/error_message.dart';
import '../../../Booking/View/payment_verification.dart';
import '../../../Booking/View/verify_payment.dart';
import '../../../Home/View/Home.dart';
import '../../controller/location_controller.dart';
import '../../controller/otp_message_controller.dart';
import '../input_fields.dart';

class VerifyOTPScreen extends StatefulWidget {
  var num, code;

  VerifyOTPScreen({Key? key, this.num, required this.code}) : super(key: key);

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController otpController = TextEditingController();

  void listenForOTP() async {
    await SmsAutoFill().listenForCode();
  }

  var currentCode = '';

  @override
  void initState() {
    listenForOTP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<LocationController, OtpMessageControllerss,IsUserExitsController>(
        builder: (context, std, otp, user, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: std.isloading
              ? Container(
                  height: responsive(914, context),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.GlobelColor,
                    ),
                  ))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: BackIconButton(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: ErrorMesssage(
                        isVisible: otp.vissible,
                        message: otp.message,
                        onTap: () {
                          otp.vissible = false;
                          otp.notifyListeners();
                        },
                      ),
                    ),
                    // SizedBox(
                    //   child: ErrorMesssage(isVisible: otp.vissible, message: otp.message!,onTap: (){
                    //     setState(() {
                    //     otp.closepop();
                    //     });},),
                    // ),
                    SizedBox(
                      height: responsive(100, context),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: responsive(20, context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const SizedBox(
                          //   height: 40,
                          // ),

                          customFonts(
                              context: context,
                              text: 'Verifying your number',
                              size: 26,
                              color: const Color(0xFF466262),
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: responsive(10, context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customFonts(
                                  context: context,
                                  text: 'Enter 6 digit OTP Code sent to ',
                                  size: 14,
                                  color: const Color(0xFF4B465C)),
                              customFonts(
                                  context: context,
                                  text: "${widget.num}",
                                  size: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF4B465C)),
                            ],
                          ),
                          SizedBox(
                            height: responsive(20, context),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: responsive(20, context)),
                            child: PinFieldAutoFill(
                              decoration: BoxLooseDecoration(
                                bgColorBuilder: const FixedColorBuilder(
                                  Color(0xFFF5F5F5),
                                ),
                                hintText: "------",
                                hintTextStyle:
                                    const TextStyle(color: Color(0xFFD2D2D2)),
                                gapSpace: responsive(5, context),
                                radius: Radius.circular(responsive(5, context)),
                                strokeColorBuilder: PinListenColorBuilder(
                                    const Color(0xFFEAEAEA),
                                    const Color(0xFFEAEAEA)),
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
                                Get.offAll(HomeScreen());
                                if (widget.code == '+90002') {
                                  // otp.match(value,context,widget.num);
                                } else //SigninController.verifyOTP(value,widget.num,context);
                                  debugPrint('the code $value');
                              },
                              onCodeChanged: (value) async {
                                setState(() {
                                  currentCode = value!;
                                });
                                if (value?.length == 6) {
                                  setState(() {
                                    currentCode = value!;
                                  });
                                  // print("number is${widget.num}");
                                  // std.getSchools('${widget.num}');

                                  otp.Matchotp(
                                   phoneNumber:widget.num,code: widget.code, enteredOtp: currentCode).then((value) {
                                        if(value==true){
                                          debugPrint('say hi');
                                          endLoading();
                                          if(user.isUser!=null && user.userfrombooking){
                                            debugPrint('say hi999');
                                            Navigator.pop(context);
                                            Navigator.pop(context);


                                          } else if(user.isUser!=null && !user.userfrombooking){
                                            debugPrint('say hiiiiiii');
                                            Get.offAll(HomeScreen());
                                          }
                                          else if(user.isUser == null){
                                            Get.off(FinishSignUp());
                                          }

                                        }else{
                                          endLoading();
                                          debugPrint('Say bye ');
                                        }
                                  });
                                  if (widget.code == '+90002') {
                                    // otp.match(value,context,widget.num);
                                  } else //otp.Matchotp(context, widget.num );
                                    debugPrint('the code is $value');
                                }
                              },
                              keyboardType: TextInputType.number,
                              // autoFocus: true,
                              codeLength: 6,
                            ),
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
                          PrimaryButton(
                              btnText: "Verify",
                              onPressed: () {
                                Get.to(() => FinishSignUp());
                              }),
                          SizedBox(
                            height: responsive(20, context),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              customFonts(
                                  context: context,
                                  text: "Didn't receive code? ",
                                  color: Colors.black,
                                  size: 13),
                              InkWell(
                                  onTap: () {
                                    if (widget.code == '+90002') {
                                      // otp.ReSendoTP(widget.num);
                                    } else {
                                      // SigninController.resendOtp(widget.num,widget.code);
                                    }
                                  },
                                  child: customFonts(
                                      text: "Resend Code",
                                      size: 13,
                                      color: AppColors.GlobelColor,
                                      isUnderLine: true,
                                      context: context)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
