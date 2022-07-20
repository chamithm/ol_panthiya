import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ol_panthiya/size_config.dart';
import 'package:ol_panthiya/video/video_page/play_video2.dart';

import '../admob_service.dart';

class ModelPapers extends StatefulWidget {
  List<dynamic> videoLink;

  ModelPapers(this.videoLink);
  @override
  _ModelPapersState createState() => _ModelPapersState();
}

class _ModelPapersState extends State<ModelPapers> {
  double item;
  int itemCount;

  // List<DocumentSnapshot> videoLink = [];
  // bool isLoading = false;
  // List<dynamic> videoLinks;

  // getLink() async{
  //   videoLink = await getAllLink();
  //   if(videoLink.length != 0){
  //     setState(() {
  //       isLoading = true;
  //     });
  //   }
  //   videoLinks = videoLink[0]["L1"];
  // }

  // Future<List<DocumentSnapshot>> getAllLink() {
  //   // return Firestore.instance.collection('motivation').getDocuments().then((snap){
  //   //   return snap.documents;
  //   // });
  //   return FirebaseFirestore.instance.collection('motivation').get().then((snap){
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
  //     for(int i=0;i<itemCount;i++){
  //         YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink[i * 2]),).pause();
  //     }
  //   //}
  //   super.deactivate();
  // }

  // @override
  // void dispose() {
  //   //if(isLoading){
  //     for(int i=0;i<itemCount;i++){
  //         YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink[i * 2]),).dispose(); 
  //     }
  //   //}
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        margin: EdgeInsets.symmetric(vertical : 4.0),
        child: ListView.builder(
          itemCount: convert(),
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.only(left: 6.0,right: 6.0,top: 4.0,bottom: 4.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PlayVideo2(widget.videoLink[index * 2])));
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
                      color: Colors.blueGrey[800],
                      child: Padding(
                        padding: const EdgeInsets.only(left:4.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom:4.0),
                              child: Icon(Icons.play_arrow,color: Colors.blue[50],),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text(widget.videoLink[(index * 2) + 1],style: TextStyle(fontSize: 13.0,color: Colors.blue[50]),),
                            ),
                          ],
                        ),
                      )),
                  ],
                ),
              ),
            );
          }
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.grey[900],
        child: AdWidget(
          key: UniqueKey(),
          ad: AdMobService.createBannerAd()..load(),
        ),
      ),
    );
  }
}