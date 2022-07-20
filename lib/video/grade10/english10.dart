import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ol_panthiya/video/video_page/video_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class English10 extends StatefulWidget {
  @override
  _English10State createState() => _English10State();
}

class _English10State extends State<English10> {
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
            title: Text("English",style: TextStyle(color: Colors.white,fontSize: 14.0),),
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
                    child: Text("English Course",style: TextStyle(fontSize: 13.0),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Text("Text Book",style: TextStyle(fontSize: 13.0),),
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
  int count = 0;

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
    // return Firestore.instance.collection('chandu_aiya10').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('chandu_aiya10').get().then((snap){
      return snap.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:14.0,top: 10.0),
      child: isLoading ? Container(
        child: ListView.builder(
          itemCount: videoLink[1]["L1"].length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(bottom:16.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(videoLink[0]['L${index+1}'],videoLink[1]["L1"][index])));
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor: index.isEven ? Colors.blueGrey[300] : Colors.blueGrey[200],
                        child:Text("${index+1}",style: TextStyle(fontSize: 15.0,color: Colors.black),), 
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(videoLink[1]["L1"][index],style: TextStyle(color: Colors.white,fontSize: 14.0),),
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
      "name":"People",
      "icon":"1",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"On Your Way",
      "icon":"2",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"Travel",
      "icon":"3",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"Let s Talk",
      "icon":"4",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"Best Practices",
      "icon":"5",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"Information",
      "icon":"6",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"Learning is Fun",
      "icon":"7",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"Healthy Food",
      "icon":"8",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"Nature",
      "icon":"9",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"Personality",
      "icon":"10",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"The Right Career",
      "icon":"11",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"Success",
      "icon":"12",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"Future",
      "icon":"13",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"Sports",
      "icon":"14",
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
    // return Firestore.instance.collection('english10').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('english10').get().then((snap){
      return snap.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:14.0,top: 10.0),
      child: isLoading ? Container(
        child: ListView.builder(
          itemCount: 14,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(bottom:16.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(videoLink[0]['L${index+1}'],lessions[index]["name"])));
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