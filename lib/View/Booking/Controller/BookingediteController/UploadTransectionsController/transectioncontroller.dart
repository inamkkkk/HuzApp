import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http ;
import 'package:huz/utils/servecies.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Loading/loading.dart';

class transectioncontroller with ChangeNotifier{
  List<dynamic> imageFileList = [];
  List<String> filePaths = [
  ];

  void pickImages() async {
    filePaths.clear();
    final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      for (var m in selectedImages){
        imageFileList.add(m);
      }
      for(var m in imageFileList!){
          filePaths.add(m.path);
        }

      print('filepathlength = ${filePaths.length}');
      notifyListeners();
    }
  }
  Future<bool> uploadtransection({sessiontoken,bookingnumber,amount}) async {
    Loading();
    var headers = {
      'Authorization': '${NetworkServices.token}',
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${NetworkServices.bookingurl}pay_booking_amount_by_transaction_photo/'),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      'session_token': '$sessiontoken',
      'booking_number': '$bookingnumber',
      'transaction_amount': '$amount',
    });

    // List of file paths to upload


    // Add each file to the request
    for (var path in filePaths) {
      request.files.add(await http.MultipartFile.fromPath('transaction_photo', path));
    }

    // Send the request
    http.StreamedResponse response = await request.send();

    // Handle the response
    if (response.statusCode == 200||response.statusCode == 201) {
    print(await response.stream.bytesToString());
    return true;
    } else {
    print('Upload failed: ${await response.stream.bytesToString()}');
    return false;
    }
  }
}