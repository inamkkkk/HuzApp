
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/TextStyles/Color.dart';
import 'package:huz/TextStyles/styles.dart';
import 'package:huz/View/Booking/Widgets/CustomContainer.dart';
import 'package:huz/View/auth/controller/country_picker.dart';
import 'package:huz/View/eVisa/view/evisa_screen.dart';
import 'package:huz/Widgets/custom_app_bar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../TextStyles/AppFonts.dart';
import '../../../Widgets/custom_container.dart';

import '../../auth/view/input_fields.dart';
import '../../auth/view/sign_up_with_mobile_number/signup_with_number.dart';

class VisaRequirementScreen extends StatefulWidget {
  const VisaRequirementScreen({super.key});

  @override
  State<VisaRequirementScreen> createState() => _VisaRequirementScreenState();
}

class _VisaRequirementScreenState extends State<VisaRequirementScreen> {

  String nameValidator = "Name should not be empty";
  String emailValidator = "Email should not be empty & should be in correct form";
  String passValidator = "Number should not be empty";


  var country, flag, code, name, dialCode;

  var pMask = MaskTextInputFormatter(
      mask: '##########',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);


  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final TextEditingController _countryCodeController = TextEditingController();



  bool isNotValidateName = false;
  bool isNotValidateEmail = false;
  bool isNotValidatePass = false;



  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(
          left: responsive(25, context),
          right: responsive(25, context), top: responsive(25, context), bottom: responsive(25, context)),
      child: SingleChildScrollView(

            child: Consumer<CountryController>(
                builder: (context, value, child) {
                  if (value.called == false) {
                    value.loadCountryList(context);

                    flag = value.flag;
                    name = value.selectedCountry;
                    _countryCodeController.text = value.dialCode ?? '';
                  }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header tile
                    headerTile(),

                    verticalSpace(20, context),

                    // Visa Requirement Container
                    requirementContainer(),
                    verticalSpace(20, context),

                    // Talk to customer
                        Column(
                          children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(responsive(20, context)),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(responsive(5, context)),
                    border: Border.all(color: AppColors.GlobelColor.withOpacity(0.3)),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customFonts(
                          text: "Enter Contact Details",
                          size: 18,
                          fontWeight: FontWeight.bold,
                          context: context),
                      verticalSpace(20, context),
                      customFonts(
                          context: context,
                          text: 'Name',
                          size: 18,
                          color: AppColors.primaryBlackColor,
                          fontWeight: FontWeight.w500
                      ),
                      SizedBox(
                        height: responsive(10, context),
                      ),

                      textField(

                            // focusNode: null,
                              controller: nameController,
                              title: "Enter full name"),

                      verticalSpace(5, context),
                      isNotValidateName
                          ? validator(title: nameValidator, context: context)
                          : SizedBox(),
                      verticalSpace(20, context),
                      customFonts(
                          context: context,
                          text: 'Email',
                          size: 18,
                          color: AppColors.primaryBlackColor,
                          fontWeight: FontWeight.w500
                      ),
                      SizedBox(
                        height: responsive(10, context),
                      ),


                         textField(

                          // focusNode: null,
                            controller: nameController,
                            title: "Enter email address"),

                      verticalSpace(5, context),
                      isNotValidateEmail
                          ? validator(title: emailValidator, context: context)
                          : SizedBox(),
                      verticalSpace(20, context),
                      customFonts(
                          context: context,
                          text: 'Mobile number',
                          size: 18,
                          color: AppColors.primaryBlackColor,
                          fontWeight: FontWeight.w500
                      ),

                      SizedBox(
                        height: responsive(10, context),
                      ),
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
                                  contentPadding: EdgeInsets.only(top: responsive(8, context)),
                                  textAlignVertical: TextAlignVertical.center,

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
                                    // setState(() {
                                    //   if (value.length < 10) {
                                    //     isColored = true;
                                    //   } else
                                    //     isColored = false;
                                    // });
                                  },
                                  controller: numberController,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ), context: context,
                      ),
                      verticalSpace(5, context),
                      isNotValidatePass
                          ? validator(title: passValidator, context: context)
                          : SizedBox(),

                      verticalSpace(40, context),


                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: (){
                            if (nameController.text.isEmpty) {
                              setState(() {
                                isNotValidateName = true;
                              });
                              Future.delayed(Duration(seconds: 2), () {
                                setState(() {
                                  isNotValidateName = false;
                                });
                              });
                            }

                            if (emailController.text.isEmpty ||
                                !emailController.text.isEmail) {
                              setState(() {
                                isNotValidateEmail = true;
                              });
                              Future.delayed(Duration(seconds: 2), () {
                                setState(() {
                                  isNotValidateEmail = false;
                                });
                              });
                            }

                            if (numberController.text.length < 6) {
                              setState(() {
                                isNotValidatePass = true;
                              });

                              Future.delayed(Duration(seconds: 2), () {
                                setState(() {
                                  isNotValidatePass = false;
                                });
                              });
                            }
                            if(emailController.text.isNotEmpty && nameController.text.isNotEmpty && numberController.text.isNotEmpty){
                              Get.to(()=> EVisaScreen());
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.GlobelColor,
                                borderRadius: BorderRadius.circular(responsive(5, context))
                            ),
                            padding: EdgeInsets.symmetric(horizontal: responsive(70, context), vertical: responsive(15, context)),
                            child: customFonts(text: "Talk to our Visa expert",color: Colors.white,  size: 16, context: context),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                          ],
                        ),
                  ],
                );
              }
            ),
        ),
      );
  }



  Widget headerTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customFonts(text: "Apply for Umrah Visa Now!", size: 18, color: AppColors.GlobelColor, context: context),
        customFonts(text: "Umrah Visa Price", size: 16, context: context),
      ],
    );
  }

  Widget requirementContainer() {
    return Container(
      padding: EdgeInsets.all(responsive(20, context)),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(responsive(5, context)),
        border: Border.all(color: AppColors.GlobelColor.withOpacity(0.3)),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customFonts(text: "Umrah Visa", size: 24, fontWeight: FontWeight.bold, context: context),
                  horizontalSpace(20, context),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: responsive(8, context), vertical: responsive(1, context)),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(responsive(5, context)),
                        border: Border.all(color: AppColors.GlobelColor),
                      ),

                      child: customFonts(text: "eVisa", size: 14, color: AppColors.GlobelColor,context: context)),
                ],
              ),
              customFonts(text: "PKR 45,000", size: 24, context: context),
            ],
          ),
          verticalSpace(10, context),
          customFonts(
              text:
                  "In order to process your Visa, you will need the following documents. Process time will be 8 days.",
              size: 16,
              context: context),
          verticalSpace(20, context),
          tileContainer(
              icon: "passport",
              title: "Passport 1st and 2nd Page",
              subTitle:
                  "A passport should be valid for more than 6 months for visa processing"),
          verticalSpace(20, context),
          tileContainer(
              icon: "CNIC",
              title: "NIC / Smart NIC",
              subTitle: "Adult / Child / Infant"),
          verticalSpace(20, context),
          tileContainer(
              icon: "pictures",
              title: "Pictures",
              subTitle: "01 passport size picture with white background"),
          verticalSpace(20, context),
          tileContainer(
              icon: "contact",
              title: "Contact Information",
              subTitle: "Emergency contact number"),
          verticalSpace(20, context),
          tileContainer(
              icon: "reservation",
              title: "Reservations",
              subTitle: "Tentative flight and hotel reservation provided by HUZ"),
          verticalSpace(20, context),
          tileContainer(
              icon: "ffmaily",
              title: "Family Details",
              subTitle: "Applicants Father and Mother names"),
        ],
      ),
    );
  }

  Widget tileContainer({required icon, required title, required subTitle}) {
    return Row(
      children: [
        Container(
          height: responsive(65, context),
          width: responsive(65, context),
          padding: EdgeInsets.all(responsive(3, context)),
          decoration: BoxDecoration(
              color: AppColors.textColorBlack.withOpacity(0.05),
              shape: BoxShape.circle),
          child: SvgPicture.asset("assets/images/$icon.svg"),
        ),
        horizontalSpace(15, context),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customFonts(
                  text: title,
                  size: 16,
                  fontWeight: FontWeight.bold,
                  context: context),
              customFonts(
                  text: subTitle, size: 16, context: context, maxLines: 2),
            ],
          ),
        )
      ],
    );
  }

  Widget validator({required String title, required var context}) {
    return textPoppins(
        context: context, text: title, size: 12, color: Colors.red);
  }
  Widget textField(
      {required String title, required TextEditingController controller,  bool isPass = false}) {
    return Container(
      padding: EdgeInsets.only(
        left: responsive(20, context),
    ),
      height: responsive(52, context),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFFF5F5F5),
          border: Border.all(color: Color(0xFFEAEAEA))
      ),
      child: TextField(

        controller: controller,
        obscureText: isPass ? true : false,
        // validator: validator,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: responsive(5, context)),
            border: InputBorder.none,
            hintText: title,
            hintStyle: TextStyle(
                color: const Color(0xFFD2D2D2),
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: responsive(16, context))),
      ),
    );
  }



}




