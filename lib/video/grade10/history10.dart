import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ol_panthiya/video/video_page/video_page.dart';
import 'package:easy_localization/easy_localization.dart';

class History10 extends StatefulWidget {
  @override
  _History10State createState() => _History10State();
}

class _History10State extends State<History10> {

  var lessions = [
    {
      "name":"ඉතිහාසය හැදෑරීමේ මූලාශ්‍රය",
      "icon":"1",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"ශ්‍රී ලංකාව ජනාවාස වීම",
      "icon":"2",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"ශ්‍රී ලංකාවේ දේශපාලන බලය විකාශය වීම",
      "icon":"3",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"ශ්‍රී ලංකාවේ පැරණි සමාජය",
      "icon":"4",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"ශ්‍රී ලංකාවේ පැරණි විද්‍යාව සහ තාක්ෂණය",
      "icon":"5",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"ඵෙතිහාසික දැනුම සහ එහි ප්‍රායෝගික ආදේශණය",
      "icon":"6",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"වියළි කළාපයේ පැරණි නගර පිරිහීම හා නව රාජධානි බිහි වීම",
      "icon":"7",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"මහනුවර රාජධානිය",
      "icon":"8",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"පුනරුදය",
      "icon":"9",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"ශ්‍රී ලංකාව හා බටහිර ලෝකය",
      "icon":"10",
      "color":Colors.blueGrey[200],
    },
  ];  

  List<DocumentSnapshot> videoLink = [];
  bool isLoading = false;

  @override
  void initState(){
    getLink();
    super.initState();
  }

  getLink() async{
    videoLink = await getAllLink();
    print("video links is ${videoLink[0]['L1'][0]['1']}");
    if(videoLink.length != 0){
      setState(() {
        isLoading = true;
      });
    }
  }

  Future<List<DocumentSnapshot>> getAllLink() {
    // return Firestore.instance.collection('history10_s').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('history10_s').get().then((snap){
      return snap.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:14.0,right: 14.0),
      child: Scaffold(
        backgroundColor: Colors.blueGrey[800],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey[700],
          elevation: 0.0,
          title: Text("S6".tr().toString(),style: TextStyle(color: Colors.white,fontSize: 13.0),),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left:14.0,top: 10.0),
          child: isLoading ? Container(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(bottom:16.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(videoLink[0]['L${index+1}'],lessions[index]['name'])));
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15.0,
                            backgroundColor: lessions[index]["color"],
                            child:Text(lessions[index]["icon"],style: TextStyle(fontSize: 15.0,color: Colors.black),), 
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text(lessions[index]['name'],style: TextStyle(color: Colors.white,fontSize: 14.0),),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          ) : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}