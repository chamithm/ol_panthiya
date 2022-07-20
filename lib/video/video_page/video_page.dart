import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ol_panthiya/note/note_screen.dart';
import 'package:ol_panthiya/size_config.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../admob_service.dart';
import 'play_video.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPage extends StatefulWidget {
  List<dynamic> videoLink;
  String subject;

  VideoPage(this.videoLink,this.subject);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  Future<bool> _onBackPress(){
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: AppBar(
              backgroundColor: Colors.blueGrey[700],
              centerTitle: true,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)
              ),
              title: Text(widget.subject,textAlign: TextAlign.center,),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(30.0),
                child: TabBar(
                  //isScrollable: true,
                  indicatorColor: Colors.white,
                  indicatorWeight: 4.0,
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.only(bottom:6.0),
                      child: Text("Youtube Tutorials",
                        style: TextStyle(color: Colors.white,fontSize: 14.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:6.0),
                      child: Text("Your Notes",
                        style: TextStyle(color: Colors.white,fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              YoutubeTutorials(widget.videoLink,widget.subject),
              YourNotes(widget.subject),
            ], 
          ),
        ),
      ),
    );
  }
}

class YoutubeTutorials extends StatefulWidget {
  List<dynamic> videoLink;
  String subject;

  YoutubeTutorials(this.videoLink,this.subject);
  @override
  _YoutubeTutorialsState createState() => _YoutubeTutorialsState();
}

class _YoutubeTutorialsState extends State<YoutubeTutorials> {
  double item;
  int indexNum;
  NativeAd _ad;
  bool isLoaded = false;
  bool isAdShow = false;
  int itemCount;
  YoutubePlayerController _controller;

  List<String> video_duration(int index){
    List<String> duration = [];
    for(int i=0;i<widget.videoLink[index]['1'].length;i++){
      if(i.isOdd){
        duration.add(widget.videoLink[index]['1'][(i)]);
      }
    }
    return duration;
  }
  
  void loadNativeAd(){
    _ad = NativeAd(
      adUnitId: "ca-app-pub-5630497991413712/6198002215",
      factoryId: 'listTile',
      listener: NativeAdListener(
        onAdLoaded: (ad){
          setState(() {
            isLoaded = true;    
          });
        },
        onAdFailedToLoad: (ad,error){
          ad.dispose();
          print("Faild to load ad in video_page ${error.message}, ${error.code}");
          setState(() {
            isLoaded = false;      
          });
        } 
      ),
      request: AdRequest(),
    );
    _ad.load();
  }

  List<String> runYoutubePlayer(int index){
    //print("chamith ${widget.videoLink}");
    String initialVideoId = widget.videoLink[index]['1'][0];
    //print("initoal video id $initialVideoId");
    List<String> playList = [];
    for(int i=0;i<widget.videoLink[index]['1'].length;i++){
      if(i.isEven){
        String url = YoutubePlayerController.convertUrlToId(widget.videoLink[index]['1'][(i)]);
        playList.add(url);
      }
    }
    print("play list $playList");
    _controller = YoutubePlayerController(
      initialVideoId: initialVideoId,
      params: YoutubePlayerParams(
        playlist: playList,
        startAt: const Duration(minutes: 1, seconds: 36),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: true,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    return playList;
  }
  
  @override
  void initState() {
    //convert();
    //print("chamith ${widget.videoLink[0]['1']}");
    //runYoutubePlayer();
    loadNativeAd();

    if(widget.videoLink.length == 1){
      indexNum = 1;
    }
    else{
      indexNum = 2;
    }
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
    _ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        margin: EdgeInsets.symmetric(vertical : 4.0),
        child: ListView.builder(
          itemCount: widget.videoLink.length + 1,
          itemBuilder: (context,index){
            List<String> playList;
            List<String> duration;
            bool visibleList = false;

            if(index < indexNum){
              playList = runYoutubePlayer(index);
              duration = video_duration(index);
              if(playList.length > 1){
                visibleList = true;
              }
            }

            if(index > indexNum){
              playList = runYoutubePlayer(index - 1);
              duration = video_duration(index - 1);
              if(playList.length > 1){
                visibleList = true;
              }
            }
            
            if(index == indexNum){
              isAdShow = true;
              if(isLoaded){
                return Container(
                  margin: EdgeInsets.only(left: 6.0,right: 6.0,top: 4.0,bottom: 4.0),
                  height: 180.0,
                  width: 320,
                  child: AdWidget(ad: _ad),
                );
              }
              else{
                return Container();
              }
            }
            else{
              return Container(
                margin: EdgeInsets.only(left: 6.0,right: 6.0,top: 4.0,bottom: 4.0),
                height: 180.0,
                width: 320,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlayVideo(playList,widget.subject,duration,true,[])));
                  },
                  child: YoutubeValueBuilder(
                    controller: _controller,
                    builder: (context, value) {
                      return Container(
                        height: 180.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                YoutubePlayerController.getThumbnail(
                                  videoId:
                                      _controller.params.playlist.first,
                                  quality: ThumbnailQuality.medium,
                                ),
                              ),
                              //fit: BoxFit.fitWidth,
                            ),
                          ),
                          child: visibleList ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Visibility(
                              visible: visibleList,
                              child: Container(
                                height: 24.0,
                                width: 320,
                                color: Colors.black45,
                                child: Image.asset(
                                  'assests/images/videoSet.png',
                                  height: 60.0,
                                  width: 60.0,
                                  //fit: BoxFit.none,
                                ),//Text("$num",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)
                              ),
                            )
                          ) : Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 320,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right:6.0,bottom: 6.0),
                                  child: Container(
                                    //color: Colors.black87,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black87,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(duration[0],style: TextStyle(color: Colors.white,fontSize: 11.0),),
                                    )
                                  ),
                                )
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          }
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 50.0,
      //   color: Colors.grey[900],
      //   child: AdWidget(
      //     key: UniqueKey(),
      //     ad: AdMobService.createBannerAd()..load(),
      //   ),
      // ),
    );
  }
}

class YourNotes extends StatefulWidget {
  String subject;
  YourNotes(this.subject);
  @override
  _YourNotesState createState() => _YourNotesState();
}

class _YourNotesState extends State<YourNotes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: NoteScreen(Container(),widget.subject),
    );
  }
}
