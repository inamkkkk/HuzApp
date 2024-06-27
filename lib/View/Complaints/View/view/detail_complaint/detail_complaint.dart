// import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:just_audio/just_audio.dart';

import '../../../../../Responsive/ResponsiveClass.dart';
import '../../../../../TextStyles/AppFonts.dart';
import '../../../../../TextStyles/Color.dart';
import '../../../../../TextStyles/styles.dart';
import '../../../../../utils/servecies.dart';



class DetailComplaint extends StatefulWidget {
  var packageName;
  var companyName;
  var complaintStatus;
  var customerPicture;
  var customerName;
  var customerPhone;
  var location;
  var date;
  var time;
  var complaintType;
  var complaint;
  var audio;

  DetailComplaint(
      {super.key,
      required this.audio,
      required this.packageName,
      required this.companyName,
      required this.complaintStatus,
      required this.customerName,
      required this.location,
      required this.date,
      required this.customerPhone,
      required this.time,
      required this.complaintType,
      required this.customerPicture,
      required this.complaint});

  @override
  State<DetailComplaint> createState() => _DetailComplaintState();
}

var baseurl;

class _DetailComplaintState extends State<DetailComplaint> {
  final _player = AudioPlayer();
  bool _isPlaying = false; // Track play/pause state

  Future<void> setUrl() async {
    print("${NetworkServices.ibaseUrl}${widget.audio}");
    await _player.setUrl("${NetworkServices.ibaseUrl}${widget.audio}");
  }

  @override
  void initState() {
    super.initState();
    setUrl();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.customerPicture.contains('/media/')) {
      baseurl = '${NetworkServices.ibaseUrl}';
    } else {
      baseurl = '${NetworkServices.ibaseUrl}/media/';
    }
    return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: appBarTitle(context: context, text: 'Complaint Detail'),
        ),
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: AppColors.grayboxcolor,
                  height: responsive(62, context),
                ),
                Positioned(
                  bottom: responsive(-33, context),
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: responsive(20, context)),
                    child: Container(
                      padding: EdgeInsets.all(responsive(15, context)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: AppColors.GlobelColor,
                            width: responsive(2, context)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textPoppins(
                                  text: widget.packageName,
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      AppColors.textSecondary.withOpacity(0.9),
                                  context: context),
                              textPoppins(
                                  text: widget.companyName,
                                  size: 12,
                                  fontWeight: FontWeight.w300,
                                  color:
                                      AppColors.textSecondary.withOpacity(0.9),
                                  context: context)
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: responsive(10, context),
                              vertical: responsive(3.5, context),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(responsive(4, context)),
                              color: Color(0xFFFF9F43).withOpacity(0.13),
                            ),
                            child: textPoppins(
                                text: widget.complaintStatus,
                                fontWeight: FontWeight.w400,
                                size: 12,
                                color: Color(0xFFFF9F43),
                                context: context),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(55,context),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: responsive(20, context)),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: responsive(2, context),
                          color: AppColors.borderColor,
                        )),
                    padding: EdgeInsets.all(responsive(15, context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Image.asset(
                                  "assets/images/user_icon.png",
                                  height: responsive(40, context),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/user_icon.png",
                                  height: responsive(40, context),
                                ),
                                imageUrl: '${baseurl}${widget.customerPicture}',
                                fit: BoxFit.cover,
                                width: responsive(40, context),
                                height: responsive(40, context),
                              ),
                            ),
                            horizontalSpace(08,context),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textPoppins(
                                    text: widget.customerName,
                                    size: 14,
                                    fontFamily: AppFonts.poppinsSemiBold,
                                    color: AppColors.textSecondary
                                        .withOpacity(0.8),
                                    context: context),
                                textPoppins(
                                    text: widget.location,
                                    color: AppColors.textSecondary
                                        .withOpacity(0.8),
                                    size: 12,
                                    fontWeight: FontWeight.w300,
                                    context: context),
                              ],
                            ),
                          ],
                        ),
                        verticalSpace( 20, context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textPoppins(
                                    text: "Raised date & time",
                                    size: 10,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.textSecondary
                                        .withOpacity(0.5),
                                    context: context),
                                Row(
                                  children: [
                                    textPoppins(
                                        text: widget.date,
                                        size: 13,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textSecondary
                                            .withOpacity(0.8),
                                        context: context),
                                    horizontalSpace( 3, context),
                                    textPoppins(
                                        text: widget.time,
                                        size: 13,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColor
                                            .withOpacity(0.8),
                                        context: context),
                                  ],
                                ),
                                verticalSpace(10,context),
                                textPoppins(
                                    text: widget.complaintType,
                                    fontWeight: FontWeight.w500,
                                    size: 14,
                                    color: AppColors.textSecondary
                                        .withOpacity(0.8),
                                    context: context),
                              ],
                            ),
                          ],
                        ),
                        verticalSpace( 10, context),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textPoppins(
                                text: "Complaint Message",
                                fontWeight: FontWeight.w300,
                                size: 10,
                                color: AppColors.textSecondary.withOpacity(0.5),
                                context: context),
                            verticalSpace( 5, context),
                            Container(
                              padding: EdgeInsets.only(
                                  bottom: responsive(10, context)),
                              child: textPoppins(
                                  text: widget.complaint,
                                  size: 12,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      AppColors.textSecondary.withOpacity(0.8),
                                  context: context),
                            ),
                            Visibility(
                              visible: widget.audio!=null?true:false,
                              child: StreamBuilder<Duration>(
                                  stream: _player.positionStream,
                                  builder: (context, snapshot) {
                                    final duration =
                                        _player.duration ?? Duration.zero;
                                    return StreamBuilder<Duration>(
                                      stream: _player.positionStream,
                                      builder: (context, snapshot) {

                                        var position = snapshot.data ?? Duration.zero;
                                        if(position.inSeconds!=0){
                                          if(position.inSeconds == duration.inSeconds){
                                            print('you have came back brother');
                                            position = Duration.zero;
                                            setUrl();
                                            _isPlaying = false;
                                             _player.pause();
                                            // setState(() {
                                            //
                                            // });

                                          }
                                        }


                                        print('position is :${position.inSeconds}');
                                        print('position is :${duration.inSeconds}');



                                        return Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                _togglePlayback();
                                              },
                                              child: CircleAvatar(
                                                radius: responsive(13, context),
                                                backgroundColor:
                                                    AppColors.primaryfade,
                                                child: Icon(_isPlaying
                                                    ? Icons.stop
                                                    : Icons.play_arrow,size: responsive(15, context),),
                                              ),
                                            ),
                                            SizedBox(
                                              width: responsive(08, context),
                                            ),

                                            textPoppins(
                                                text: formatDuration(
                                                    position.inSeconds),
                                                size: 13,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.primaryColor
                                                    .withOpacity(0.8),
                                                context: context),

                                            Expanded(
                                              child: SliderTheme(
                                                data: SliderThemeData(
                                                  thumbColor:
                                                      AppColors.primaryColor,
                                                  // set the color of the thumb
                                                  activeTrackColor:
                                                      AppColors.primaryColor,
                                                  // set the color of the active track
                                                  inactiveTrackColor: Colors.grey,
                                                  // set the color of the inactive track
                                                  overlayColor: Colors.blue
                                                      .withOpacity(0.2),
                                                  // set the color of the overlay
                                                  thumbShape:
                                                      RoundSliderThumbShape(
                                                          enabledThumbRadius: 5),
                                                  // set the shape of the thumb
                                                  overlayShape:
                                                      const RoundSliderOverlayShape(
                                                          overlayRadius: 20),
                                                  // set the shape of the overlay
                                                  trackHeight: 1.5,
                                                ),
                                                child: Slider(
                                                  value: position.inSeconds
                                                      .toDouble(),
                                                  min: 0,

                                                  onChanged: (value) async {
                                                    position = Duration(
                                                        seconds: value.toInt());
                                                    print('position is :${position.inSeconds}');
                                                    print('position is :${duration.inSeconds}');
                                                    // if(position == duration.inSeconds) {
                                                    //   print('stream ended');
                                                    //   _isPlaying = true;
                                                    //   position = Duration.zero;
                                                    //   _player.pause();
                                                    //   setState(() {
                                                    //
                                                    //   });
                                                    // }
                                                    await _player.seek(position);

                                                  },
                                                  max: duration.inSeconds
                                                      .toDouble(),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: responsive(17, context)),
                                              child: textPoppins(
                                                  text: formatDuration(
                                                      duration.inSeconds),
                                                  size: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.primaryColor
                                                      .withOpacity(0.8),
                                                  context: context),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: responsive(-10, context),
                    left: responsive(15, context),
                    child: Container(
                      width: responsive(130, context),
                      color: Colors.white,
                      child: Center(
                        child: textPoppins(
                            text: "Complaint Details",
                            size: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary.withOpacity(0.9),
                            context: context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  String formatDuration(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void _togglePlayback() async {
    if (_isPlaying) {
      print('not playing');
      setState(() {
        _isPlaying = !_isPlaying;
      });
      await _player.pause();
    } else {
      print('playing');
      setState(() {
        _isPlaying = !_isPlaying;
      });
       // await setUrl(); // Set URL before playing
      await _player.play();
    }
  }
}

class NetworkAudioPlayer extends StatefulWidget {
  @override
  _NetworkAudioPlayerState createState() => _NetworkAudioPlayerState();
}

class _NetworkAudioPlayerState extends State<NetworkAudioPlayer> {
  // late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  bool isPaused = false;
  bool isStopped = true;
  Duration duration = Duration();
  Duration position = Duration();
  String audioUrl =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'; // Replace with your audio URL

  @override
  void initState() {
    super.initState();
    // _audioPlayer = AudioPlayer();
    // _audioPlayer.onDurationChanged.listen((Duration d) {
    //   setState(() => duration = d);
    // });
    // _audioPlayer.onAudioPositionChanged.listen((Duration p) {
    //   setState(() => position = p);
    // });
  }

  @override
  void dispose() {
    // _audioPlayer.dispose();
    super.dispose();
  }

  // void play() async {
  //   // int result = await _audioPlayer.play(audioUrl);
  //   if (result == 1) {
  //     setState(() {
  //       isPlaying = true;
  //       isPaused = false;
  //       isStopped = false;
  //     });
  //   }
  // }
  //
  // void pause() async {
  //   int result = await _audioPlayer.pause();
  //   if (result == 1) {
  //     setState(() {
  //       isPlaying = false;
  //       isPaused = true;
  //     });
  //   }
  // }
  //
  // void stop() async {
  //   int result = await _audioPlayer.stop();
  //   if (result == 1) {
  //     setState(() {
  //       isPlaying = false;
  //       isPaused = false;
  //       isStopped = true;
  //       position = Duration();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // play();
          },
          child: Image.asset(
            "assets/images/play.png",
            height: responsive(24, context),
          ),
        ),
        horizontalSpace( 15, context),
        textPoppins(
            text: "00.00",
            size: 10,
            color: Color(0xFF4EB298),
            context: context),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: SliderComponentShape.noThumb, // Remove the thumb
            ),
            child: Slider(
              activeColor: Color(0xFF4EB298),
              inactiveColor: Color(0xFFD9D9D9),
              value: position.inSeconds.toDouble(),
              max: duration.inSeconds.toDouble(),
              onChanged: (double value) async {
                // await _audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),
          ),
        ),
        textPoppins(
            text: "06.00",
            size: 10,
            color: Color(0xFF4EB298),
            context: context),
      ],
    );
  }
}
