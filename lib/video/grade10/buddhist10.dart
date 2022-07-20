import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ol_panthiya/video/video_page/video_page.dart';
import 'package:easy_localization/easy_localization.dart';

class Buddhist10 extends StatefulWidget {
  @override
  _Buddhist10State createState() => _Buddhist10State();
}

class _Buddhist10State extends State<Buddhist10> {

  var lessions = [
    {
      "name":"අභියෝග ජය ගත් සිදුහත් බෝසතාණෝ",
      "icon":"1",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"නමදිමු අගයමු මහ සඟ රුවනා",
      "icon":"2",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"තෙරුවන් ගුණ හැඳිනගනිමු",
      "icon":"3",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"කුසල් සිත් වැඩි දියුණු කරමු",
      "icon":"4",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"විදසුන් වඩන්නෝ ඇති තතු දකින්නෝ",
      "icon":"5",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"සසුන් කෙත සරු කළ උතුමෝ ගුණැති පෙර කල",
      "icon":"6",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"මහලු වියෙහි දුක් නොවන්න තුරුණු දිවිය ගොඩනගන්න",
      "icon":"7",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"අනුසස් දැක සිල්වත් වෙමු",
      "icon":"8",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"සබඳතා රකින මිනිස් යුතුකම්",
      "icon":"9",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"රුදුරු මිනිසුන් අතර වෙමු අපි සොදුරු මිනිසුන්",
      "icon":"10",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"අපේකම හා සහජීවනය",
      "icon":"11",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"කර්මය සහ එහි ප්‍රභේද හැඳින ගනිමු",
      "icon":"12",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"ඇති තතු කියන තිලකුණු දහම",
      "icon":"13",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"පටිච්ච සමුප්පාද න්‍යාය හැඳින ගනිමු",
      "icon":"14",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"සිව්සස් හැඳින සැනසුම ලබමු",
      "icon":"15",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"බුදු සිරිතයි පරිසරයයි",
      "icon":"16",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"නීරෝගි බව උතුම් ලාභයයි",
      "icon":"17",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"නිවැරැදි ආහාර පරිභෝජනයෙන් සුව සේ වෙසෙමු",
      "icon":"18",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"සසුන සුරැකි සංගායනා",
      "icon":"19",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"හෙළ කලාවන් සුරකිමු",
      "icon":"20",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"බෞද්ධ සාහිත්‍ය රස විදිමු",
      "icon":"21",
      "color":Colors.blueGrey[300],
    },
    {
      "name":"රාජ්‍ය පාලනය පිළිබද බෞද්ධ ඉගැන්වීම්",
      "icon":"22",
      "color":Colors.blueGrey[200],
    },
    {
      "name":"ශ්‍රද්ධාව නිවන් මගෙහි පිවිසුමයි",
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
    // return Firestore.instance.collection('buddhist10').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('buddhist10').get().then((snap){
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