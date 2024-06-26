import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huz/TextStyles/AppFonts.dart';
import 'package:huz/View/auth/view/sign_up_with_mobile_number/signup_with_mobile_num.dart';
import 'package:huz/Widgets/custom_app_bar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../../Loading/loading.dart';
import '../../../../Responsive/ResponsiveClass.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../TextStyles/styles.dart';
import '../../../../Widgets/custom_container.dart';
import '../../../../Widgets/error_message_popup/error_message.dart';
import '../../../../Widgets/primary_button.dart';
import '../../controller/country_picker.dart';
import '../../controller/is_user_exist_controller.dart';
import '../../controller/otp_message_controller.dart';
import '../../model/country_model/country_model.dart';
import '../input_fields.dart';
import '../verify_otp_screen/verify_otp_screen.dart';

class SignUpWithNumber extends StatefulWidget {
  const SignUpWithNumber({super.key});

  @override
  State<SignUpWithNumber> createState() => _SignUpWithNumberState();
}

class _SignUpWithNumberState extends State<SignUpWithNumber> {

  bool isDropDownOpen = false;

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

          }
          _countryCodeController.text = value.dialCode ??"+92";
          return Scaffold(
            appBar: isUser.userfrombooking ? AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Padding(
                  padding:  EdgeInsets.all(responsive(20, context)),
                  child: SvgPicture.asset("images/arrow_back.svg", height: responsive(18, context), width: responsive(27.22, context),),
                ),
              ) ,
            ) : null,
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

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: responsive(140, context)),
                        customFonts(
                            context: context,
                            text: 'Enter your mobile number',
                            size: 26,
                          color: Color(0xFF466262),
                          fontWeight: FontWeight.bold
                        ),
                        SizedBox(
                          height: responsive(5, context),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: responsive(75, context) ),
                          child: customFonts(
                            center: true,
                              context: context,
                              text: 'Enter a valid mobile phone number. We will us it to send you a confirmation code.',
                              size: 14),
                        ),
                        SizedBox(
                          height: responsive(20, context),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive(20, context)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),


                              // DropdownButton(
                              //   underline: Container(
                              //     width: responsive(313, context),
                              //     color: AppColors.GlobelColor,
                              //     height: responsive(2, context),
                              //   ),
                              //   // decoration: InputDecoration(
                              //   //     labelText: 'Country'
                              //   // ),
                              //   hint: flag == null
                              //       ? Text(
                              //     'Select Country',
                              //     style: TextStyle(
                              //       fontSize: responsive(15, context),
                              //       color: Colors.black,
                              //       fontWeight: FontWeight.normal,
                              //     ),
                              //   )
                              //       : Row(
                              //     children: [
                              //       Text(
                              //         '$flag  ',
                              //         style: TextStyle(
                              //           fontSize:
                              //           responsive(17, context),
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.normal,
                              //         ),
                              //       ),
                              //       Text(
                              //         '$name',
                              //         style: TextStyle(
                              //           fontSize:
                              //           responsive(15, context),
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.normal,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              //
                              //
                              //
                              //   items: value.countries.map((country) {
                              //     return DropdownMenuItem<CountryPicker>(
                              //       value: country,
                              //       child: Text(
                              //           '${country.flag} ${country.name!}'),
                              //     );
                              //   }).toList(),
                              //
                              //   onChanged: (CountryPicker? value) {
                              //     // setState(() {
                              //
                              //     flag = value!.flag;
                              //     code = value.dialCode;
                              //     name = value.name;
                              //     _countryCodeController.text = code;
                              //     setState(() {
                              //       print(_countryCodeController.text);
                              //     });
                              //
                              //     countryController.selectCountry(
                              //         value.name, value.code, value.flag);
                              //     // });
                              //   },
                              //
                              //   // value: '${countryController.flag} ${countryController.selectedCountry} ',
                              //   isExpanded: true,
                              // ),




                              customContainer(
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: responsive(15, context)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      SizedBox(

                                       width: responsive(60, context),
                                       height: responsive(50, context),
                                       child: NumberInputTextField(
                                         onTap: (){
                                           print('inam');
                                           showModalBottomSheet(
                                             context: context,
                                             builder: (BuildContext context) {
                                               return CountryPicker(
                                                 onSelectCountry: (String country) {
                                                   setState(() {
                                                     _countryCodeController.text = country;
                                                   });
                                                   Navigator.pop(context);
                                                 },
                                               );
                                             },
                                           );
                                         },

                                         hintColor: AppColors.primaryBlackColor,
                                         hintText: "+92",
                                         textAlign: TextAlign.center,
                                         controller: _countryCodeController,
                                         // initialvalue: "+921",
                                         readOnly: true,
                                       ),
                                                                            ),
                                      Padding(
                                        padding:  EdgeInsets.symmetric(vertical: responsive(10, context), horizontal: responsive(15, context)),
                                        child: Container(
                                          color: Color(0xFFD2D2D2),
                                          width: responsive(2, context),

                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: NumberInputTextField(
                                          hintText: "000 000 00",
                                          hintColor: Color(0xFFD2D2D2),
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
                                ), context: context,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: responsive(19, context),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: responsive(20, context)),
                          child: Stack(
                            children: [
                              PrimaryButton(
                                btnText: 'Agree and continue',
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
                                           padding: EdgeInsets.only(top: responsive(40, context)),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                                      color: Colors.black),
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
                                                              _countryCodeController.text??'+92',
                                                              context)
                                                              .then((value) {
                                                                isUser.phonenumber= '${_countryCodeController.text??'+92'}${ _phoneNumberController.text}';
                                                              Navigator.pop(context);


                                                            otpMessage.getOtpMessage(context, "${_countryCodeController.text??"+92"}${_phoneNumberController.text}", _countryCodeController.text).then((value) => endLoading());
                                                            // if(isUser.isUser!=null)
                                                            //   otpMessage.getOtpMessage(context, "${code}${_phoneNumberController.text}", code);
                                                          }
                                                          );
                                                          // Get.back();
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
                                    height: responsive(52, context),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: responsive(20, context),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: responsive(20, context)),
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                            children: [
                              TextSpan(
                                text: "By selecting ",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.87),
                                  fontSize: 12,
                                  fontFamily: GoogleFonts.cairo().fontFamily,
                                )
                              ),
                              TextSpan(
                                  text: "Agree and continue,",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.87),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    fontFamily: GoogleFonts.cairo().fontFamily,
                                  )
                              ),
                              TextSpan(
                                  text: " I agree to Huz's ",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.87),
                                    fontSize: 12,
                                    fontFamily: GoogleFonts.cairo().fontFamily,
                                  )
                              ),
                              TextSpan(
                                  text: "Terms of Services. Payments Terms of Services,",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.87),
                                    fontSize: 12,
                          
                                    decoration: TextDecoration.underline,
                                    fontFamily: GoogleFonts.cairo().fontFamily,
                                  )
                              ),
                              TextSpan(
                                  text: " and ",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.87),
                                    fontSize: 12,
                                    fontFamily: GoogleFonts.cairo().fontFamily,
                                  )
                              ),
                              TextSpan(
                                  text: "Nondiscrimination Policy",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.87),
                                    fontSize: 12,
                          
                                    decoration: TextDecoration.underline,
                                    fontFamily: GoogleFonts.cairo().fontFamily,
                                  )
                              ),
                              TextSpan(
                                  text: " and acknowledge the ",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.87),
                                    fontSize: 12,
                                    fontFamily: GoogleFonts.cairo().fontFamily,
                                  )
                              ),
                              TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.87),
                                    fontSize: 12,
                          
                                    decoration: TextDecoration.underline,
                                    fontFamily: GoogleFonts.cairo().fontFamily,
                                  )
                              ),
                            ]
                          )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

 

}


class CountryPicker extends StatelessWidget {
  final Function(String) onSelectCountry;

  CountryPicker({required this.onSelectCountry});


  @override
  Widget build(BuildContext context) {
    return Consumer3<CountryController, IsUserExitsController,OtpMessageControllerss>(
        builder: (context, value, isUser, otpMessage, child) {
          if (value.called == false) {
            value.loadCountryList(context);

          }


        return Container(
          height: responsive(400, context),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.all(responsive(04, context)),
                child: Container(
                  width: responsive(40, context),
                  height: responsive(08, context),
                
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(responsive(05, context))),
                    color: AppColors.black.withOpacity(0.5),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: customFonts(
                    context: context,
                    text: 'Select Country',
                    size: 16,
                    color: Color(0xFF466262),
                    fontWeight: FontWeight.bold
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: value.countries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                       onSelectCountry(value.countries[index].dialCode);
                        },


                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: responsive(20, context)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                customFonts(
                                    context: context,
                                    text: '${value.countries[index].flag}',
                                    size: 16,
                                    color: Color(0xFF466262),
                                    fontWeight: FontWeight.bold
                                ),
                                SizedBox(width: responsive(30, context),),
                                customFonts(
                                    context: context,
                                    text: '${value.countries[index].name}',
                                    size: 16,
                                    color: Color(0xFF466262),
                                    fontWeight: FontWeight.w600
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios,size: responsive(10, context),)
                              ],
                            ),

                            Container(
                            height: responsive(1, context),
                              width: MediaQuery.sizeOf(context).width,
                              color: AppColors.black.withOpacity(0.1),

                            ),
                            SizedBox(height: responsive(10, context),),
                          ],
                        ),
                      ),
                    );
                    // ListTile(
                    // 
                    //   leading: 
                    //   title: 
                    //   onTap: () {
                    //     // onSelectCountry(countries[index]);
                    //   },
                    // );
                  },
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}