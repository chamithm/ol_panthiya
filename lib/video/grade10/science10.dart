import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ol_panthiya/video/video_page/video_page.dart';
import 'package:easy_localization/easy_localization.dart';

class Science10 extends StatefulWidget {
  String lan;
  Science10(this.lan);
  @override
  _Science10State createState() => _Science10State();
}

class _Science10State extends State<Science10> {
  Color tabColor = Colors.green[800];

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
            title: Text("S2".tr().toString(),style: TextStyle(color: Colors.blue[50],fontSize: 14.0),),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.0), 
              child: TabBar(
                indicatorWeight: 1.0,
                indicatorColor: Colors.red[50],
                unselectedLabelColor: Colors.blue[50],
                labelColor: Colors.red[50],
                onTap: (index){
                  setState(() {
                    if(index == 0){
                      tabColor = Colors.green[800];
                    }
                    if(index == 1){
                      tabColor = Colors.orange[800];
                    }
                    if(index == 2){
                      tabColor = Colors.blue;
                    }
                });
                },
                tabs: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Text("Biology",style: TextStyle(fontSize: 13.0),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Text("Physics",style: TextStyle(fontSize: 13.0),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Text("Chemistry",style: TextStyle(fontSize: 13.0),),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
          children: [
            Bio(widget.lan),
            Physics(widget.lan),
            Chemistry(widget.lan),
          ], 
        ),
        ),
      ),
    );
  }
}

class Bio extends StatefulWidget {
  String lan;
  Bio(this.lan);
  @override
  _BioState createState() => _BioState();
}

class _BioState extends State<Bio> {
  var lessions = [
    {
      "icon":"1",
      "color":Colors.green[900],
    },
    {
      "icon":"2",
      "color":Colors.green[800],
    },
    {
      "icon":"3",
      "color":Colors.green[900],
    },
    {
      "icon":"4",
      "color":Colors.green[800],
    },
    {
      "icon":"5",
      "color":Colors.green[900],
    },
    {
      "icon":"6",
      "color":Colors.green[800],
    },
  ];

  List<DocumentSnapshot> videoLink = [];
  bool isLoading = false;
  String collection;

  @override
  void initState(){
    if("lan".tr().toString() == "en"){
      collection = "science10_e_bio";
    }
    else{
      collection = "science10_s_bio";
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
          itemCount: 6,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(bottom:16.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(videoLink[0]['L${index+1}'],'science10Bio.$index'.tr())));
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor: lessions[index]["color"],
                        child:Text(lessions[index]["icon"],style: TextStyle(fontSize: 15.0,color: Colors.white),), 
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text('science10Bio.$index'.tr(),style: TextStyle(color: Colors.white,fontSize: 14.0),),
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

class Physics extends StatefulWidget {
  String lan;
  Physics(this.lan);
  @override
  _PhysicsState createState() => _PhysicsState();
}

class _PhysicsState extends State<Physics> {
  bool isLoading = false;
  var lessions = [
    {
      "icon":"1",
      "color":Colors.orange[600],
    },
    {
      "icon":"2",
      "color":Colors.orange[500],
    },
    {
      "icon":"3",
      "color":Colors.orange[600],
    },
    {
      "icon":"4",
      "color":Colors.orange[500],
    },
    {
      "icon":"5",
      "color":Colors.orange[600],
    },
    {
      "icon":"6",
      "color":Colors.orange[500],
    },
     {
      "icon":"7",
      "color":Colors.orange[600],
    },
     {
      "icon":"8",
      "color":Colors.orange[500],
    },
    {
      "icon":"9",
      "color":Colors.orange[600],
    },
  ];
   
  List<DocumentSnapshot> videoLink = [];
  String collection;

  @override
  void initState(){
    if("lan".tr().toString() == "en"){
      collection = "science10_e_phy";
    }
    else{
      collection = "science10_s_phy";
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(videoLink[0]['L${index+1}'],'science10phy.$index'.tr())));
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor: lessions[index]["color"],
                        child:Text(lessions[index]["icon"],style: TextStyle(fontSize: 15.0,color: Colors.white),), 
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text('science10phy.$index'.tr(),style: TextStyle(color: Colors.white,fontSize: 14.0),),
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

class Chemistry extends StatefulWidget {
  String lan;
  Chemistry(this.lan);
  @override
  _ChemistryState createState() => _ChemistryState();
}

class _ChemistryState extends State<Chemistry> {
  bool isLoading = false;
  var lessions = [
    {
      "icon":"1",
      "color":Colors.blue[900],
    },
    {
      "icon":"2",
      "color":Colors.blue[800],
    },
    {
      "icon":"3",
      "color":Colors.blue[900],
    },
    {
      "icon":"4",
      "color":Colors.blue[800],
    },
    {
      "icon":"5",
      "color":Colors.blue[900],
    },
   
  ];

  List<DocumentSnapshot> videoLink = [];
  String collection;

  @override
  void initState(){
    if("lan".tr().toString() == "en"){
      collection = "science10_e_che";
    }
    else{
      collection = "science10_s_che";
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
          itemCount: 5,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(bottom:16.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(videoLink[0]['L${index+1}'],'science10che.$index'.tr())));
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor: lessions[index]["color"],
                        child:Text(lessions[index]["icon"],style: TextStyle(fontSize: 15.0,color: Colors.white),), 
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text('science10che.$index'.tr(),style: TextStyle(color: Colors.white,fontSize: 14.0),),
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