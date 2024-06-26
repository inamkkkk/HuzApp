import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/TextStyles/Color.dart';

import '../../../TextStyles/styles.dart';

Widget Search({
  var context, onchange
}){
  return

    // Container(
    //
    //   height: responsive(44, context),
    //   decoration: BoxDecoration(
    //     borderRadius : BorderRadius.all(
    //         Radius.circular(responsive(10, context)),
    //     ),
    //
    //     boxShadow : [BoxShadow(
    //         color: Color.fromRGBO(0, 0, 0, 0.11999999731779099),
    //         offset: Offset(2,2),
    //         blurRadius: responsive(10, context)
    //     )],
    //      color : Color.fromRGBO(255, 255, 255, 1),
    //     // color:Colors.black,
    //   ),
    // child: Center(
    //   child: TextField(
    //
    //     // controller: _searchController,
    //     decoration: InputDecoration(
    //       prefix: Padding(
    //         padding:  EdgeInsets.only(top: responsive(04, context)),
    //         child: Icon(Icons.search),
    //       ),
    //       border: InputBorder.none,
    //       hintText: ' Search',
    //       hintStyle: TextStyle(color: AppColors.grayboxcolor),
    //     ),
    //     cursorColor: AppColors.grayboxcolor,
    //     onChanged: (value) {
    //       // Your search logic here
    //     },
    //     inputFormatters: [
    //       // FilteringTextInputFormatter.allow(_regExp),
    //     ],
    //   ),
    // ),

  // );
    Center(
      child: Container(
        height: responsive(62, context),
        // width: responsive(384, context),
      
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(responsive(50, context)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.12),
              offset: Offset(2, 2),
              blurRadius: responsive(10, context), // Assuming responsive() function returns the responsive blur radius
            ),
          ],
        ),
        child:Padding(
          padding:  EdgeInsets.symmetric(horizontal: responsive(23, context),vertical: responsive(10, context)),
          child: Row(
            children: [
      
              SvgPicture.asset(
                width: responsive(27, context),
                height: responsive(24, context),
                'images/search_icon.svg',
                semanticsLabel: 'vector',
                color: Colors.black,
                // fit: BoxFit.fitWidth,
      
              ),
              Padding(
                padding:  EdgeInsets.only(left: responsive(20, context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cardsubtitle(
                      text: "Where to ?",
                      center: false,
                      context: context,
      
                    ),
                    cardtrailingsubtitle(
                  text: 'Anywhere - Any week - 2 guests',
                  context: context,
                  center: false,
                  color: Colors.black26
                          ),
      
                  ],
                ),
              ),
              Spacer(),
      
              SvgPicture.asset(
                width: responsive(40, context),
                height: responsive(40, context),
                'images/filter.svg',
                semanticsLabel: 'vector',
                // color: Colors.black,
                // fit: BoxFit.fitWidth,
      
              ),
              // SizedBox(width: responsive(10, context),)
            ],
          ),
        )
      
      
      //       ListTile(
      // // contentPadding: EdgeInsets.only(top: 0,bottom: 0),
      //         leading:
      //
      //         subtitle: cardtrailingsubtitle(
      //             text: 'Any where  Every where Any Time',
      //             context: context,
      //             center: false,
      //             color: Colors.black26
      //         ),
      //         trailing:
      //
      //       ),
        // child: TextField(
        //   readOnly: true,
        //   decoration: InputDecoration(
        //     // contentPadding: EdgeInsets.fromLTRB(responsive(13.0 + 21.0, context), responsive(0.0, context), responsive(10.0, context), responsive(0, context)), // Adjust content padding to accommodate the prefix icon
        //     prefixIcon:
        //
        //     // Icon(Icons.search,color: AppColors.grayboxcolor,),
        //     // hintText: 'Search',
        //     hintStyle: TextStyle(color: AppColors.grayboxcolor),
        //     filled: true,
        //
        //     fillColor: Color.fromRGBO(255, 255, 255, 1),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(responsive(50, context)), // Assuming responsive() function returns the responsive border radius
        //       borderSide: BorderSide.none,
        //     ),
        //     // contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust content padding as needed
        //
        //   ),
        //   onChanged: onchange,
        //   inputFormatters: [
        //     // FilteringTextInputFormatter.allow(_regExp),
        //   ],
        // ),
      ),
    );
}