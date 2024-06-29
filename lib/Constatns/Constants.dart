import 'package:huz/Controller/HotelJsonLoader.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../Controller/pakagecontroller.dart';

String formatCurrency(int amount) {
  // Convert the integer to a string
  String amountStr = amount.toString();

  // Use a buffer to build the formatted string
  StringBuffer buffer = StringBuffer();

  // Iterate over the string from end to start
  for (int i = amountStr.length - 1, j = 1; i >= 0; i--, j++) {
    buffer.write(amountStr[i]);
    // Add a comma after every 3 digits, except at the end
    if (j % 3 == 0 && i != 0) {
      buffer.write(',');
    }
  }

  // Reverse the string to get the correct order
  return buffer.toString().split('').reversed.join('');
}




var cnicMask = MaskTextInputFormatter(
    mask: '#####-#######-#',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var nameMask = MaskTextInputFormatter(
    mask: '################################',
    filter: {"#": RegExp(r'[a-zA-Z\.\-\s]')},
    type: MaskAutoCompletionType.lazy);

var emailMask = MaskTextInputFormatter(
  mask: '#######################################', // Adjust the mask length as needed
  filter: {"#": RegExp(r'[a-zA-Z0-9\.\_\-@]')}, // Include characters typically found in emails
  type: MaskAutoCompletionType.lazy,
);
var websiteMask = MaskTextInputFormatter(
  mask: '#######################################', // Adjust as needed
  filter: {"#": RegExp(r'[a-zA-Z0-9\.\-\_]')}, // Include characters typically found in URLs
  type: MaskAutoCompletionType.lazy,
);
var phoneMask = MaskTextInputFormatter(
  mask: '(###) ###-####', // US phone number format
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);
var titlemask = MaskTextInputFormatter(
    mask: '#########################',
    filter: {"#": RegExp(r'[a-zA-Z\.\-\s]')},
    type: MaskAutoCompletionType.lazy);




List<String> concatenateStringLists({list1,list2}) {
  // Concatenate the two lists

  List<String> concatenatedList = List.from(list1)..addAll(list2);

  return concatenatedList;
}

String getImages( hotelcontroller hotel, pakagecontrollers pkg,var index){
  String image ="";
  for(var hotelname in pkg.package!.results![index].hotelInfoDetail!){

    if(hotelname.hotelCity == "Mecca"){

      for(var m in hotel.makkahotels){
           print(m.hotelName );
           print(hotelname.hotelName );

        if( m.hotelName == hotelname.hotelName  ){

          image =  m.image1;

          hotel.image = m.image1;
          print(image);
  break;
        }
      }
    }

  }
  return image;


}

List<List> Getmultipleimages(hotelcontroller hotel, hotels ){
  String image ="";
  List<String> image1=[];
  List<String> image2=[];
  for(var hotelname in hotels){
    print("cities ${hotelname.hotelCity}");
    if(hotelname.hotelCity == "Madinah"){
      for(var m in hotel.madinaHotels){
        print(m.hotelName );
        print(hotelname.hotelName );

        if( m.hotelName == hotelname.hotelName)
        {

          hotel.image = m.image1;
          print(image);

          image2 = [m.image1,m.image2,m.image3,m.image4];
break;

        }
      }
    }
    if(hotelname.hotelCity == "Mecca"){

      for(var m in hotel.makkahotels){
        print(m.hotelName );
        print(hotelname.hotelName );

        if( m.hotelName == hotelname.hotelName  ){

          image =  m.image1;
          image1 = [m.image1,m.image2,m.image3,m.image4];
break;
          print(image);

        }
      }
    }




  }
   // image1.addAll(image2);
  return [image1,image2] ;


}