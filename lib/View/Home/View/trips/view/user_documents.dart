import 'dart:io';


import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Responsive/ResponsiveClass.dart';
import '../../../../../TextStyles/Color.dart';
import '../../../../../TextStyles/styles.dart';

class UserDocuments extends StatefulWidget {
  const UserDocuments({super.key});

  @override
  State<UserDocuments> createState() => _UserDocumentsState();
}

class _UserDocumentsState extends State<UserDocuments> {
  var photoImage, cnicImage, passImage;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: AppBarText(
            text: 'Upload Files',
            context: context,
            center: false,
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(responsive(20, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  customFonts(
                      text: "Thank you Bilal",
                      size: 15,
                      fontWeight: FontWeight.bold,
                      context: context),
                  customFonts(
                      text: "Thank you for choosing us, please complete final step.",
                      size: 13,
                      context: context),
                  SizedBox(height: responsive(20, context),),

                  // Photo upload
                  Row(
                    children: [
                      Expanded(
                        child: DottedBorder(
                          strokeWidth: 0.5,
                          color: AppColors.GlobelColor,
                          dashPattern: [responsive(10, context), ],
                          child: SizedBox(
                            width: responsive(140, context),
                            height: responsive(160, context),
                            child: photoImage == null ?  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap:  (){
                                    pickImage(isPhoto: true);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(responsive(10, context)),
                                    height: responsive(48, context),
                                    width: responsive(48, context),

                                    decoration: BoxDecoration(
                                        color: const Color(0xFF4B465C).withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(responsive(6, context))
                                    ),
                                    child: SvgPicture.asset(
                                      height: responsive(28, context),
                                      width: responsive(28, context),
                                      'images/upload.svg',
                                      semanticsLabel: 'vector',
                                      // fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: responsive(10, context),
                                ),
                                headlineSub(
                                  text: "Photo",
                                  context: context,
                                ),
                              ],
                            ) : Center(child: Image.file(photoImage!, fit: BoxFit.contain,)),
                          ),
                        ),
                      ),
                      SizedBox(width: responsive(20, context),),
                      Expanded(
                        flex: 2,
                        child: DottedBorder(
                          strokeWidth: 0.5,
                          color: AppColors.GlobelColor,
                          dashPattern: [responsive(10, context), ],
                          child: SizedBox(
                            width: size.width,
                            height: responsive(160, context),
                            child: cnicImage == null ?  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap:  (){
                                    pickImage(isCnic: true);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(responsive(10, context)),
                                    height: responsive(48, context),
                                    width: responsive(48, context),

                                    decoration: BoxDecoration(
                                        color: const Color(0xFF4B465C).withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(responsive(6, context))
                                    ),
                                    child: SvgPicture.asset(
                                      height: responsive(28, context),
                                      width: responsive(28, context),
                                      'images/upload.svg',
                                      semanticsLabel: 'vector',
                                      // fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: responsive(10, context),
                                ),
                                headlineSub(
                                  text: "CNIC",
                                  context: context,
                                ),
                              ],
                            ) : Center(child: Image.file(cnicImage!, fit: BoxFit.contain,)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive(20, context),),
                  Center(
                    child: DottedBorder(
                      strokeWidth: 0.5,
                      color: AppColors.GlobelColor,
                      dashPattern: [responsive(10, context), ],
                      child: SizedBox(
                        width: size.width,
                        height: responsive(300, context),
                        child: passImage == null ?  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap:  (){
                                pickImage(isPassport: true);
                              },
                              child: Container(
                                padding: EdgeInsets.all(responsive(10, context)),
                                height: responsive(48, context),
                                width: responsive(48, context),

                                decoration: BoxDecoration(
                                    color: const Color(0xFF4B465C).withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(responsive(6, context))
                                ),
                                child: SvgPicture.asset(
                                  height: responsive(28, context),
                                  width: responsive(28, context),
                                  'images/upload.svg',
                                  semanticsLabel: 'vector',
                                  // fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: responsive(10, context),
                            ),
                            headlineSub(
                              text: "Passport",
                              context: context,
                            ),
                          ],
                        ) : Center(child: Image.file(passImage!, fit: BoxFit.contain,)),
                      ),
                    ),
                  ),

                ],
              ),


              // Passport Photo

              InkWell(
                onTap:  (){},
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(responsive(15, context)),
                  width: size.width,

                  decoration: BoxDecoration(
                      color: AppColors.GlobelColor,
                      borderRadius: BorderRadius.circular(responsive(6, context))
                  ),
                  child: customFonts(text: "Done", size: 15,color: Colors.white, fontWeight: FontWeight.bold, context: context)
                ),
              )

            ],
          ),
        ));
  }

  Future<void> pickImage({ bool isPhoto = false,  bool isCnic = false,  bool isPassport = false}) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        print("pressed");
          isPhoto ?  photoImage = File(pickedFile.path): isCnic ?  cnicImage = File(pickedFile.path) : passImage = File(pickedFile.path);

      });
    }
  }
}



