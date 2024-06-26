import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> Loading(){
  return EasyLoading.show(
    status: 'Loading ...',
    maskType:EasyLoadingMaskType.black,
    dismissOnTap: false,

  );
}
Future<void> DoneLoading(var message){
  return  EasyLoading.showSuccess(''

  );
}
Future<void> errorLoading(var message){
  return EasyLoading.showError(

      '$message');
}


Future<void> endLoading()async {
  EasyLoading.dismiss();
}

