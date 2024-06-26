import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:huz/TextStyles/Color.dart';
import 'package:huz/View/TransportPageWidgets/controller/transportController.dart';
import 'package:provider/provider.dart';

import '../../../Controller/pakagecontroller.dart';
import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/styles.dart';
import '../../../utils/servecies.dart';

class Transportpackage extends StatefulWidget {
  var index;
  Transportpackage({super.key, required this.index, });

  @override
  State<Transportpackage> createState() => _TransportpackageState();
}

class _TransportpackageState extends State<Transportpackage> {
  var currentImageUrl ="";
  var randomIndex;

  final PageController pageController = PageController();
  int currentIndex = 0;
  @override
  void initState() {


    // TODO: implement initState
    super.initState();
  }
  List<Widget> availability = [];

  @override
  Widget build(BuildContext context) {

    return Consumer<pakagecontrollers>(
        builder: (context, transports, child){
          var data = transports.transport?.results?[widget.index];
          if(availability.isEmpty){

              String string = data?.availability;
              List<String> result = string.split(", ");
              print(result);

              for(var m in result){
              availability.add(
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: responsive(40, context)),
                      width: responsive(100, context),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            width: responsive(12, context),
                            height: responsive(12, context),
                            'images/include.svg',
                            semanticsLabel: 'vector',
                            // fit: BoxFit.fitHeight,
                          ),
                          SizedBox(
                            width: responsive(08, context),
                          ),

                          Discription(
                            center: false,
                            text: '${m}',
                            context: context,
                          ),
                          SizedBox(width: responsive(02, context),)
                        ],
                      )
                  ),
                );
              }



          }
          return Padding(
            padding:  EdgeInsets.symmetric(vertical: responsive(20, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        width: responsive(405, context),
                        height: responsive(374, context),
                        child: ClipRRect(

                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(responsive(10, context)),
                            topRight: Radius.circular(responsive(10, context)),
                            bottomRight: Radius.circular(responsive(10, context)),
                            bottomLeft: Radius.circular(responsive(10, context)),
                          ),
                          child: Container(
                              width: double.infinity,
                              // color: currentIndex == context.watch<int>() ? Colors.blue : Colors.white,
                              child: CachedNetworkImage(
                                imageUrl: "${NetworkServices.ibaseUrl}${data?.vehiclePhotos}",
                                placeholder: (context, url) => Image.asset('images/placeholder-image.png',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) => Image.asset('images/placeholder-image.png',
                                  fit: BoxFit.cover,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                        ),


                        ),


                  ],
                ),




                SizedBox(height: responsive(15, context),),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Heading4(
                          text: '${data?.nameAndModel}',
                          context: context,
                          center: false,
                        ),
                        Discription(
                          text: 'Sitting Capacity ${data?.sittingCapacity}',
                          context: context,
                          center: false,
                        ),
                        SizedBox(height: responsive(03, context),),

                        Padding(
                          padding:  EdgeInsets.only(right:responsive(02, context)),
                          child: Container(
                            width: responsive(250, context),
                            child: Wrap(
                              // spacing: 01.0,
                              children: availability,

                            ),
                          ),
                        ),
                        SizedBox(height: responsive(03, context),),
                        Discription(
                          text: '${data?.common1} To ${data?.common2}',
                          context: context,
                          center: false,
                        ),
                        SizedBox(height: responsive(03, context),),

                        Row(
                          children: [
                            Heading4(
                                text: 'PKR ${data?.cost} /',
                                context: context,
                                center: false,
                                color: AppColors.GlobelColor
                            ),
                            Discription(
                              text: 'Per Person',
                              context: context,
                              center: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Container(
                          width: responsive(120, context),
                          height: responsive(40, context),
                          decoration: BoxDecoration(
                            color: Color(0xff38AAA4),
                            borderRadius: BorderRadius.circular(responsive(5, context)),
                          ),
                          child: Center(
                              child: Heading4(
                                  text: 'Book Now',
                                  context: context,
                                  color: Colors.white,
                                  center: true
                              )
                          ),
                        ),
                        SizedBox(height: responsive(10, context),),
                        Container(
                          width: responsive(120, context),
                          height: responsive(40, context),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(responsive(5, context)),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: responsive(05, context),),

                          Container(
                            width: responsive(36, context),
                            height: responsive(35, context),
                            decoration: BoxDecoration(
                              color: Color(0xff38AAA4),
                              borderRadius:
                                  BorderRadius.circular(responsive(5, context)),
                            ),
                            child: Center(
                              child: Discription(
                                  text: '8.3',
                                  context: context,
                                  color: Colors.white,
                                  center: true
                              ),
                            ),
                          ),
                              SizedBox(width: responsive(05, context),),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              alttcardsubtitle(
                                  text: 'Fabulous',
                                  context: context,
                                  color: Colors.black,
                                  center: true
                              ),
                              alttcardsubtitle(
                                  text: '14 Reviews',
                                  context: context,
                                  color: Colors.black.withOpacity(0.6),
                                  center: true
                              ),

                            ],
                          ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),





              ],
            ),
          );
        }
    );
  }
}