import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../Loading/loading.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../View/auth/controller/is_user_exist_controller.dart';
import '../../../../utils/servecies.dart';





class EditeImage with ChangeNotifier{
  File? image;
  var m;
  GetImage(var UserData,context) async {
    try{
      ImagePicker _picker = ImagePicker();
      await _picker.pickImage(source: ImageSource.gallery).then((xFile) async {
        if (xFile != null) {
          // image= File(xFile.path);
          m = xFile.path;
          await cropImage(context,m, UserData);
          notifyListeners();
        }
        else{
          EasyLoading.showError('Did not Selected');
        }
      });
    }catch(e){
      print(e);
    }

  }
  Future<void> cropImage(context,path, UserData) async {
    print('lets see');
    try{
      print('lets see1');
      var croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              activeControlsWidgetColor: AppColors.GlobelColor,
              toolbarTitle: 'Adjust Image',
              toolbarColor: Colors.white,
              toolbarWidgetColor: Colors.black,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      // print('path is :${croppedFile!.path}');
      // print('path is :${croppedFile!.path}');
      if(croppedFile!.path.isEmpty){
        debugPrint('croped file is null');
        image = File(path);
        image = null;
        m = null;
        notifyListeners();
      }
      else{
        image = File(croppedFile!.path);
        m = croppedFile!.path;
        int?  imageSize = image!.lengthSync();
        print('image size : $imageSize');
        if(imageSize<=700000){
          UploadImage(UserData, context, m);
          notifyListeners();
        }
       else if(imageSize! >= 700000){
          debugPrint('image size exceeded $imageSize');
          print(image?.path);

          var plist = path.split('.');
          var path2 = m.split('.').last;
          var path3 = path.split('.').last;
          path3 = path2;
          plist[plist.length - 1] = path3;
          String target = plist.join('.');


          int quality = 95;
          while (true) {
            final result = await FlutterImageCompress.compressAndGetFile(
              image!.absolute.path,
              target,
              quality: quality,
            ).onError((error, stackTrace) {
              debugPrint('error in compressing is $error');
              return null;
            });
            imageSize = result?.lengthSync();
            debugPrint('image size is ${imageSize.toString()}');
            if (imageSize! <= 700000 || quality <= 10) {
              debugPrint('image size reduced');
              image = result;
              m = image?.path;
              UploadImage(UserData, context, m);
              notifyListeners();
              break;
            }
            quality -= 10;
          }
        }
        notifyListeners();
      }

      notifyListeners();

    }catch(e){
      print(e);
    }


  }

  Future<void> UploadImage(var sessiontoken,context,path) async {
    // try{
      // Loading();
      var headers = {
        'Authorization': '${NetworkServices.token}',

      };
      var request = http.MultipartRequest(
          'PUT', Uri.parse('${NetworkServices.baseUrluser}upload_user_photo/'));
      request.fields.addAll({'session_token': '${sessiontoken}'});
      request.files.add(await http.MultipartFile.fromPath(
          'user_photo', path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('iname');
        print(await response.stream.bytesToString());
        // var user =  await prefs.getString('phone');
        await Provider.of<IsUserExitsController>(context,listen:false).checkUserExistence2(context);
        endLoading();


      } else {
        print('error is  inam ');
        // errorLoading('Failed');
        print(await response.stream.bytesToString());
      }
    // } catch (e) {
    //   print('inam error is $e');
    //   // errorLoading('Failed');
    // }
  }
}

