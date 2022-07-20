import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ol_panthiya/video/video_page/video_page.dart';
import 'package:easy_localization/easy_localization.dart';

class Buddhist11 extends StatefulWidget {
  @override
  _Buddhist11State createState() => _Buddhist11State();
}

class _Buddhist11State extends State<Buddhist11> {

  var lessions = [
    {
      "name":"බුදු සිරිත අනුව යමු අභියෝග ජය ගනිමු",
      "icon":"1",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"බුදු ගුණ අනන්තය",
      "icon":"2",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"බුදුකුරු දම් පුරා - දිවි මඟ ගනිමු සපුරා",
      "icon":"3",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"සමාධිගත සිතක මහිම",
      "icon":"4",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"ආදර්ශවත් චරිත",
      "icon":"5",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"දිවි මඟට එළිය දෙන දහම් පද",
      "icon":"6",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"සීලය හා භෟතික සංවර්ධනය",
      "icon":"7",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"දියුණුවේ හා පිරිහීමේ දොරටු",
      "icon":"8",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"බුදු දහමින් හෙළිවන සිතීමේ හා විමසීමේ නිදහස",
      "icon":"9",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"බෞද්ධ අනන්‍යතාව සුරකිමින් සහජීවනයෙන් ක්‍රියා කරමු",
      "icon":"10",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"පුද්ගල විසමතා සහ කර්මය",
      "icon":"11",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"සසර දුකත් දුකින් මිදීමත් උගන්වන බෞද්ධ හේතුඵල ධර්මය",
      "icon":"12",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"බුදු දහම පදනම් කරගත් ජීවන දැක්මක්",
      "icon":"13",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"පරිසරහිතකාමී වෙමු",
      "icon":"14",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"බුදුබණ ඇසුරින් නීරෝගී දිවියක්",
      "icon":"15",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"නිමල දහම රැකුණු අයුරු",
      "icon":"16",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"මහින්දාගමනයෙන් ශ්‍රී ලාංකික ජන ජීවිතය ඔපවත් වූ ආකාරය",
      "icon":"17",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"හෙළ බොදු කලාවේ අසිරිය",
      "icon":"18",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"බුදු සමයෙන් පෝෂණය වු සිංහල සාහිත්‍යය",
      "icon":"19",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"දැහැමි ධනය ගෙනෙයි සැපය",
      "icon":"20",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"දැහැමිව උපයා දැහැමිව වැය කරමු",
      "icon":"21",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"පාලකයනට මඟ කියන බුදු දහම",
      "icon":"22",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"ලොව්තුරු සුවේ පදනම සම්මා දිට්ඨියයි",
      "icon":"23",
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
    // return Firestore.instance.collection('buddhist11').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('buddhist11').get().then((snap){
      return snap.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0,right: 14.0),
      child: Scaffold(
        backgroundColor: Colors.blueGrey[800],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey[700],
          elevation: 0.0,
          title: Text("S5".tr().toString(),style: TextStyle(color: Colors.blue[50],fontSize: 13.0),),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left:14.0,top: 10.0),
          child: isLoading ? Container(
            child: ListView.builder(
              itemCount: 23,
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