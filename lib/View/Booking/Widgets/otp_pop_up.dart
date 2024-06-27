import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:huz/View/Home/View/home_screen.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/AppFonts.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';
import '../../Home/View/Home.dart';

class OtpPopUp extends StatefulWidget {
  var currentCode, code, num;
   OtpPopUp({super.key, required this.currentCode, required this.code});

  @override
  State<OtpPopUp> createState() => _OtpPopUpState();
}

class _OtpPopUpState extends State<OtpPopUp> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: responsive(420, context),
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: responsive(20, context), vertical: responsive(20, context)),
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(responsive(10, context)),
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
              color: Color(0xFF4B465C)),
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
                  color: Color(0xFF4B465C)),
              Text(
                '${widget.num}',
                style: TextStyle(
                    fontFamily: AppFonts.poppinsSemiBold,
                    color: Color(0xFF4B465C),
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
                  const Color(0xFFDEDDDD),
                  const Color(0xFFDEDDDD)),
            ),
            currentCode: widget.currentCode,
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
                widget.currentCode = value!;
              });
              // if (value?.length == 6) {
              //   setState(() {
              //     widget.currentCode = value!;
              //   });
              //   // print("number is${widget.num}");
              //   // std.getSchools('${widget.num}');
              //
              //   otp.Matchotp(
              //       context, widget.num, widget.currentCode);
              //   if (widget.code == '+90002') {
              //     // otp.match(value,context,widget.num);
              //   } else //otp.Matchotp(context, widget.num );
              //     debugPrint('the code is $value');
              // }
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
            mainAxisAlignment: MainAxisAlignment.center
            ,
            children: [
              textPoppins(
                  context: context,
                  text: "Didn't receive code? ",
                  size: 12),
              InkWell(
                  onTap: () {
                    if (widget.code == '+90002') {
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
          SizedBox(height: responsive(20, context),),
          InkWell(
            onTap: () {
            print('iname with back');
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
              child: textPoppins(context: context, text: "inam", size: 15, color: Colors.white, fontFamily: AppFonts.poppinsBold),
            ),),
        ],
      ),
    );
  }
}
