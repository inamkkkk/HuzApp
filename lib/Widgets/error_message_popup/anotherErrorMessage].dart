import 'package:flutter/material.dart';

import '../../Responsive/ResponsiveClass.dart';
import '../../TextStyles/AppFonts.dart';





class ErrMessage extends StatefulWidget {
  ErrMessage({Key? key,this.ontap, this.isVisible = false, required this.message}) : super(key: key);
  final String message;
  var ontap;
  var isVisible;
  @override
  State<ErrMessage> createState() => _ErrorMesssageState();
}
class _ErrorMesssageState extends State<ErrMessage> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.isVisible,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderSide(
                color: Colors.red,

              ),
              bottom: BorderSide(
                color: Colors.red,

              ),
            ),
          ),
          padding: EdgeInsets.all(responsive(10, context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.red,),
                  SizedBox(width: responsive(10, context),),
                  Container(
                      width: responsive(250, context),
                      child: Text(widget.message, style: TextStyle(fontSize: responsive(14, context), fontFamily: AppFonts.poppinsMedium, color: Color(0xff2B2B2B),),))
                ],
              ),
              GestureDetector(onTap: widget.ontap, child: Icon(Icons.clear, color: Colors.grey.shade600,))
            ],
          ),
        ),
    );
  }
}
