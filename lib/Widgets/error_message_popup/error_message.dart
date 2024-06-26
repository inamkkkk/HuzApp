import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Responsive/ResponsiveClass.dart';
import '../../TextStyles/AppFonts.dart';




class SuccessMesssage extends StatefulWidget {
  SuccessMesssage(
      {Key? key, this.isVisible = false, required this.message, this.onTap})
      : super(key: key);
  final String message;
  bool isVisible;
  var onTap;

  @override
  State<SuccessMesssage> createState() => _SuccessMesssageState();
}

class _SuccessMesssageState extends State<SuccessMesssage> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE7F7ED),
          border: Border.all(
            color: const Color(0xFF94BFA8),
            width: 2,
          ),
        ),
        padding: EdgeInsets.only(
          right: responsive(15, context),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -30,
              bottom: 0,
              top: 0,
              child: SvgPicture.asset(
                'assets/images/happy.svg',
                color: const Color(0xFFD6F0DC),
                height: 75,
                width: 35,

              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: responsive(50, context),
                  bottom: responsive(5, context),
                  top: responsive(5, context)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Success!',
                        style: TextStyle(
                          fontSize: responsive(14, context),
                          fontFamily: AppFonts.poppinsSemiBold,
                          color: const Color(0xFF83B28A),
                        ),
                      ),
                      SizedBox(
                        width: responsive(280, context),
                        child: Text(
                          widget.message,
                          style: TextStyle(
                            fontSize: responsive(14, context),
                            fontFamily: AppFonts.poppinsMedium,
                            color: const Color(0xffAECFB5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: const Icon(
                        Icons.clear,
                        color: Color(0xFF94BFA8),
                        size: 30,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorMesssage extends StatefulWidget {
  ErrorMesssage(
      {Key? key,
      required this.onTap,
      required this.message,
      required this.isVisible})
      : super(key: key);
  final String message;
  bool isVisible;
  var onTap;

  @override
  State<ErrorMesssage> createState() => _ErrorMesssageState();
}

class _ErrorMesssageState extends State<ErrorMesssage> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFE5E6),
          border: Border.all(
            color: const Color(0xFFD6C1C2),
            width: 2,
          ),
        ),
        padding: EdgeInsets.only(
          right: responsive(15, context),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -30,
              top: 0,
              bottom: 0,
              child: SvgPicture.asset(
                'assets/images/sad.svg',
                color: const Color(0xFFF9D4D4),
                height: 75,
                width: 35,

              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: responsive(50, context),
                bottom: responsive(5, context),
                top: responsive(5, context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error!',
                        style: TextStyle(
                          fontSize: responsive(14, context),
                          fontFamily: AppFonts.poppinsSemiBold,
                          color: const Color(0xFFC8989C),
                        ),
                      ),
                      SizedBox(
                        width: responsive(280, context),
                        child: Text(
                          widget.message,
                          style: TextStyle(
                            fontSize: responsive(14, context),
                            fontFamily: AppFonts.poppinsMedium,
                            color: const Color(0xFFE5BDBF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: const Icon(
                        Icons.clear,
                        color: Color(0xFFD58F92),
                        size: 30,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
