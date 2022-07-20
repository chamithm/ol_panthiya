import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ol_panthiya/video/video_page/video_page.dart';
import 'package:easy_localization/easy_localization.dart';

class History11 extends StatefulWidget {
  @override
  _History11State createState() => _History11State();
}

class _History11State extends State<History11> {

  var lessions = [
    {
      "name":"කාර්මික විප්ලවය",
      "icon":"1",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"ශ්‍රී ලංකාවේ බ්‍රිතාන්‍ය බලය පිහිටුවීම",
      "icon":"2",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"ශ්‍රී ලංකාවේ ජාතික පුනරුදය",
      "icon":"3",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"බ්‍රිතාන්‍යන් යටතේ ශ්‍රී ලංකාවේ දේශපාලන වෙනස්වීම්",
      "icon":"4",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"බ්‍රිතාන්‍යන් යටතේ ශ්‍රී ලංකාවේ සමාජ පරිවර්තන",
      "icon":"5",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"ශ්‍රී ලංකාවට නිදහස ලැබීම",
      "icon":"6",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"ලෝකයේ කැපී පෙනෙන විප්ලව",
      "icon":"7",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"ලෝක මහා සංග්‍රාම හා සම්මුතීන්",
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
    // return Firestore.instance.collection('history11_s').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('history11_s').get().then((snap){
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
        ),
      ),
    );
  }
}