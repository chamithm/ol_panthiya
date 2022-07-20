import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ol_panthiya/video/video_page/video_page.dart';

class Maths11 extends StatefulWidget {
  String lan;
  Maths11(this.lan);
  @override
  _Maths11State createState() => _Maths11State();
}

class _Maths11State extends State<Maths11> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:18.0,left: 12.0,right: 12.0),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.blueGrey[800],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueGrey[700],
            elevation: 0.0,
            title: Text("S1".tr().toString(),style: TextStyle(color: Colors.blue[50],fontSize: 14.0),),
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
                    child: Text("Part 1",style: TextStyle(fontSize: 13.0),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Text("Part 2",style: TextStyle(fontSize: 13.0),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Text("Part 3",style: TextStyle(fontSize: 13.0),),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
          children: [
            Part1(widget.lan),
            Part2(widget.lan),
            Part3(widget.lan),
          ], 
        ),
        ),
      ),
    );
  }
}

class Part1 extends StatefulWidget {
  String lan;
  Part1(this.lan);
  @override
  _Part1State createState() => _Part1State();
}

class _Part1State extends State<Part1> {
  bool isLoading = false;
  var lessions = [
    {
      "icon":"1",
      "color":Colors.blueGrey[300],
    },
    {
      "icon":"2",
      "color":Colors.blueGrey[200],
    },
    {
      "icon":"3",
      "color":Colors.blueGrey[300],
    },
    {
      "icon":"4",
      "color":Colors.blueGrey[200],
    },
    {
      "icon":"5",
      "color":Colors.blueGrey[300],
    },
    {
      "icon":"6",
      "color":Colors.blueGrey[200],
    },
    {
      "icon":"7",
      "color":Colors.blueGrey[300],
    },
    {
      "icon":"8",
      "color":Colors.blueGrey[200],
    },
  ];

  List<DocumentSnapshot> videoLink = [];
  String collection;

  @override
  void initState(){
    if("lan".tr().toString() == "en"){
      collection = "maths11_e_part1";
    }
    else{
      collection = "maths11_s_part1";
    }
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
    // return Firestore.instance.collection(collection).getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection(collection).get().then((snap){
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(videoLink[0]['L${index+1}'],'maths11part1.$index'.tr())));
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
                        child: Text('maths11part1.$index'.tr(),style: TextStyle(color: Colors.white,fontSize: 14.0),),
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
  String lan;
  Part2(this.lan);
  @override
  _Part2State createState() => _Part2State();
}

class _Part2State extends State<Part2> {
  bool isLoading = false;
  String collection;
  var lessions = [
    {
      "icon":"9",
      "color":Colors.blueGrey[300],
    },
    {
      "icon":"10",
      "color":Colors.blueGrey[200],
    },
    {
      "icon":"11",
      "color":Colors.blueGrey[300],
    },
    {
      "icon":"12",
      "color":Colors.blueGrey[200],
    },
    {
      "icon":"13",
      "color":Colors.blueGrey[300],
    },
    {
      "icon":"14",
      "color":Colors.blueGrey[200],
    },
    {
      "icon":"15",
      "color":Colors.blueGrey[300],
    },
    {
      "icon":"16",
      "color":Colors.blueGrey[200],
    },
  ];

  List<DocumentSnapshot> videoLink = [];

  @override
  void initState(){
    if("lan".tr().toString() == "en"){
      collection = "maths11_e_part2";
    }
    else{
      collection = "maths11_s_part2";
    }
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
    // return Firestore.instance.collection(collection).getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection(collection).get().then((snap){
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(videoLink[0]['L${index+1}'],'maths11part2.$index'.tr())));
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
                        child: Text('maths11part2.$index'.tr(),style: TextStyle(color: Colors.white,fontSize: 14.0),),
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

class Part3 extends StatefulWidget {
  String lan;
  Part3(this.lan);
  @override
  _Part3State createState() => _Part3State();
}

class _Part3State extends State<Part3> {
  bool isLoading = false;
  var lessions = [
    {
      "icon":"17",
      "color":Colors.blueGrey[300],
    },
    {
      "icon":"18",
      "color":Colors.blueGrey[200],
    },
    {
      "icon":"19",
      "color":Colors.blueGrey[300],
    },
    {
      "icon":"20",
      "color":Colors.blueGrey[200],
    },
    {
      "icon":"21",
      "color":Colors.blueGrey[300],
    },
    {
      "icon":"22",
      "color":Colors.blueGrey[200],
    },
    {
      "icon":"23",
      "color":Colors.blueGrey[300],
    },
    {
      "icon":"24",
      "color":Colors.blueGrey[200],
    },
    {
      "icon":"25",
      "color":Colors.blueGrey[300],
    },
  ];

  List<DocumentSnapshot> videoLink = [];
  String collection;
  @override
  void initState(){
    if("lan".tr().toString() == "en"){
      collection = "maths11_e_part3";
    }
    else{
      collection = "maths11_s_part3";
    }
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
    // return Firestore.instance.collection(collection).getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection(collection).get().then((snap){
      return snap.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:14.0,top: 10.0),
      child: isLoading ? Container(
        child: ListView.builder(
          itemCount: 9,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(bottom:16.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(videoLink[0]['L${index+1}'],'maths11part3.$index'.tr())));
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
                        child: Text('maths11part3.$index'.tr(),style: TextStyle(color: Colors.white,fontSize: 14.0),),
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