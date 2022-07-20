import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ol_panthiya/note/note_screen.dart';
import 'package:ol_panthiya/size_config.dart';
import 'package:path/path.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../admob_service.dart';
import '../../globle.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class PlayVideo2 extends StatefulWidget {
  List<String> playList;
  PlayVideo2(this.playList);

  @override
  _PlayVideo2State createState() => _PlayVideo2State();
}

class _PlayVideo2State extends State<PlayVideo2> {
   YoutubePlayerController _controller;
   bool showItems = true;
   String initialVideoId = 'S_V-bAojIuw';
   double containerHeight = 1000.0;
   List<String> title;
   List<String> author;

   KeyboardVisibilityNotification _keyboardVisibility = new KeyboardVisibilityNotification();
   int _keyboardVisibilitySubscriberId;
   bool _keyboardState;
   bool showPlayList = true;

  Future<bool> _onBackPress(){
    return Future<bool>.value(true);
  }

  void runYoutubePlayer(int index){
    _controller = YoutubePlayerController(
      initialVideoId: widget.playList[index],
      params: YoutubePlayerParams(
        playlist: widget.playList,
        //startAt: const Duration(minutes: 1, seconds: 36),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: true,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
  }

  @override
  void initState() {
    runYoutubePlayer(0);
    _keyboardState = _keyboardVisibility.isKeyboardVisible;

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardState = visible;
        });
      },
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    };
    _controller.onExitFullscreen = () {
    };
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    int playingVideoNum;
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if(widget.playList.length == 1){
                        showItems = false;
                      }
                      return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        children: [
                          player,
                          YoutubeValueBuilder(
                            controller: _controller, // This can be omitted, if using `YoutubePlayerControllerProvider`
                            builder: (context, value) {
                              for(int i=0;widget.playList.length > i;i++){
                                if(widget.playList[i] == value.metaData.videoId){
                                    playingVideoNum = i; 
                                }
                              }
                                return Container(
                                  //height: 70.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: ListView.builder(
                                      itemCount: widget.playList.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      //scrollDirection: Axis.horizontal,
                                      itemBuilder: (context,index){
                                        bool visibleContainer = false;
                                        if(playingVideoNum == index){
                                          visibleContainer = true;
                                        }
                                        return InkWell(
                                          onTap: (){
                                            _controller.playVideoAt(index);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(right:8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 70.0,
                                                  width: 100.0,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          YoutubePlayerController.getThumbnail(
                                                            videoId:
                                                                _controller.params.playlist[index],
                                                            quality: ThumbnailQuality.medium,
                                                          ),
                                                        ),
                                                        //fit: BoxFit.fitWidth,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}