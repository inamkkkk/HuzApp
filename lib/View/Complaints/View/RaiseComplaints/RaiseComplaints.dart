import 'dart:async';
import 'dart:math';


import 'package:audio_progress_bars/audio_progress_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound/public/tau.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:huz/Loading/loading.dart';
import 'package:huz/TextStyles/styles.dart';
import 'package:huz/View/Booking/Controller/BookingediteController/BookingEditeController.dart';
import 'package:huz/Widgets/snackbar.dart';
import 'package:just_audio/just_audio.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';



import 'package:provider/provider.dart';




import 'package:permission_handler/permission_handler.dart';

import '../../../../../widgets/error_message_popup/error_message.dart';

import '../../../../../widgets/primary_button.dart';

import '../../../../Constatns/Constants.dart';
import '../../../../Responsive/ResponsiveClass.dart';
import '../../../../TextStyles/AppFonts.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../voice_note_test/voice_note_test.dart';
import '../../../auth/controller/is_user_exist_controller.dart';
import '../../Controller/Controller/ComplaintController.dart';
import '../../Widgets/Header.dart';
import '../../Widgets/textcontroller.dart';





class raisComplaint extends StatefulWidget {
  const raisComplaint({Key? key , }) : super(key: key);


  @override
  State<raisComplaint> createState() => _raisComplaintState();
}

class _raisComplaintState extends State<raisComplaint> {

  bool isSuccess = false;




  final TextEditingController titleController = TextEditingController();

  final TextEditingController yourSituationController = TextEditingController();


  final FocusNode titleFocusNode = FocusNode();

  final FocusNode yourSituationFocusNode = FocusNode();


  bool isTitleValidated = true;
  bool isYourSituationValidated = true;

  String message = '';
  bool isVisible = false;
  bool isValidated = true;
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String _recordingTime = '00:00:00';
  String timeToShow  = '00:00:00';
  Timer? timer;
  bool _isRecordingExists = false;
  var path;


  @override
  void dispose() {
    _audioRecorder.closeRecorder();
    super.dispose();
  }

  var hours,sec,minutes;
  void _startRecording() async {
    var status = await Permission.microphone.request();
    if (await Permission.microphone.request().isGranted) {
      setState(() {
        _isRecording = true;
        isplaybutton = true;
      });
      await _audioRecorder.openRecorder();
      await _audioRecorder.startRecorder(
        toFile: 'tau_file.mp4',
        codec: Codec.aacMP4,
        audioSource: theSource,
      );
      path = await _audioRecorder.getRecordURL(path: _filePath);

      const oneSec = Duration(seconds: 1);
      timer  = Timer.periodic(oneSec, (Timer timer) {
        setState(() {
          timeToShow = _recordingTime;
          _recordingTime =
          "${(timer.tick ~/ 3600).toString().padLeft(2, '0')}:${((timer.tick % 3600) ~/ 60).toString().padLeft(2, '0')}:${(timer.tick % 60).toString().padLeft(2, '0')}";
          hours = timer.tick ~/ 3600;
          minutes = ((timer.tick % 3600) ~/ 60);
          sec = (timer.tick % 60);

          if(_isRecording == true){

            timeToShow = _recordingTime;
          }
        });
      });
    }
  }
  bool isplaybutton = true;
  bool _isPlayingRecordedAudio = false;
  Timer? playerTimer;
  final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();
  // final String _filePath = 'audio_file.mp4';
  final String _filePath = 'audio_file.mp3';
  int progressMilliSeconds = 0;
  var totalDuration = 0;
  void _playAudio() async {
    totalDuration = Duration(hours: hours, minutes: minutes, seconds: sec).inMilliseconds;

    debugPrint('total progress $totalDuration   ${progressMilliSeconds}');

    playerTimer  = Timer.periodic( const Duration(milliseconds: 1), (Timer timer) {
      setState(() {
        progressMilliSeconds = timer.tick;

      });

      if(progressMilliSeconds >= totalDuration){
        _audioPlayer.stopPlayer();
        progressMilliSeconds = 0;
        _stopAudio();
        setState(() {
          playerTimer?.cancel();
        });
      }
    });

    await _audioPlayer.openPlayer();
    // await _audioPlayer.startPlayer(fromURI: _filePath);
    await _audioPlayer.startPlayer(fromURI: 'tau_file.mp4');
    setState(() {
      _isPlayingRecordedAudio = true;
    });

    print('path is $path');
    print('Playing recorded:  $_isPlayingRecordedAudio');
  }
  double duration = 0;
  void getRecordingDuration(String filePath) async {
    FlutterSound flutterSound =  FlutterSound();
    flutterSound.thePlayer;
  }
  void _stopAudio() async {

    _audioPlayer.stopPlayer();
    _audioPlayer.closePlayer();
    setState(() {
      _isPlayingRecordedAudio = false;

    });
  }
  Future<void> _stopRecording() async {


    if (timer != null ) {
      debugPrint('in timer');
      timer!.cancel();
      timer = null;
    }
    await _audioRecorder.stopRecorder();
    await _audioRecorder.closeRecorder();



    _isRecording = false;
    _recordingTime = '00:00:00';
    isplaybutton = false;

    if(timeToShow != '00:00:00') _isRecordingExists = true;
    debugPrint('is recording exists or not $_isRecordingExists');
    setState(() {

    });
  }
  final List<double> values = [];

  Color borderColor = const Color(0xffB1B1B1);
  @override
  void initState(){
    var rng =  Random();
    for (var i = 0; i < 40; i++) {
      values.add(rng.nextInt(20) * 1.0);
    }
    super.initState();
    yourSituationFocusNode.addListener(() {
      debugPrint('focus changed ${yourSituationFocusNode.hasFocus}');
      if(yourSituationFocusNode.hasFocus == true){
        setState(() {
          borderColor = const Color(0xffB3CDC6);
        });
      }
      if(yourSituationFocusNode.hasFocus == false){
        setState(() {
          borderColor = const Color(0xffB1B1B1);
        });
      }
    });



    if(yourSituationFocusNode.hasFocus == true){
      debugPrint('focus is ${yourSituationFocusNode.hasFocus}');
      setState(() {
        borderColor = const Color(0xffB3CDC6);
      });
    }
  }

  final _globalKey = GlobalKey<FormState>();

  //yourSituationFocusNode.hasFocus == true ? const Color(0xffB3CDC6) :const Color(0xffB1B1B1),
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Consumer3<IsUserExitsController,Complaintscontroller,Bookingedite>(builder: (context, user,complaints,booking, child) {

      return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: appBarTitle(context: context, text: "Raise Complaint"),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if(isVisible == true && isSuccess == false) Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: isSuccess == false ?  ErrorMesssage(isVisible: isVisible, message: message, onTap:(){
                      setState(() {
                        isVisible = false;
                      });
                    }) :  SuccessMesssage(isVisible: isVisible, message: message, onTap:(){
                      setState(() {
                        isVisible = false;
                      });
                    }),
                  ),
                  Container(
                    color: AppColors.lightBrownColor,
                    height: responsive(47, context),
                    padding: EdgeInsets.symmetric(
                        vertical: responsive(10, context)),
                    alignment: Alignment.center,
                    child: Text(
                      'Transparency leads to trust.',
                      style: TextStyle(
                          fontSize: responsive(14, context),
                          fontFamily: AppFonts.poppinsMedium),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: responsive(40, context)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: responsive(20, context),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: responsive(0, context),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              SizedBox(
                                height: responsive(20, context),
                              ),
                              const ManageBankHeaderText(
                                  headerText: 'Your Complaint'),
                              Text(
                                'Describe your needs detail',
                                style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegular,
                                  color: Colors.black,
                                  fontSize: responsive(12,context),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: responsive(20, context),
                        ),
                        Form(
                          key: _globalKey,
                          child: Column(
                            children: [
                              TextFieldMasked(
                                fillColor: AppColors.lightBrownColor,
                                isValidated: isTitleValidated,
                                inputFormatter: [titlemask],
                                myController: titleController,
                                focusNode: titleFocusNode,
                                onFieldSubmittedValue: (value) {},
                                onValidator: (value) {
                                  return null;
                                },
                                keyBoardType: TextInputType.text,
                                hint: 'Complaint Title',
                                obscureText: false,
                                enable: true,
                              ),
                              SizedBox(
                                height: responsive(13, context),
                              ),

                              Container(
                                height: 250,
                                alignment: Alignment.topLeft,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.lightBrownColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(responsive(5, context)),
                                    topLeft: Radius.circular(responsive(5, context)),
                                  ),
                                ),
                                child: TextFormField(
                                  focusNode: yourSituationFocusNode,
                                  controller: yourSituationController,
                                  textAlignVertical: TextAlignVertical.center,
                                  textAlign: TextAlign.start,
                                  maxLines: 15,
                                  onFieldSubmitted: (value) {},
                                  validator: (value) {
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontFamily: AppFonts.poppinsMedium,
                                      fontSize: responsive(
                                          15, context)),
                                  cursorColor: AppColors.GlobelColor,
                                  decoration: InputDecoration(

                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: responsive(15, context),
                                      vertical: responsive(10, context),
                                    ),
                                    hintText: 'Describe your complaint in words.',
                                    hintStyle: TextStyle(
                                      fontFamily: AppFonts.poppinsMedium,
                                      fontSize: responsive(15, context),
                                      color: const Color(0xffB1B1B1),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                height: 2,
                                color:  borderColor,
                                width: double.infinity,
                              ),
                              SizedBox(
                                height: responsive(13, context),
                              ),
                              Container(
                                width: responsive(364, context),
                                height: responsive(54, context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(responsive(5, context)),
                                    topLeft: Radius.circular(responsive(5, context)),
                                  ),
                                  color : Color.fromRGBO(242, 242, 242, 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if(_isRecording) Text(_recordingTime),
                                      if(_isRecording == false) Text(timeToShow),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color : Color.fromRGBO(242, 242, 242, 1),
                                        ),
                                        width: responsive(170, context),
                                        height: responsive(45, context),

                                        child: Visibility(
                                          visible: _isPlayingRecordedAudio,
                                          // visible: true,
                                          child: AudioProgressBars(
                                            progressPercentage: 100,
                                            listOfHeights: values,
                                            width: responsive(170, context),
                                            initalColor: AppColors.GlobelColor,
                                            backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
                                            progressColor: AppColors.GlobelColor,
                                            timeInMilliSeconds: totalDuration,
                                            isHorizontallyAnimated: true,
                                            isVerticallyAnimated: false,
                                          ),
                                        ),
                                      ),

                                      InkWell(
                                          onTap: (){
                                            _isPlayingRecordedAudio == true ? _stopAudio : _playAudio;
                                            print("Is Playing record audio: $_isPlayingRecordedAudio and stop audio $_stopAudio  and plau audio : $_playAudio");
                                          },
                                          child: Visibility(
                                              // visible: !isplaybutton,
                                              visible: true,
                                              child: _isPlayingRecordedAudio == true ? const Icon(Icons.pause) :const Icon(Icons.play_arrow_rounded))),
                                      InkWell(
                                          onTap: _isRecording ? _stopRecording : _startRecording,

                                          child: _isRecording == true ? const Icon(Icons.stop) :const Icon(Icons.mic)),
                                    ],
                                  ),
                                ),


                              ),
                              SizedBox(
                                height: responsive(20, context),
                              ),
                              PrimaryButton(
                                btnText: 'SUBMIT',
                                onPressed: () async {
                                  if (_globalKey.currentState!.validate()) {
                                    // title validation
                                    if (titleController.text.isEmpty) {
                                      setState(() {
                                        isTitleValidated = false;
                                      });
                                    } else {
                                      setState(() {
                                        isTitleValidated = true;
                                      });
                                    }
                                    // is your Situtaion validation
                                    if (yourSituationController.text.isEmpty) {
                                      setState(() {
                                        isYourSituationValidated = true;
                                        // borderColor = Colors.red;
                                      });
                                    } else {
                                      setState(() {
                                        isYourSituationValidated = true;
                                      });
                                    }

                                    if(_isRecording){
                                      isSuccess = false;
                                      isVisible = true;
                                      message = 'Recording is in progress';
                                      setState(() {

                                      });
                                    }

                                    if (isTitleValidated == true &&
                                        isYourSituationValidated == true && _isRecording == false)
                                    {
                     complaints.RaiseComplaint(
                       token:  user.isUser?.sessionToken,
                       number: booking.booking?.bookingNumber,
                       title:  titleController.text,
                       message: yourSituationController.text,
                     ).then((value) {
                       endLoading();
                     if(value == true){

                         Get.back();
                     }
                     else {
                      showSnackbar(context, complaints.cmessage);
                     }
                     }
                     );
                                      debugPrint('requesting data');


                                    }
                                  }
                                },
                                width: double.maxFinite,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}