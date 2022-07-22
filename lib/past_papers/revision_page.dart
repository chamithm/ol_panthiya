import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ol_panthiya/note/note_screen.dart';
import 'package:ol_panthiya/video/video_page/play_video.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../images.dart';

class RevisionPage extends StatefulWidget {
  String lan;
  RevisionPage(this.lan);
  @override
  State<RevisionPage> createState() => _RevisionPageState();
}

class _RevisionPageState extends State<RevisionPage> {
  List<Color> containerColor = [Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white];
  
  @override
  Widget build(BuildContext context) {
    //EasyLocalization.of(context).locale = Locale(widget.lan);
    return DefaultTabController(  
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey[900],
          elevation: 0.0,
          title: Text("Revision",style: TextStyle(color: Colors.white,fontSize: 14.0),),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: TabBar(
              isScrollable: true,
              indicatorWeight: 4.0,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.white,
              labelColor: Colors.red[100],
              // onTap: (index){
              //   setState(() {
              //     containerColor[index] = Colors.blue[200];
              //     for(int i=0;i<6;i++){
              //       if(i != index){
              //         containerColor[i] = Colors.white;
              //       }
              //     }
              //   });
              // },
              tabs: [
                Column(
                  children: [
                    Container(
                      width:50.0,
                      height:50.0,
                      decoration:BoxDecoration(
                        color: containerColor[0],
                        borderRadius: BorderRadius.circular(50.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey[700],
                          child: Icon(Icons.calculate)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text("S1".tr().toString(),style: TextStyle(fontSize:12.0),),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width:50.0,
                      height:50.0,
                      decoration:BoxDecoration(
                        color: containerColor[1],
                        borderRadius: BorderRadius.circular(50.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey[700],
                          child: Icon(Icons.science_outlined)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text("S2".tr().toString(),style: TextStyle(fontSize:12.0),),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width:50.0,
                      height:50.0,
                      decoration:BoxDecoration(
                        color: containerColor[2],
                        borderRadius: BorderRadius.circular(50.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey[700],
                          child: Icon(Icons.language)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text("S3".tr().toString(),style: TextStyle(fontSize:12.0),),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width:50.0,
                      height:50.0,
                      decoration:BoxDecoration(
                        color: containerColor[3],
                        borderRadius: BorderRadius.circular(50.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey[700],
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:8.0),
                            child: Text("අ",style: TextStyle(fontSize:26.0)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text("S4".tr().toString(),style: TextStyle(fontSize:12.0),),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width:50.0,
                      height:50.0,
                      decoration:BoxDecoration(
                        color: containerColor[4],
                        borderRadius: BorderRadius.circular(50.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey[600],
                          child: Image.asset(
                            Images.darmachakra,
                            width: 25.0,
                            height: 25.0,
                            color: Colors.blue[100],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text("S5".tr().toString(),style: TextStyle(fontSize:12.0),),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width:50.0,
                      height:50.0,
                      decoration:BoxDecoration(
                        color: containerColor[5],
                        borderRadius: BorderRadius.circular(50.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey[700],
                          child: Icon(Icons.filter_hdr_outlined)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text("S6".tr().toString(),style: TextStyle(fontSize:12.0),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SelectSubject("ගණිතය","lan".tr().toString()),
            SelectSubject("විද්‍යාව","lan".tr().toString()),
            SelectSubject("English","si"),
            SelectSubject("සිංහල","si"),
            SelectSubject("බුද්ධ ධර්මය","si"),
            SelectSubject("ඉතිහාසය","si"),
            // DounloadPastPapers("S1","maths","lan".tr().toString()),
            // DounloadPastPapers("S2","science","lan".tr().toString()),
            // DounloadPastPapers("S3","english","si"),
            // DounloadPastPapers("S4","sinhala","si"),
            // DounloadPastPapers("S5","buddhist","si"),
            // DounloadPastPapers("S6","history","si"),
          ], 
        ),
      )
    );
  }
}

class SelectSubject extends StatefulWidget {
  String subject_name;
  String lan;

  SelectSubject(this.subject_name,this.lan);
  @override
  State<SelectSubject> createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:12.0,left: 12.0,right: 12.0),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.blueGrey[800],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueGrey[700],
            elevation: 0.0,
            title: Text(widget.subject_name.tr().toString(),style: TextStyle(color: Colors.blue[50],fontSize: 13.0),),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(10.0), 
                child: TabBar(
                  isScrollable: false,
                  indicatorWeight: 1.0,
                  indicatorColor: Colors.red[50],
                  unselectedLabelColor: Colors.blue[50],
                  labelColor: Colors.red[50],
                  tabs: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom:4.0),
                      child: Text("Youtube Tutorials",style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:4.0),
                      child: Text("Your Notes",style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
          ),
          body:TabBarView(
            children: [
              VideoP(widget.subject_name),
              NoteScreen(Container(),widget.subject_name),
            ], 
          ),
        ),
      ),
    );
  }
}

class VideoP extends StatefulWidget {
  String subject_name;
  VideoP(this.subject_name);
  @override
  State<VideoP> createState() => _VideoPState();
}

class _VideoPState extends State<VideoP> {
  List<DocumentSnapshot> videoLink = [];
  int indexNum;
  NativeAd _ad;
  bool isLoaded = false;
  bool isLoading = false;
  YoutubePlayerController _controller;
  List<dynamic> videoLinks;
  List<String> paperLinks = [];
  List<dynamic> paperLinksAll;

  getLink() async{
    videoLink = await getAllLink();
    print("video liks in revision ${videoLink[0]['L1'].length}");
    videoLinks = videoLink[0]['L1'];
    paperLinksAll = videoLink[1]['L1'];

    if(videoLink.length != 0){
      setState(() {
        isLoading = true;
      });
    }
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

  Future<List<DocumentSnapshot>> getAllLink() {
    // return Firestore.instance.collection('buddhist10').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection(widget.subject_name).get().then((snap){
      return snap.docs;
    });
  }

  @override
  void initState(){
    getLink();
    print("subject name in revision ${widget.subject_name}");
    loadNativeAd();
    if(videoLink.length == 1){
      indexNum = 1;
    }
    else{
      indexNum = 2;
    }
    //runYoutubePlayer(0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    _ad.dispose();
    super.dispose();
  }

  List<String> video_duration(int index){
    List<String> duration = [];
    for(int i=0;i<videoLinks[index]['1'].length;i++){
      if(i.isOdd){
        duration.add(videoLinks[index]['1'][(i)]);
      }
    }
    return duration;
  }

  List<String> paper_links(int index){
    List<String> paper_links = [];
    for(int i=0;i<paperLinksAll[index]['1'].length;i++){
      paper_links.add(paperLinksAll[index]['1'][(i)]);
    }
    return paper_links;
  }

  List<String> runYoutubePlayer(int index){
    //print("chamith ${widget.videoLink}");
    String initialVideoId = videoLinks[index]['1'][0];
    //print("initoal video id $initialVideoId");
    List<String> playList = [];
    for(int i=0;i<videoLinks[index]['1'].length;i++){
      if(i.isEven){
        String url = YoutubePlayerController.convertUrlToId(videoLinks[index]['1'][(i)]);
        playList.add(url);
      }
    }
    for(int i=0;i<videoLinks[index]['1'].length;i++){
      if(i % 3 == 2){
        paperLinks.add(videoLinks[index]['1'][(i)]);
      }
    }
    print("play list $playList");
    print("duration  $paperLinks");
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: isLoading ? Container(
        margin: EdgeInsets.symmetric(vertical : 4.0),
        child: ListView.builder(
          itemCount: videoLinks.length + 1,
          itemBuilder: (context,index){
            List<String> playList;
            List<String> duration;
            List<String> paper_link;
            // List<String> playList = runYoutubePlayer(index);
            // List<String> duration = video_duration(index);
            // List<String> paper_link = paper_links(index);
            bool visibleList = false;
            if(index < indexNum){
              playList = runYoutubePlayer(index);
              duration = video_duration(index);
              paper_link = paper_links(index);
              if(playList.length > 1){
                visibleList = true;
              }
            }

            if(index > indexNum){
              playList = runYoutubePlayer(index - 1);
              duration = video_duration(index - 1);
              paper_link = paper_links(index);
              if(playList.length > 1){
                visibleList = true;
              }
            }
            if(index == indexNum){
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
                margin: EdgeInsets.only(left: 28.0,right: 6.0,top: 4.0,bottom: 4.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlayVideo(playList,widget.subject_name,duration,true,paper_link)));
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
      ) : CircularProgressIndicator(),
    );
  }
}