import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:huz/View/Booking/Controller/BookingediteController/BookingEditeController.dart';
import 'package:huz/utils/servecies.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';

class Docviewer extends StatelessWidget {
  var list ;
  var name;
  final Function(String) onSelectCountry;

  Docviewer({required this.onSelectCountry,this.list, this.name});


  @override
  Widget build(BuildContext context) {
    return Consumer<Bookingedite>(
        builder: (context, booking, child) {
          // documentFor
          // documentLink
          return Container(
            height: responsive(400, context),
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.all(responsive(04, context)),
                  child: Container(
                    width: responsive(40, context),
                    height: responsive(08, context),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(responsive(05, context))),
                      color: AppColors.black.withOpacity(0.5),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: customFonts(
                      context: context,
                      text: 'Collect your Documents',
                      size: 16,
                      color: Color(0xFF466262),
                      fontWeight: FontWeight.bold
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {


                      return  name == list[index].documentFor?

                        InkWell(
                        onTap: () {
                          url2 = list[index].documentLink;
                              Get.off(showdocs());
                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: responsive(20, context)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  customFonts(
                                      context: context,
                                      text: '${list[index].documentFor}',
                                      size: 16,
                                      color: Color(0xFF466262),
                                      fontWeight: FontWeight.bold
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios,size: responsive(10, context),)
                                ],
                              ),

                              Container(
                                height: responsive(1, context),
                                width: MediaQuery.sizeOf(context).width,
                                color: AppColors.black.withOpacity(0.1),

                              ),
                              SizedBox(height: responsive(10, context),),
                            ],
                          ),
                        ),
                      )
                          :
                      SizedBox();
                      // ListTile(
                      // 
                      //   leading: 
                      //   title: 
                      //   onTap: () {
                      //     // onSelectCountry(countries[index]);
                      //   },
                      // );
                    },
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}

 var url2 ;

class showdocs extends StatefulWidget {

  @override
  _showdocsState createState() => _showdocsState();
}

class _showdocsState extends State<showdocs> {
@override
  void initState() {
  WebViewPlatform.instance;
    // TODO: implement initState
    super.initState();
  }
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse("${NetworkServices.ibaseUrl}${url2}"));
// Replace with your desired website URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBarTitle(context: context, text: "Documents "),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}