
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:huz/View/auth/view/sign_up_with_mobile_number/signup_with_number.dart';
import 'package:huz/Widgets/primary_button.dart';
import 'package:provider/provider.dart';


import '../../../../Responsive/ResponsiveClass.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../TextStyles/styles.dart';
import '../../../../Widgets/animatedText/animatedText.dart';
import '../../../../Widgets/custom_container.dart';
import '../../../../Widgets/error_message_popup/error_message.dart';
import '../../controller/is_user_exist_controller.dart';
import '../user_location_screen/user_location_screen.dart';

class FinishSignUp extends StatefulWidget {
  var num;
  FinishSignUp({super.key,this.num});

  @override
  State<FinishSignUp> createState() => _FinishSignUpState();
}

class _FinishSignUpState extends State<FinishSignUp> {
  bool isToggle = false;
  var month, day, year;
  List<int> years = List.generate(500, (index) =>1950 + index);
  List days = [];
  bool isNotValidateName = false;
  bool isNotValidateEmail = false;
  bool isNotValidatePass = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();


  Widget bottomBar() {
    return Container(
        height: responsive(45, context),
        width: MediaQuery
            .sizeOf(context)
            .width,
        decoration: const BoxDecoration(
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
            text: "Agree and Continue",
            context: context,
            center: true,
            color: Colors.white,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
        ),
        body: Consumer<IsUserExitsController>(
            builder: (context, user, child) {

            return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      child: ErrorMesssage(
                        isVisible: user.siguperror,
                        message: user.signmessage,
                        onTap: () {
                          user.siguperror = false;
                          user.signmessage = "";
                          user.notifyListeners();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(responsive(20, context)),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(
                              height: responsive(30, context),
                            ),
                            customFonts(
                                context: context,
                                text: 'Finish Signing up',
                                size: 26,
                                color: Color(0xFF466262),
                                fontWeight: FontWeight.bold
                            ),
                            SizedBox(
                              height: responsive(5, context),
                            ),
                            customFonts(
                                context: context,
                                text: 'Please provide your name and email to complete your profile',
                                size: 15,
                                color: AppColors.primaryBlackColor,
                                fontWeight: FontWeight.w500
                            ),
                            SizedBox(
                              height: responsive(20, context),
                            ),
                            customFonts(
                                context: context,
                                text: 'Legal name',
                                size: 18,
                                color: AppColors.primaryBlackColor,
                                fontWeight: FontWeight.w500
                            ),
                            SizedBox(
                              height: responsive(10, context),
                            ),

                            customContainer(

                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: responsive(20, context),
                                  ),
                                  child: textField(title: "Type your legal name",
                                      // validator: (value){
                                      //   if (value == null || value.isEmpty || value.length <3) {
                                      //     return 'Please enter some text';
                                      //   }
                                      //   return null;
                                      // },
                                      controller: firstNameController,
                                      context: context),
                                ), context: context),
                            isNotValidateName
                                ? validator(title: nameValidator, context: context)
                                : SizedBox(),
                            SizedBox(
                              height: responsive(10, context),
                            ),

                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                style: TextStyle(
                                  color: AppColors.primaryBlackColor.withOpacity(0.8),
                                  fontSize: responsive(13, context),
                                  fontFamily: GoogleFonts
                                      .cairo(
                                      textStyle:
                                      const TextStyle(fontWeight: FontWeight.normal))
                                      .fontFamily,
                                  // fontFamily: AppFonts.poppinsMedium,
                                  fontWeight: FontWeight.normal,
                                ),
                                children: [
                                  const TextSpan(
                                    text:
                                    "Make sure this match the name on your government-issued ID. If you go by another name, you can add a ",
                                  ),
                                  TextSpan(
                                    text: "preferred first name. ",
                                    style:  TextStyle(
                                        fontFamily: GoogleFonts
                                            .cairo(
                                            textStyle:
                                            const TextStyle(fontWeight: FontWeight.bold))
                                            .fontFamily,
                                      fontSize: responsive(13, context),
                                      color: AppColors.GlobelColor,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => print("Clicked!"),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: responsive(20, context),
                            ),
                            SizedBox(
                              height: responsive(10, context),
                            ),

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

                            customContainer(

                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: responsive(20, context),
                                  ),
                                  child: textField(title: "Type your Email",
                                      // validator: (value){
                                      //   if (value == null || value.isEmpty || value.length <3) {
                                      //     return 'Please enter some text';
                                      //   }
                                      //   return null;
                                      // },
                                      controller: emailController,
                                      context: context),
                                ), context: context),
                            isNotValidateEmail
                                ? validator(title: emailValidator, context: context)
                                : SizedBox(),

                            SizedBox(
                              height: responsive(24, context),
                            ),

                            user.isSigupApi?LoadingDots(isfrombooking:true):PrimaryButton(btnText: "Continue",  onPressed: () {
                              if (firstNameController.text.isEmpty) {
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

                              if (passwordController.text.length < 6) {
                                setState(() {
                                  isNotValidatePass = true;
                                });

                                Future.delayed(Duration(seconds: 2), () {
                                  setState(() {
                                    isNotValidatePass = false;
                                  });
                                });
                              }

                    if(emailController.text.isNotEmpty && firstNameController.text.isNotEmpty){
                    user.CreateMember(name: firstNameController.text,email: emailController.text).then((value){
                      if(value == true)
                         Get.off(UserLocationScreen(type:"Company"));
                    });
                    }
                            },


                            )

                      ]))),
                  ],
                ));
          }
        ));}

      //     child: bottomBar()),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: appBarTitle(context: context, text: 'Sigup'),
      //   elevation: 2,
      //   backgroundColor: Colors.white,
      // ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: EdgeInsets.all(responsive(20, context)),
      //     child: Form(
      //       key: _formkey,
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           headline(text: "Finish Signing up", context: context),
      //           SizedBox(
      //             height: responsive(20, context),
      //           ),
      //           titleTextField(text: "Legal name", context: context),
      //           SizedBox(
      //             height: responsive(10, context),
      //           ),
      //           customContainer(
      //               height: 104,
      //               child: Column(
      //
      //                 children: [
      //                   Expanded(
      //                     flex: 2,
      //                     child: customContainer(
      //                       padding: EdgeInsets.symmetric(horizontal: responsive(10, context)),
      //                         child: DropdownButton(
      //                           isExpanded: true,
      //                       underline: SizedBox(),
      //                       value: month,
      //
      //
      //                       hint: Text("Month", style: TextStyle(color: Colors.black38, fontSize: responsive(13, context)),),
      //                       onChanged: (value){
      //                         setState(() {
      //                           month = value;
      //                         });
      //                       },
      //                       items: months.map((e) =>
      //                           DropdownMenuItem(
      //                               value: e,
      //                               child: Text(e))).toList(),)),
      //                   ),
      //                   SizedBox(width: responsive(10, context),),
      //                   Expanded(
      //                     child: customContainer(
      //                         padding: EdgeInsets.symmetric(horizontal: responsive(10, context)),
      //                         child: DropdownButton(
      //                           isExpanded: true,
      //                           underline: SizedBox(),
      //                           value: day,
      //                             hint: Text("Day", style: TextStyle(color: Colors.black38, fontSize: responsive(13, context)),),
      //                           onChanged: (value){
      //                             setState(() {
      //                               day = value!;
      //                             });
      //                           },
      //
      //
      //                           items: List.generate(31, (index) {
      //                             int dayValue = index + 1;
      //                            return DropdownMenuItem(
      //                                 value: dayValue,
      //                                 child: Text(dayValue.toString()));
      //
      //                           }))),
      //                   ),
      //                   SizedBox(width: responsive(10, context),),
      //                   Expanded(
      //                     child: customContainer(
      //                         padding: EdgeInsets.symmetric(horizontal: responsive(10, context)),
      //                         child: DropdownButton<int>(
      //                           isExpanded: true,
      //                           underline: SizedBox(),
      //                           value: year,
      //                           hint: Text("Year", style: TextStyle(color: Colors.black38, fontSize: responsive(13, context)),),
      //                           onChanged: (value) {
      //                             setState(() {
      //                               year = value!;
      //                             });
      //                           },
      //
      //                           items: years.map((yearValue) {
      //                             return DropdownMenuItem<int>(
      //                               value: yearValue,
      //                               child: Text(yearValue.toString()),
      //                             );
      //                           }).toList(),
      //                         )),
      //                   ),
      //                 ],
      //               ),
      //               // Container(
      //               //   alignment: Alignment.center,
      //               //   padding: EdgeInsets.symmetric(vertical: responsive(2, context)),
      //               //   height: responsive(60, context),
      //               //  child: DropdownDatePicker(
      //               //
      //               //    width: responsive(6, context),
      //               //    dateformatorder: OrderFormat.YDM,
      //               //    // default is myd
      //               //    inputDecoration: InputDecoration(
      //               //        focusedBorder:  OutlineInputBorder(
      //               //          borderSide: BorderSide(color: AppColors.GlobelColor, width: 1.0),
      //               //        ),
      //               //        enabledBorder: const OutlineInputBorder(
      //               //          borderSide: BorderSide(color: Colors.grey, width: 1.0),
      //               //        ),
      //               //        border: OutlineInputBorder(
      //               //            borderRadius: BorderRadius.circular(responsive(5, context)))), // optional
      //               //    isDropdownHideUnderline: true, // optional
      //               //    isFormValidator: true, // optional
      //               //    startYear: 1900, // optional
      //               //    endYear: 2020, // optional
      //               //    // optional
      //               //    // selectedDay: 14, // optional
      //               //    selectedMonth: 10, // optional
      //               //    selectedYear: 1993, // optional
      //               //    onChangedDay: (value) => print('onChangedDay: $value'),
      //               //    onChangedMonth: (value) => print('onChangedMonth: $value'),
      //               //    onChangedYear: (value) => print('onChangedYear: $value'),
      //               //    //boxDecoration: BoxDecoration(
      //               //    // border: Border.all(color: Colors.grey, width: 1.0)), // optional
      //               //    // showDay: false,// optional
      //               //    // dayFlex: 2,// optional
      //               //    // locale: "zh_CN",// optional
      //               //    // hintDay: 'Day', // optional
      //               //    // hintMonth: 'Month', // optional
      //               //    // hintYear: 'Year', // optional
      //               //    // hintTextStyle: TextStyle(color: Colors.grey), // optional
      //               //  ),
      //               // ),
      //               // Pick Date picker
      //               // GestureDetector(
      //               //   onTap: (){
      //               //     print("pressed");
      //               //     showDatePicker(context: context, firstDate: DateTime(2024), lastDate: DateTime(2025));
      //               //
      //               //   },
      //               //   child: customContainer(
      //               //     width: size.width,
      //               //       alignment: Alignment.centerLeft,
      //               //       child: Padding(
      //               //         padding:  EdgeInsets.only(left: responsive(10, context)),
      //               //         child: taglineText(text: "Date of birth", context: context, color: AppColors.grayboxcolor),
      //               //       )),
      //               // ),
      //               SizedBox(
      //                 height: responsive(10, context),
      //               ),
      //               taglineText(
      //                   text:
      //                   "To sign up, you need to be at least 18. Other people who use HUZ won’t see your date of birth.",
      //                   context: context,
      //                   maxLines: 2),
      //               SizedBox(
      //                 height: responsive(20, context),
      //               ),
      //               titleTextField(text: "Email", context: context),
      //               SizedBox(
      //                 height: responsive(10, context),
      //               ),
      //               // Pick Date picker
      //               customContainer(
      //                 child: Padding(
      //                   padding: EdgeInsets.all(responsive(10, context)),
      //                   child: textField(title: "Email",
      //                       controller: emailController,
      //                       context: context),
      //                 ),
      //               ),
      //               isNotValidateEmail
      //                   ? validator(title: emailValidator)
      //                   : SizedBox(),
      //               SizedBox(
      //                 height: responsive(10, context),
      //               ),
      //               taglineText(
      //                   text: "We’ll email you a reservation confirmation.",
      //                   context: context,
      //                   maxLines: 2),
      //               SizedBox(
      //                 height: responsive(20, context),
      //               ),
      //               titleTextField(text: "Password", context: context),
      //               SizedBox(
      //                 height: responsive(10, context),
      //               ),
      //
      //               customContainer(
      //                   child: Padding(
      //                     padding: EdgeInsets.all(responsive(10, context)),
      //                     child: textField(title: "Password",
      //                         isPass: true
      //                         ,
      //                         controller: passwordController,
      //                         context: context),
      //                   )),
      //               isNotValidatePass
      //                   ? validator(title: passValidator)
      //                   : SizedBox(),
      //               SizedBox(
      //                 height: responsive(10, context),
      //               ),
      //
      //               // Agree & continue
      //               RichText(
      //                 text: TextSpan(
      //                   style: TextStyle(
      //                     color: AppColors.black,
      //                     fontSize: responsive(13, context),
      //                     fontFamily: GoogleFonts
      //                         .cairo(
      //                         textStyle:
      //                         const TextStyle(fontWeight: FontWeight.normal))
      //                         .fontFamily,
      //                     // fontFamily: AppFonts.poppinsMedium,
      //                     fontWeight: FontWeight.normal,
      //                   ),
      //                   children: [
      //                     const TextSpan(
      //                       text: "By selecting ",
      //                     ),
      //                     TextSpan(
      //                       text: "Agree and continue,",
      //                       style: const TextStyle(
      //                           decoration: TextDecoration.underline,
      //                           fontWeight: FontWeight.bold),
      //                       recognizer: TapGestureRecognizer()
      //                         ..onTap = () => print("Clicked!"),
      //                     ),
      //                     const TextSpan(
      //                       text: " I agree to ",
      //                     ),
      //                     TextSpan(
      //                       text:
      //                       "Huz’s Terms of Services. Payments Terms of Services,",
      //                       style: const TextStyle(
      //                         decoration: TextDecoration.underline,
      //                       ),
      //                       recognizer: TapGestureRecognizer()
      //                         ..onTap = () => print("Clicked!"),
      //                     ),
      //                     const TextSpan(
      //                       text: " and ",
      //                     ),
      //                     TextSpan(
      //                       text: "Nondiscrimination Policy",
      //                       style: const TextStyle(
      //                         decoration: TextDecoration.underline,
      //                       ),
      //                       recognizer: TapGestureRecognizer()
      //                         ..onTap = () => print("Clicked!"),
      //                     ),
      //                     const TextSpan(
      //                       text: " and acknowledge the ",
      //                     ),
      //                     TextSpan(
      //                       text: "Privacy Policy.",
      //                       style: const TextStyle(
      //                         decoration: TextDecoration.underline,
      //                       ),
      //                       recognizer: TapGestureRecognizer()
      //                         ..onTap = () => print("Clicked!"),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: responsive(5, context),
      //               ),
      //               taglineText(
      //                   text:
      //                   "Huz will send you members-only deals, inspiration, marketing emails, and push notification. You can opt out of receiving these at any time in your account settings or directly from the marketing notification.",
      //                   context: context,
      //                   maxLines: 3),
      //               SizedBox(
      //                 height: responsive(10, context),
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   headlineSub(
      //                       text:
      //                       "I don’t want to receive marketing messages from HUZ.",
      //                       context: context), //custom toggle button
      //                   GestureDetector(
      //                     onTap: () {
      //                       setState(() {
      //                         isToggle = !isToggle;
      //                       });
      //                     },
      //                     child: Container(
      //                       width: responsive(40, context),
      //                       alignment: isToggle
      //                           ? Alignment.centerRight
      //                           : Alignment.centerLeft,
      //                       padding: EdgeInsets.all(responsive(2, context)),
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(50),
      //                         color: const Color(0xFFB5E0D4),
      //                       ),
      //                       child: Container(
      //                         height: responsive(23, context),
      //                         width: responsive(23, context),
      //                         decoration: const BoxDecoration(
      //                             shape: BoxShape.circle, color: Colors.white),
      //                       ),
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       )));
  // }

  Widget validator({required String title, required var context}) {
    return textPoppins(
        context: context, text: title, size: 12, color: Colors.red);
  }

  TextField textField(
      {required String title, required TextEditingController controller, required BuildContext context, bool isPass = false}) {
    return TextField(

      controller: controller,
      obscureText: isPass ? true : false,
      // validator: validator,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: responsive(5, context)),
          border: InputBorder.none,
          hintText: title,
          hintStyle: TextStyle(
              color: Color(0xFFD2D2D2),
              fontFamily: GoogleFonts.cairo().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: responsive(16, context))),
    );
  }

  // Widget customContainer(
  //     {double height = 52, required Widget child, double? width, Alignment? alignment, EdgeInsetsGeometry? padding}) {
  //   return Container(
  //     alignment: alignment,
  //     padding: padding,
  //     height: responsive(height, context),
  //     width: width,
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         color: Colors.grey.shade300,
  //         width: 2.0,
  //       ),
  //       borderRadius: BorderRadius.circular(responsive(5, context)),
  //     ),
  //     child: child,
  //   );
  // }

  Future<DateTime?> showDatePicker({
    required BuildContext context,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? initialDate,

    DateTime? currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    Locale? locale,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TextDirection? textDirection,
    TransitionBuilder? builder,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    TextInputType? keyboardType,
    Offset? anchorPoint,
    final ValueChanged<DatePickerEntryMode>? onDatePickerModeChange,
    final Icon? switchToInputEntryModeIcon,
    final Icon? switchToCalendarEntryModeIcon,
  }) async {
    initialDate = initialDate ==

      null ? null : DateUtils.dateOnly(initialDate);
    firstDate = DateUtils.dateOnly(firstDate);
    lastDate = DateUtils.dateOnly(lastDate);
    assert(
    !lastDate.isBefore(firstDate),
    'lastDate $lastDate must be on or after firstDate $firstDate.',
    );
    assert(
    initialDate == null || !initialDate.isBefore(firstDate),
    'initialDate $initialDate must be on or after firstDate $firstDate.',
    );
    assert(
    initialDate == null || !initialDate.isAfter(lastDate),
    'initialDate $initialDate must be on or before lastDate $lastDate.',
    );
    assert(
    selectableDayPredicate == null || initialDate == null ||
        selectableDayPredicate(initialDate),
    'Provided initialDate $initialDate must satisfy provided selectableDayPredicate.',
    );
    assert(debugCheckHasMaterialLocalizations(context));

    Widget dialog = DatePickerDialog(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: currentDate,
      initialEntryMode: initialEntryMode,
      selectableDayPredicate: selectableDayPredicate,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
      initialCalendarMode: initialDatePickerMode,
      errorFormatText: errorFormatText,
      errorInvalidText: errorInvalidText,
      fieldHintText: fieldHintText,
      fieldLabelText: fieldLabelText,
      keyboardType: keyboardType,
      onDatePickerModeChange: onDatePickerModeChange,
      switchToInputEntryModeIcon: switchToInputEntryModeIcon,
      switchToCalendarEntryModeIcon: switchToCalendarEntryModeIcon,
    );

    if (textDirection != null) {
      dialog = Directionality(
        textDirection: textDirection,
        child: dialog,
      );
    }

    if (locale != null) {
      dialog = Localizations.override(
        context: context,
        locale: locale,
        child: dialog,
      );
    }

    return showDialog<DateTime>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: (BuildContext context) {
        return builder == null ? dialog : builder(context, dialog);
      },
      anchorPoint: anchorPoint,
    );
  }
}

String nameValidator = "Name should not be empty";
String emailValidator = "Email should not be empty & should be in correct form";
String passValidator = "Password should not be empty";


List months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sept",
  "Oct",
  "Nov",
  "Dec",
];
