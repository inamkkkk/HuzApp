import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../../../../../widgets/error_message_popup/error_message.dart';

import '../../../../Responsive/ResponsiveClass.dart';
import '../../../../TextStyles/AppFonts.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../View/auth/controller/is_user_exist_controller.dart';
import '../../Controllers/EditeProfileController/EditeProfileController.dart';
import '../accountinfo.dart';


class EditProfileScreen extends StatefulWidget {
  var UserData;
  final String text;
  final String name;
  EditProfileScreen({Key? key, required this.text,this.UserData,required this.name}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController textEditingController = TextEditingController();
  final FocusNode textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    textEditingController =TextEditingController(text: widget.name);
  }
  @override
  void dispose(){
    textEditingController.dispose();
    textFocusNode.dispose();
    super.dispose();
  }
  bool isTextEdited = false;
  var slogan;



  @override
  Widget build(BuildContext context) {

    switch (widget.text) {
      case 'Name':
        slogan = 'Please enter your full name.';
        break;
      case 'Email':
        slogan = 'Use an email address you check often';
        break;
      case 'Gender':
        slogan = 'Please select your gender';
        break;
      case 'Website':
        slogan = 'Please Enter Website Url';
        break;
      case 'NTN':
        slogan = 'Please enter your NTN Number';
        break;
      default:
        slogan = '';
    }
    return Consumer<IsUserExitsController>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading:  IconButton(onPressed: (){
            Get.off(AccountInfo());
          }, icon: SvgPicture.asset(

            'assets/images/Arrow.svg',
            semanticsLabel: 'vector',

            width: responsive(27, context),
          ),)  ,
          backgroundColor: Colors.white,
          title: Text(
            'Edit ${widget.text}',
            style: const TextStyle(
                fontFamily: AppFonts.poppinsMedium,
                fontSize: 16,
                color: Colors.black),
          ) ,
          actions: [
            GestureDetector(
              onTap: (){
                if(widget.text == 'Name'){
                  Provider.of<EditeProfile>(context,listen:false).EditeName( context,value.isUser?.sessionToken,textEditingController.text);
                }else if(widget.text == 'Email'){
                  Provider.of<EditeProfile>(context,listen:false).Editemail( context,value.isUser?.sessionToken,textEditingController.text);
                }else if(widget.text == 'Gender'){
                  Provider.of<EditeProfile>(context,listen:false).Editegender( context,value.isUser?.sessionToken,textEditingController.text);
                }else if(widget.text == 'NTN'){
                  Provider.of<EditeProfile>(context,listen:false).EditeNTN( context,value.isUser?.sessionToken,textEditingController.text);
                }else if(widget.text == 'Website'){
                  Provider.of<EditeProfile>(context,listen:false).EditeWebsite( context,value.isUser?.sessionToken,textEditingController.text);
                }
                // Get.off(AccountInfo());
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height:  responsive(60, context),
                  width: responsive(70, context),
                  padding: const EdgeInsets.symmetric( horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color:  isTextEdited  ? AppColors.GlobelColor : Colors.grey.shade300,
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: widget.text == textEditingController.text
                              ? Colors.grey.shade400
                              : Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor:Colors.white,

        body: Consumer<EditeProfile>(
            builder: (context, value, child){
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(value.isVisible == true) SizedBox( child: ErrorMesssage(isVisible: value.isVisible, message: value.message,onTap: (){setState(() {
                    value.isVisible = false;
                  });},),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                      controller: textEditingController,
                      focusNode: textFocusNode,
                      onChanged: (value) {
                        setState(() {
                          isTextEdited = value !=  widget.name;
                        });
                      },
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      readOnly: false,
                      cursorWidth: 1.0,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: AppFonts.poppinsMedium,
                          fontSize: responsive(14, context)),
                      enabled: true,
                      cursorColor: AppColors.GlobelColor,
                      decoration: InputDecoration(

                        hintText: widget.name,
                        fillColor: Colors.transparent,
                        filled: true,
                        hintStyle: TextStyle(
                            fontFamily: AppFonts.poppinsMedium,
                            fontSize: responsive(14, context),
                            color: const Color(0xffB1B1B1)),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColors.GlobelColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      child: Text(
                        '$slogan',textAlign:TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppFonts.poppinsRegular,
                          fontSize: responsive(12, context),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
        ),
      );
    });
  }
}