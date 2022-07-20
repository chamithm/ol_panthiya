import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ol_panthiya/video/video_page/video_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class Sinhala11 extends StatefulWidget {
  @override
  _Sinhala11State createState() => _Sinhala11State();
}

class _Sinhala11State extends State<Sinhala11> {
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
      "name":"සිංහල-අකාරාදී පිළිවෙල",
      "icon":"1",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"රචනය",
      "icon":"2",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"සාරාංශකරණය",
      "icon":"3",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"විභක්ති",
      "icon":"4",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"බිත්ති පුවත්පත්/කතු වැකි හා තීරු ලිපි",
      "icon":"5",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"සමාස",
      "icon":"6",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"තද්ධිත,කෘදන්ත",
      "icon":"7",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"සාම්ප්‍රදායික යෙදුම්",
      "icon":"8",
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
    if(videoLink.length != 0){
      setState(() {
        isLoading = true;
      });
    }
  }

  Future<List<DocumentSnapshot>> getAllLink() {
    // return Firestore.instance.collection('sinhala11_grammer').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('sinhala11_grammer').get().then((snap){
      return snap.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:14.0,top: 10.0),
      child: isLoading ? Container(
        child: ListView.builder(
          itemCount: 8,
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
      "name":"අඟුල්මල් දමනය",
      "icon":"1",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"උග්ගසේන නම් සිටුපුත්හුගේ වස්තුව",
      "icon":"2",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"කෑරගලය වැජඹෙයි මේ ලෙසින් සිට",
      "icon":"3",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"මග විසිතුරු",
      "icon":"4",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"කුරහන් ඉසිමුව කළුවර බලාලා",
      "icon":"5",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"අපටත් වැසිකිලියක්",
      "icon":"6",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"දියමන්ති මාලය",
      "icon":"7",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"දෑතේ කරගැට සිඹ සනසන්නට",
      "icon":"8",
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
    if(videoLink.length != 0){
      setState(() {
        isLoading = true;
      });
    }
  }

  Future<List<DocumentSnapshot>> getAllLink() {
    // return Firestore.instance.collection('sinhala11_sahithya').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('sinhala11_sahithya').get().then((snap){
      return snap.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:14.0,top: 10.0),
      child: isLoading ? Container(
        child: ListView.builder(
          itemCount: 8,
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