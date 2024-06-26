import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../../Loading/loading.dart';
import '../../../../Responsive/ResponsiveClass.dart';
import '../../../../TextStyles/AppFonts.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../TextStyles/styles.dart';
import '../../../../Widgets/error_message_popup/error_message.dart';
import '../../../../Widgets/primary_button.dart';
import '../../controller/country_picker.dart';
import '../../controller/is_user_exist_controller.dart';

import '../../controller/otp_message_controller.dart';
import '../../model/country_model/country_model.dart';
import '../input_fields.dart';
import '../verify_otp_screen/verify_otp_screen.dart';

class SignUpWithMobile extends StatefulWidget {
  const SignUpWithMobile({super.key});

  @override
  State<SignUpWithMobile> createState() => _SignUpWithMobileState();
}

class _SignUpWithMobileState extends State<SignUpWithMobile> {
  var pMask = MaskTextInputFormatter(
      mask: '##########',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryNameController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  var isColored = true;

  var country, flag, code, name, dialCode;

  @override
  void initState() {
// getvalues(context);

    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _countryCodeController.dispose();
    _countryNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countryController =
        Provider.of<CountryController>(context, listen: false);
    return Consumer3<CountryController, IsUserExitsController,OtpMessageControllerss>(
        builder: (context, value, isUser, otpMessage, child) {
      if (value.called == false) {
        value.loadCountryList(context);

        flag = value.flag;
        name = value.selectedCountry;
        _countryCodeController.text = value.dialCode ?? '';
      }

      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: responsive(20, context),),
                SizedBox(
                  child: ErrorMesssage(isVisible: isUser.vissible, message: isUser.message,onTap: () {
                    isUser?.vissible = false;
                    isUser.notifyListeners();
                  }
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 40, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: responsive(30, context)),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textPoppins(
                                context: context,
                                text: 'Enter your mobile number',
                                size: 20,
                                fontFamily: AppFonts.poppinsBold),
                            SizedBox(
                              height: responsive(5, context),
                            ),
                            textPoppins(
                                context: context,
                                text: 'We will send you a confirmation code',
                                size: 12),
                            SizedBox(
                              height: responsive(5, context),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: responsive(47, context)),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DropdownButton(
                                    underline: Container(
                                      width: responsive(313, context),
                                      color: AppColors.GlobelColor,
                                      height: responsive(2, context),
                                    ),
                                    // decoration: InputDecoration(
                                    //     labelText: 'Country'
                                    // ),
                                    hint: flag == null
                                        ? Text(
                                            'Select Country',
                                            style: TextStyle(
                                              fontSize: responsive(15, context),
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                '$flag  ',
                                                style: TextStyle(
                                                  fontSize:
                                                      responsive(17, context),
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                '$name',
                                                style: TextStyle(
                                                  fontSize:
                                                      responsive(15, context),
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),



                                    items: value.countries.map((country) {
                                      return DropdownMenuItem<CountryPicker>(
                                        value: country,
                                        child: Text(
                                            '${country.flag} ${country.name!}'),
                                      );
                                    }).toList(),

                                    onChanged: (CountryPicker? value) {
                                      // setState(() {

                                      flag = value!.flag;
                                      code = value.dialCode;
                                      name = value.name;
                                      _countryCodeController.text = code;
                                      setState(() {
                                        print(_countryCodeController.text);
                                      });

                                      countryController.selectCountry(
                                          value.name, value.code, value.flag);
                                      // });
                                    },

                                    // value: '${countryController.flag} ${countryController.selectedCountry} ',
                                    isExpanded: true,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: responsive(60, context),
                                        child: NumberInputTextField(
                                          textAlign: TextAlign.right,
                                          controller: _countryCodeController,
                                          // initialvalue: "+92",
                                          readOnly: true,
                                        ),
                                      ),
                                      SizedBox(
                                        width: responsive(20, context),
                                      ),
                                      Expanded(
                                        child: NumberInputTextField(
                                          keyboardType: TextInputType.number,
                                          formater: [pMask],
                                          onChanged: (value) {
                                            setState(() {
                                              if (value.length < 10) {
                                                isColored = true;
                                              } else
                                                isColored = false;
                                            });
                                          },
                                          controller: _phoneNumberController,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: responsive(83, context),
                            ),
                            Stack(
                              children: [
                                PrimaryButton(
                                  btnText: 'NEXT',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
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
                                                    'You entered the phone number:',
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
                                                    '${_countryCodeController.text ?? "+92"} ${_phoneNumberController.text}',
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
                                                    'Is this OK, or would you like to edit the number?',
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
                                                        text: 'EDIT',
                                                      ),
                                                      CustomTextButton(
                                                          text: 'OK',
                                                          onPressed: () {
                                                            Loading();
                                                            isUser
                                                                .checkUserExistence(
                                                                    _phoneNumberController
                                                                        .text,
                                                                    code,
                                                                    context)
                                                                .then((value) {

                                                            endLoading();
                                                            if(isUser.isUser!=null)
                                                              otpMessage.getOtpMessage(context, "${code}${_phoneNumberController.text}", code);
                                                                }
                                                                );
                                                            Get.back();
                                                            // schools.getSchools('3455008061');

                                                            // if(_countryCodeController.text == '+90002'){
                                                            //   // otp.SendoTP('${_countryCodeController.text}${_phoneNumberController.text}','${_countryCodeController.text}');
                                                            // }else  //SigninController.signInWithPhoneNumber('${_countryCodeController.text}${_phoneNumberController.text}','${_countryCodeController.text}');
                                                            // Navigator.pop(context);
                                                          }


                                                          ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                Visibility(
                                    visible: isColored,
                                    child: Container(
                                      color: Colors.white.withOpacity(0.5),
                                      height: responsive(44.03, context),
                                      width: responsive(296, context),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomTextButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,

        color: Colors.transparent,
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.GlobelColor,
            fontFamily: AppFonts.poppinsBold,
            fontSize: responsive(13, context),
          ),
        ),
      ),
    );
  }
}
