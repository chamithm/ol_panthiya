import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ol_panthiya/video/video_page/video_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class Sinhala10 extends StatefulWidget {
  @override
  _Sinhala10State createState() => _Sinhala10State();
}

class _Sinhala10State extends State<Sinhala10> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:18.0,left: 12.0,right: 12.0),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.blueGrey[800],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueGrey[700],
            elevation: 0.0,
            title: Text("S4".tr().toString(),style: TextStyle(color: Colors.blue[50],fontSize: 14.0),),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.0), 
              child: TabBar(
                indicatorWeight: 1.0,
                indicatorColor: Colors.red[50],
                unselectedLabelColor: Colors.blue[50],
                labelColor: Colors.red[50],
                tabs: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Text("සිංහල භාෂාව",style: TextStyle(fontSize: 13.0),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Text("සාහිත්‍ය",style: TextStyle(fontSize: 13.0),),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
          children: [
            Part1(),
            Part2(),
          ], 
        ),
        ),
      ),
    );
  }
}

class Part1 extends StatefulWidget {
  @override
  _Part1State createState() => _Part1State();
}

class _Part1State extends State<Part1> {
  var lessions = [
    {
      "name":"අක්ෂර මාලාව",
      "icon":"1",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"්‍රාදේශීය ව්‍යවහාර, ආශීර්වාද ක්‍රියා විධි ක්‍රියා",
      "icon":"2",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"නාම ප්‍රකෘති හා ධාතු ප්‍රකෘති",
      "icon":"3",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"ඉගි වැකි/ප්‍රස්ථා පිරුළු/යුගල පද",
      "icon":"4",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"කර්ම කාරක-කතෘ කාරක",
      "icon":"5",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"විශේෂ වාක්‍ය රීති",
      "icon":"6",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"විශේෂාංග ලිපි",
      "icon":"7",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"රාජකාරී ලිපි",
      "icon":"8",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"තොරොක්කෝව",
      "icon":"9",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"උපමා, රූපක",
      "icon":"10",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"අක්ෂර වින්‍යාසය",
      "icon":"11",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"විරාම ලකුණු",
      "icon":"12",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"පුවත්පත් වාර්තා/වාර්තාකරණය/න්‍යාය පත්‍ර​",
      "icon":"13",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"සන්ධි",
      "icon":"14",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"නිපාත උපසර්ග/අව්‍යය පද",
      "icon":"15",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"අත් පත්‍රිකා",
      "icon":"16",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"දැන්වීම්/වෙළඳ දැන්වීම්",
      "icon":"17",
      "color":Colors.blueGrey[300],
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
    if(videoLink.length != 0){
      setState(() {
        isLoading = true;
      });
    }
  }

  Future<List<DocumentSnapshot>> getAllLink() {
    // return Firestore.instance.collection('sinhala10_grammer').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('sinhala10_grammer').get().then((snap){
      return snap.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:14.0,top: 10.0),
      child: isLoading ? Container(
        child: ListView.builder(
          itemCount: 17,
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
    );
  }
}

class Part2 extends StatefulWidget {
  @override
  _Part2State createState() => _Part2State();
}

class _Part2State extends State<Part2> {

  var lessions = [
    {
      "name":"සතර කන් මන්ත්‍රණය",
      "icon":"1",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"ගුත්තිල වෙණ නද",
      "icon":"2",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"හානා හීය පානා අඩහැරෙන් දැනේ",
      "icon":"3",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"බැද්දේගම",
      "icon":"4",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"මුණි සිරිපා සිඹිමින්නේ",
      "icon":"5",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"ගංගාවේ සංගීතය",
      "icon":"6",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"ලෙන අතහැර යාම",
      "icon":"7",
      "color":Colors.blueGrey[300],
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
    if(videoLink.length != 0){
      setState(() {
        isLoading = true;
      });
    }
  }

  Future<List<DocumentSnapshot>> getAllLink() {
    // return Firestore.instance.collection('sinhala10_sahithya').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('sinhala10_sahithya').get().then((snap){
      return snap.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:14.0,top: 10.0),
      child: isLoading ? Container(
        child: ListView.builder(
          itemCount: 7,
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
    );
  }
}