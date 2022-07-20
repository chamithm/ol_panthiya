import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ol_panthiya/size_config.dart';
import '../admob_service.dart';
import 'video_page/play_video2.dart';

class EnglishCourse extends StatefulWidget {
  List<dynamic> videoLink;

  EnglishCourse(this.videoLink);
  @override
  _EnglishCourseState createState() => _EnglishCourseState();
}

class _EnglishCourseState extends State<EnglishCourse> {
  double item;
  int itemCount;

  // List<DocumentSnapshot> videoLink = [];
  // bool isLoading = false;

  // getLink() async{
  //   videoLink = await getAllLink();
  //   if(videoLink.length != 0){
  //     setState(() {
  //       isLoading = true;
  //     });
  //   }
  // }

  // Future<List<DocumentSnapshot>> getAllLink() {
  //   // return Firestore.instance.collection('chandu_aiya_english_course').getDocuments().then((snap){
  //   //   return snap.documents;
  //   // });
  //   return FirebaseFirestore.instance.collection('chandu_aiya_english_course').get().then((snap){
  //     return snap.docs;
  //   });
  // }

  int convert(){
    item = widget.videoLink.length / 2;
    itemCount = item.round();
    return itemCount;
  }
  
  @override
  void initState() {
    //getLink();
    super.initState();
  }

  // @override
  // void deactivate() {
  //   //if(isLoading){
  //     for(int i=0;i<2;i++){
  //       YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink[i]),).pause();
  //     }
  //   //}
  //   super.deactivate();
  // }

  // @override
  // void dispose() {
  //   //if(isLoading){
  //     for(int i=0;i<2;i++){
  //       YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink[i]),).dispose();
  //     }
  //   //}
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("English Course"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical : 4.0),
        child: ListView.builder(
          itemCount: convert(),
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.only(left: 6.0,right: 6.0,top: 4.0,bottom: 4.0),
              child: InkWell(
                onTap: (){
                  print("click on me");
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => PlayVideo2(widget.videoLink[index * 2])));
                },
                child: Column(
                  children: [
                    // Container(
                    //   width: 43.12 * SizeConfig.heightMultiplier,
                    //   child: YoutubePlayer(
                    //     controller: YoutubePlayerController(
                    //       initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink[index * 2]),
                    //       flags: YoutubePlayerFlags(
                    //         autoPlay: false,
                    //         hideControls: true,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height: 25.0,
                      width: 43.12 * SizeConfig.heightMultiplier,
                      color: Colors.black87,
                      child: Padding(
                        padding: const EdgeInsets.only(left:4.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom:4.0),
                              child: Icon(Icons.play_arrow,color: Colors.white,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text(widget.videoLink[(index * 2) + 1],style: TextStyle(fontSize: 13.0,color: Colors.white),),
                            ),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: AdWidget(
          key: UniqueKey(),
          ad: AdMobService.createBannerAd()..load(),
        ),
      ),
    );
  }
}