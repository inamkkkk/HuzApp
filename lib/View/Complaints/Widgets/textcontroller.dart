import 'package:flutter/material.dart';

import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/AppFonts.dart';
import '../../../TextStyles/Color.dart';


class TextFieldMasked extends StatelessWidget {
  TextFieldMasked({Key? key,
    this.onchange,
    this.myController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.onValidator,
    required this.keyBoardType,
    this.onTap,
    required this.hint,
    required this.obscureText,
    this.enable = true,
    this.autoFocus = false,
    this.inputFormatter,
    this.readOnly = false,
    this.isSuffixAvailable = false,
    this.isValidated= true,
    this.fillColor = Colors.white,
  }) : super(key: key);
  var onchange;
  var myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator onValidator;
  final bool readOnly;
  final TextInputType keyBoardType;
  final String hint;
  final bool obscureText;
  VoidCallback? onTap;
  final bool enable, autoFocus;
  bool isSuffixAvailable;
  final inputFormatter;
  bool isValidated;
  Color fillColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:responsive(45, context),
      child: Center(
        child: Align(
          alignment: Alignment.center,
          child: TextFormField(
            onChanged: onchange,
            controller: myController,
            focusNode: focusNode,
            onTap: onTap,
            onFieldSubmitted: onFieldSubmittedValue,
            inputFormatters: inputFormatter,
            validator: onValidator,
            keyboardType: keyBoardType,
            obscureText: obscureText,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.start,
            readOnly: readOnly,
            style: TextStyle(fontFamily: AppFonts.poppinsMedium, fontSize:responsive(15, context)),
            enabled: enable,
            cursorColor:  AppColors.GlobelColor,
            decoration: InputDecoration(
              contentPadding:  EdgeInsets.only( left:responsive(15, context)),
              hintText: hint,
              fillColor: fillColor,
              filled: true,
              suffixIcon: Padding(
                padding:  EdgeInsets.only(top:responsive(15, context)),
                child: Icon(Icons.keyboard_arrow_down_outlined, color: isSuffixAvailable == true ? Colors.black54: Colors.transparent,size:responsive(25, context),),
              ),
              hintStyle: TextStyle(fontFamily: AppFonts.poppinsMedium, fontSize:responsive(15, context), color: Color(0xffB1B1B1)),
              border:   const OutlineInputBorder(
                borderSide: BorderSide(
                  color:  Color(0xffB1B1B1),
                  width: 2,
                ),
                borderRadius:BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
              ),

              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color:  isValidated == true ? const Color(0xffB3CDC6) : Colors.red,
                  width: 2,

                ),
                borderRadius:const BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
              ),


              errorBorder:const  UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,

                ),
                borderRadius:BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
              ),


              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color:  isValidated == true ? const Color(0xffAAAAAA) : Colors.red,
                  width: 2,
                ),
                borderRadius:const BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
