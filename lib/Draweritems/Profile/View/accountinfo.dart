import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:provider/provider.dart';

import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/styles.dart';
import '../../../View/auth/controller/is_user_exist_controller.dart';
import '../../../utils/servecies.dart';
import '../Controllers/EditeProfileImage/EditeProfileimageController.dart';
import 'address_screen.dart';
import 'edit_profile_screen/GenderEdite.dart';
import 'edit_profile_screen/edit_profile_screen.dart';

class AccountInfo extends StatefulWidget {
  var UserData;

  AccountInfo({Key? key, this.UserData}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  var imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    // var PicController = Provider.of<EditeImage>(context);

    return Consumer2<IsUserExitsController,EditeImage>(builder: (context,user , value, child) {

      return Scaffold(
        // backgroundColor: Colors.white70.withOpacity(0.95),
        appBar: AppBar(
          centerTitle: true,
          title:appBarTitle(context: context, text: "Profile"),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: responsive(30, context),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.width * 0.25,
                  child: Stack(
                    children: <Widget>[
                      value.image != null
                          ? CircleAvatar(
                        backgroundImage: FileImage(
                          value.image!,
                        ),
                        radius: MediaQuery.of(context).size.width * 0.12,
                        // specify the radius of the circular container
                        backgroundColor: Colors.grey[100],
                      )
                          : CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.12,
                        // specify the radius of the circular container
                        backgroundColor: Colors.grey[100],
                        // set the background color of the container
                        child: ClipOval(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SvgPicture.asset(
                                  width: 20,
                                  height:20,
                                  // fit: BoxFit.cover,
                                  'assets/images/profile.svg'
                              ),
                            ),
                            errorWidget: (context, url, error) => Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SvgPicture.asset(
                                  width: 20,
                                  height: 20,
                                  'assets/images/profile.svg'
                              ),
                            ),
                            imageUrl:
                            '${NetworkServices.ibaseUrl}${user.isUser?.userPhoto}',
                            // replace with the URL of your image
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.25 * 0.1,
                        left: MediaQuery.of(context).size.width * 0.25 * 0.8,
                        child: InkWell(
                          onTap: () {
                            value.GetImage(user.isUser?.sessionToken,context);

                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    //Color.fromRGBO(242, 242, 242, 1),
                                    offset: Offset(0.4, 0.4),
                                    blurRadius: 10)
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white70.withOpacity(0.85),
                              radius: MediaQuery.of(context).size.width * 0.024,
                              child: CircleAvatar(
                                // foregroundColor: Colors.grey,
                                radius: MediaQuery.of(context).size.width * 0.02,
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(
                                  'assets/images/pencil.svg',
                                  semanticsLabel: 'vector',
                                  height: responsive(8, context),
                                  width: responsive(13, context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   top:16,
                      //   //MediaQuery.of(context).size.width *(16/375) ,
                      //   left: 124,
                      //     //MediaQuery.of(context).size.width * (124/375) ,
                      //   child:
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: responsive(30, context),
                ),
                Container(
                  height: responsive(1, context),
                  color: Color.fromRGBO(242, 242, 242, 1),
                ),
                InfoStrip(user.isUser?.name ?? '', 'assets/images/myCAUSE.svg',
                    context, 'Name', false),
                InfoStripSingle(
                    '${user.isUser?.countryCode ?? ''}${user.isUser?.phoneNumber ?? ''}',
                    'assets/images/phone.svg',
                    context,
                    true),
                InfoStrip('${user.isUser?.email ?? 'Example@email.com'}',
                    'assets/images/email.svg', context, 'Email', false),
                InfoStrip('${user.isUser?.userGender ?? 'Gender'}',
                    'assets/images/gender.svg', context, 'Gender', true),

                Container(
                  height: responsive(1, context),
                  color: Color.fromRGBO(242, 242, 242, 1),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Widget profileImage(var context, UserData, picController) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.30,
  //     height: MediaQuery.of(context).size.width * 0.25,
  //     child: Stack(
  //       children: <Widget>[
  //         CircleAvatar(
  //           radius: MediaQuery.of(context).size.width * 0.12,
  //           // specify the radius of the circular container
  //           backgroundColor: Colors.grey,
  //           // set the background color of the container
  //           child: ClipOval(
  //             child: CachedNetworkImage(
  //               placeholder: (context, url) => Image.asset(
  //                 'assets/images/pic.png',
  //                 // replace with the asset path and file name of your placeholder image
  //                 fit: BoxFit.cover,
  //                 width: 100,
  //                 height: 100,
  //               ),
  //               errorWidget: (context, url, error) => const Icon(Icons.error),
  //               imageUrl: '${baseUrl.baseURLi}${widget.UserData?.userPhoto}',
  //               // replace with the URL of your image
  //               fit: BoxFit.cover,
  //               width: 100,
  //               height: 100,
  //             ),
  //           ),
  //         ),
  //
  //         // CircleAvatar(radius: MediaQuery.of(context).size.width * 0.12,child: CircleAvatar(radius: MediaQuery.of(context).size.width * 0.12,
  //         //   backgroundImage:picController.image!=null?FileImage(picController.image!) :imageLoaded==false?AssetImage(
  //         //     'assets/images/pic.png',
  //         //   ): NetworkImage('${baseUrl.baseURLi}${widget.UserData?.userPhoto}') as ImageProvider ,
  //         //
  //         // )),
  //         // ),
  //         Positioned(
  //           top: MediaQuery.of(context).size.width * 0.25 * 0.1,
  //           left: MediaQuery.of(context).size.width * 0.25 * 0.8,
  //           child: InkWell(
  //             onTap: () {
  //               picController.GetImage(UserData, context).then((_) {
  //                 picController.cropImage(context);
  //               });
  //             },
  //             child: Container(
  //               decoration: const BoxDecoration(
  //                 boxShadow: [
  //                   BoxShadow(
  //                       color: Colors.grey,
  //                       //Color.fromRGBO(242, 242, 242, 1),
  //                       offset: Offset(0.4, 0.4),
  //                       blurRadius: 10)
  //                 ],
  //               ),
  //               child: CircleAvatar(
  //                 backgroundColor: Colors.white70.withOpacity(0.85),
  //                 radius: MediaQuery.of(context).size.width * 0.024,
  //                 child: CircleAvatar(
  //                   // foregroundColor: Colors.grey,
  //                   radius: MediaQuery.of(context).size.width * 0.02,
  //                   backgroundColor: Colors.white,
  //                   child: SvgPicture.asset(
  //                     'assets/images/pencil.svg',
  //                     semanticsLabel: 'vector',
  //                     height: responsive(8, context),
  //                     width: responsive(13, context),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         // Positioned(
  //         //   top:16,
  //         //   //MediaQuery.of(context).size.width *(16/375) ,
  //         //   left: 124,
  //         //     //MediaQuery.of(context).size.width * (124/375) ,
  //         //   child:
  //         // ),
  //       ],
  //     ),
  //   );
  // }



  Widget InfoStrip(var text, url, context, name, isgender, {isAddress = false}) {
    return InkWell(
      onTap: () {
        isgender
            ? Get.off(() => GenderEdite(
          type: text,
        ))
            : isAddress ? Get.off(() => AddressScreen()): Get.off(() => EditProfileScreen(
          text: name,
          UserData: widget.UserData,
          name: text,
        ));
      },
      child: Container(
          height: responsive(45, context),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            color: Color.fromRGBO(255, 255, 255, 1),
            border: Border.all(
              color: Color.fromRGBO(242, 242, 242, 1),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      '$url',
                      semanticsLabel: 'vector',
                      fit: BoxFit.fill,
                      height: responsive(18, context),
                      width: responsive(24, context),
                    ),
                    SizedBox(
                      width: responsive(20, context),
                    ),
                    Text(
                      '$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: const Color.fromRGBO(18, 18, 18, 1),
                          fontFamily: 'Poppins',
                          fontSize: responsive(14, context),
                          letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.w500,
                          height: 1),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: responsive(15, context),
                ),
              ],
            ),
          )),
    );
  }

  Widget InfoStripSingle(var text, url, context, isphone) {
    return Container(
        height: responsive(45, context),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          color: Color.fromRGBO(255, 255, 255, 1),
          border: Border.all(
            color: Color.fromRGBO(242, 242, 242, 1),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    '$url',
                    semanticsLabel: 'vector',
                    fit: BoxFit.fill,
                    height: responsive(18, context),
                    width: responsive(24, context),
                  ),
                  SizedBox(
                    width: responsive(20, context),
                  ),
                  Text(
                    '$text',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(18, 18, 18, 1),
                        fontFamily: 'Poppins',
                        fontSize: responsive(14, context),
                        letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.w500,
                        height: 1),
                  ),
                ],
              ),
              isphone == false
                  ? Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: responsive(15, context),
              )
                  : Container(),
            ],
          ),
        )

      // ListTile(
      //   contentPadding: EdgeInsets.all(0.0),
      //   leading:
      //   title:
      //   trailing:
      // ),

    );
  }
}

Widget InfoStripSingle(var text, url, context, isphone) {
  return Container(
      height: responsive(45, context),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        color: Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(
          color: Color.fromRGBO(242, 242, 242, 1),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  '$url',
                  semanticsLabel: 'vector',
                  fit: BoxFit.fill,
                  color: Colors.black,
                  height: responsive(18, context),
                  width: responsive(24, context),
                ),
                SizedBox(
                  width: responsive(20, context),
                ),
                Container(
                  width: responsive(400, context),
                  child: Text(
                    '$text',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(18, 18, 18, 1),
                        fontFamily: 'Poppins',
                        fontSize: responsive(14, context),
                        letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.w500,
                        height: 1),
                  ),
                ),
              ],
            ),
            isphone == false
                ? Icon(
              Icons.arrow_forward,
              color: Colors.black,
              size: responsive(15, context),
            )
                : Container(),
          ],
        ),
      )

    // ListTile(
    //   contentPadding: EdgeInsets.all(0.0),
    //   leading:
    //   title:
    //   trailing:
    // ),

  );
}

// Widget InfoStrip(var text,url,context,name){
//
//   return  InkWell(
//     onTap: (){
//       Get.to(EditProfileScreen(text:name));
//     },
//     child: Container(
//         height: responsive(40, context),
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           borderRadius : BorderRadius.only(
//             topLeft: Radius.circular(5),
//             topRight: Radius.circular(5),
//             bottomLeft: Radius.circular(5),
//             bottomRight: Radius.circular(5),
//           ),
//           color : Color.fromRGBO(255, 255, 255, 1),
//           border : Border.all(
//             color: Color.fromRGBO(242, 242, 242, 1),
//             width: 2,
//           ),
//         ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SvgPicture.asset(
//
//                   '$url',
//                   semanticsLabel: 'vector',
//                   fit: BoxFit.fill,
//                   height: responsive(18, context),
//                   width: responsive(24, context),
//
//                 ),
//                 SizedBox(
//                   width: responsive(20, context),
//                 ),
//                 Text('$text', textAlign: TextAlign.left, style: TextStyle(
//                     color: Color.fromRGBO(18, 18, 18, 1),
//                     fontFamily: 'Poppins',
//                     fontSize:  responsive(14, context),
//                     letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//                     fontWeight: FontWeight.w500,
//                     height: 1
//                 ),),
//
//               ],
//             ),
//             Icon(Icons.arrow_forward,color: Colors.black,size:  responsive(15, context),),
//           ],
//         ),
//       )
//
//
//
//
//       // ListTile(
//       //   contentPadding: EdgeInsets.all(0.0),
//       //   leading:
//       //   title:
//       //   trailing:
//       // ),
//     ),
//   );
//
// }
// Widget InfoStripSingle(var text,url,context){
//
//   return  Container(
//       height: responsive(40, context),
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         borderRadius : BorderRadius.only(
//           topLeft: Radius.circular(5),
//           topRight: Radius.circular(5),
//           bottomLeft: Radius.circular(5),
//           bottomRight: Radius.circular(5),
//         ),
//         color : Color.fromRGBO(255, 255, 255, 1),
//         border : Border.all(
//           color: Color.fromRGBO(242, 242, 242, 1),
//           width: 2,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SvgPicture.asset(
//
//                   '$url',
//                   semanticsLabel: 'vector',
//                   fit: BoxFit.fill,
//                   height: responsive(18, context),
//                   width: responsive(24, context),
//
//                 ),
//                 SizedBox(
//                   width: responsive(20, context),
//                 ),
//                 Text('$text', textAlign: TextAlign.left, style: TextStyle(
//                     color: Color.fromRGBO(18, 18, 18, 1),
//                     fontFamily: 'Poppins',
//                     fontSize:  responsive(14, context),
//                     letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//                     fontWeight: FontWeight.w500,
//                     height: 1
//                 ),),
//
//               ],
//             ),
//             Icon(Icons.arrow_forward,color: Colors.black,size:  responsive(15, context),),
//           ],
//         ),
//       )
//
//
//
//
//     // ListTile(
//     //   contentPadding: EdgeInsets.all(0.0),
//     //   leading:
//     //   title:
//     //   trailing:
//     // ),
//   );
//
// }
