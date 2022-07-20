import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ol_panthiya/note/note_screen.dart';
import 'package:ol_panthiya/size_config.dart';
import 'package:path/path.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//import '../../admob_service.dart';
import '../../globle.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import '../../responsive_widget.dart';

class PlayVideo extends StatefulWidget {
  List<String> playList;
  String subject;
  List<String> duration;
  bool showNote;
  List<String> paperLinks;
  PlayVideo(this.playList,this.subject,this.duration,this.showNote,this.paperLinks);

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
   YoutubePlayerController _controller;
   bool showItems = true;
   double containerHeight = 1000.0;

   KeyboardVisibilityNotification _keyboardVisibility = new KeyboardVisibilityNotification();
   int _keyboardVisibilitySubscriberId;
   bool _keyboardState;
   bool showPlayList = true;

  Future<bool> _onBackPress(){
    return Future<bool>.value(true);
  }

  void runYoutubePlayer(int index){
    _controller = YoutubePlayerController(
      initialVideoId: widget.playList[0],
      params: YoutubePlayerParams(
        playlist: widget.playList,
        autoPlay: true,
        //origin: 'https://play.google.com/log?format=json&hasfast=true&authuser=0',
        //startAt: const Duration(minutes: 1, seconds: 36),
        showControls: true,
        enableCaption: true,
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
    Globle.showItem= true;
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

      print("im in full screen........");
    };
    _controller.onExitFullscreen = () {
    }; 
    _controller.seekTo(Duration(
      seconds: _controller.value.position.inSeconds + 10)
    );
    super.initState();
  }

  _launchURL(String link) async {
    await FlutterWebBrowser.openWebPage(url: link);
  }

  // @override
  // void deactivate() {
  //   _controller.pause();
  //   super.deactivate();
  // }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    int playingVideoNum;
    print("screen height is ${MediaQuery.of(context).size.height}");
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
                          Padding(
                            padding: const EdgeInsets.only(bottom:6.0),
                            child: Container(
                              height: 30.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.fast_rewind,color: Colors.white70,size: 20),
                                    onPressed: (){
                                      _controller.seekTo(Duration(
                                        seconds: _controller.value.position.inSeconds - 10)
                                      );
                                    },
                                  ),
                                  SizedBox(width: 30.0,),
                                  IconButton(
                                    icon: Icon(
                                      _controller.value.playerState == PlayerState.playing
                                        ? Icons.play_arrow
                                        : Icons.pause,
                                      color: Colors.white70,
                                      size: 20,
                                    ),
                                    onPressed:() {
                                      _controller.value.playerState == PlayerState.playing
                                          ? context.ytController.pause()
                                          : context.ytController.play();
                                      setState(() {
                                                                              
                                      });
                                    }
                                  ),
                                  SizedBox(width: 30.0,),
                                  IconButton(
                                    icon: Icon(Icons.fast_forward,color: Colors.white70,size: 20),
                                    onPressed: (){
                                      _controller.seekTo(Duration(
                                        seconds: _controller.value.position.inSeconds + 10)
                                      );
                                    },
                                  ),
                                ]
                              ),
                            ),
                          ),
                          YoutubeValueBuilder(
                            controller: _controller, // This can be omitted, if using `YoutubePlayerControllerProvider`
                            builder: (context, value) {
                              bool show_link = false;
                              for(int i=0;widget.playList.length > i;i++){
                                if(widget.playList[i] == value.metaData.videoId){
                                  playingVideoNum = i; 
                                }
                              }
                              if(playingVideoNum != null){
                                show_link = true;
                                print("playingVideoNum is...................................... $playingVideoNum");
                              }
                              print("player isReady ${value.playerState}  playingVideoNum $playingVideoNum");
                                return AnimatedSwitcher(
                                  duration: Duration(seconds: 1),
                                  transitionBuilder: (Widget child, Animation<double> animation) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: SizeTransition(child:
                                    child,
                                      sizeFactor: animation,
                                      axis: Axis.vertical,
                                    ),
                                  ),
                                  child: Globle.showItem ? Visibility(
                                    visible: showItems,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        show_link && widget.paperLinks.isNotEmpty ? InkWell(
                                          onTap: (){
                                            _launchURL(widget.paperLinks[playingVideoNum]);
                                          },
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom:6.0),
                                              child: Container(
                                                width: 300.0,
                                                child: Text(
                                                  "Paper Link : ${widget.paperLinks[playingVideoNum]}",
                                                  style: TextStyle(color: Colors.blue[100],fontSize: 12.0),
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  overflow: TextOverflow.fade,
                                                )
                                              ),
                                            ),
                                          ),
                                        ) : Container(),
                                        Container(
                                          height: 70.0,
                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:8.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  ListView.builder(
                                                    itemCount: widget.playList.length,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder: (context,index){
                                                      bool visibleContainer = false;
                                                      if(playingVideoNum == index){
                                                        visibleContainer = true;
                                                        show_link = true;
                                                      }
                                                      return InkWell(
                                                        onTap: (){
                                                          _controller.playVideoAt(index);
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right:8.0),
                                                          child: Stack(
                                                            alignment: AlignmentDirectional.center,
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
                                                                  child: Align(
                                                                    alignment: Alignment.bottomRight,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(right:2.0,bottom: 8.0),
                                                                      child: Container(
                                                                        //color: Colors.black87,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          color: Colors.black87,
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(3.0),
                                                                          child: Text(widget.duration[index],style: TextStyle(color: Colors.white,fontSize: 9.0),),
                                                                        )
                                                                      ),
                                                                    )
                                                                  ),
                                                                ),
                                                              ),
                                                              Visibility(
                                                                visible: visibleContainer,
                                                                child: Container(
                                                                  height: 56.0,
                                                                  width: 100.0,
                                                                  color: Colors.black54,
                                                                ),
                                                              ),
                                                              Visibility(
                                                                visible: visibleContainer,
                                                                child: Center(
                                                                  child: Icon(Icons.play_arrow,color: Colors.white,)
                                                                )
                                                              ),
                                                              Positioned(
                                                                // alignment: Alignment.topLeft,
                                                                top: 0,
                                                                left: 0,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(top:8.0,left: 2.0),
                                                                  child: Container(
                                                                    width:12.0,
                                                                    height:12.0,
                                                                    decoration:BoxDecoration(
                                                                      color: Colors.black87,
                                                                      borderRadius: BorderRadius.circular(50.0)
                                                                    ),
                                                                    child: Center(child: Text("${index + 1}",style: TextStyle(color: Colors.white,fontSize: 7.0),)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.arrow_back_ios,color: Colors.white70,size: 15),
                                                    onPressed: (){
                                                      setState(() {
                                                        Globle.showItem = !Globle.showItem;                           
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) : Container(),
                                );
                              },
                            ),
                            Visibility(
                              visible: showItems,
                              child: Center(
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      Globle.showItem = !Globle.showItem;
                                   });
                                  },
                                  child: Container(
                                    height: 16.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0),bottomRight: Radius.circular(5.0)),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Icon(Globle.showItem ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,color: Colors.blue[100],size: 20.0,),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: widget.showNote,
                  child: Container(
                    height: _keyboardState ? 200.0 : MediaQuery.of(context).size.height /  1.5,
                    child: NoteScreen(Container(),widget.subject)
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