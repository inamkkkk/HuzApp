
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/AppFonts.dart';
import '../../../TextStyles/Color.dart';










class NumberInputTextField extends StatelessWidget {
  NumberInputTextField({
    super.key,
    this.controller,
    this.hintText,
    this.hintColor,
    this.readOnly,
    this.textAlign,
    this.keyboardType,
    this.prefixText,
    this.onTap,
    this.suffixIcon,
    this.onChanged,
    this.fontSize,
    this.autoFocus,
    this.contentPadding,
    this.suffixText,
    this.cursorHeight,
    this.initialvalue,
    this.formater,
    this.textAlignVertical
  });
  var formater;
  final TextEditingController? controller;
  final String? hintText;
  final Color? hintColor;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? keyboardType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final double? fontSize;
  final bool? autoFocus;
  final  contentPadding;
  final String? suffixText;
  double? cursorHeight = 20;
  var initialvalue;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: textAlignVertical,
      inputFormatters: formater,
      initialValue: initialvalue,
      cursorHeight: cursorHeight,
      cursorColor: AppColors.GlobelColor,
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: TextStyle(fontSize: responsive(20,context), fontFamily: GoogleFonts.cairo().fontFamily, fontWeight: FontWeight.bold ,color: Colors.black),
      autofocus: autoFocus ?? false,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        suffixStyle: const TextStyle(fontSize: 20),
        suffixText: suffixText,
        isDense: true,
        suffixIcon: suffixIcon,
        prefixText: prefixText,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: responsive(20, context),
          color: hintColor,
          fontFamily: GoogleFonts.cairo().fontFamily,
          fontWeight: FontWeight.bold
        ),
        enabledBorder: InputBorder.none,

        focusedBorder: InputBorder.none
      ),
    );
  }
}



class QuantityFeild extends StatelessWidget {
  QuantityFeild({
    super.key,
    this.controller,
    this.hintText,
    this.readOnly,
    this.textAlign,
    this.keyboardType,
    this.prefixText,
    this.onTap,
    this.suffixIcon,
    this.onChanged,
    this.fontSize,
    this.autoFocus,
    this.contentPadding,
    this.suffixText,
    this.cursorHeight,
    this.initialvalue,
    this.formater
  });
  var formater;
  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final double? fontSize;
  final bool? autoFocus;
  final  contentPadding;
  final String? suffixText;
  double? cursorHeight = 20;
  var initialvalue;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formater,
      // initialValue: initialvalue,
      cursorHeight: cursorHeight,
      cursorColor: AppColors.backgroundColor,
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.left,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: TextStyle(fontSize: responsive(12,context), fontFamily: AppFonts.poppinsMedium, color: Colors.black),
      autofocus: autoFocus ?? false,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: contentPadding,
        suffixStyle: const TextStyle(fontSize: 12),
        suffixText: suffixText,
        isDense: true,
        suffixIcon: suffixIcon,
        prefixText: prefixText,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: responsive(12,context),
          color: const Color(0xFF828282),
          fontFamily: AppFonts.poppinsMedium,
        ),

      ),

    );
  }
}









class InputTextField extends StatelessWidget {
  const InputTextField({Key? key,
    required this.myController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.onValidator,
    required this.keyBoardType,
    required this.hint,
    required this.obscureText,
    this.enable = true,
    this.autoFocus = false,
  }) : super(key: key);

  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator onValidator;

  final TextInputType keyBoardType;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmittedValue,
        validator: onValidator,
        keyboardType: keyBoardType,
        obscureText: obscureText,
        style: TextStyle(fontSize: responsive(14,context), fontFamily: AppFonts.poppinsMedium, color: Colors.black),
        enabled: enable,
        cursorColor:  AppColors.backgroundColor,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: responsive(14,context), fontFamily: AppFonts.poppinsMedium, color: AppColors.secondaryColor),
          border:   const UnderlineInputBorder(

          ),
          errorBorder:  const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
