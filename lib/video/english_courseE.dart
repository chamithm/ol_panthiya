import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'english_course.dart';
import 'video_page/video_page.dart';

class EnglishCourseE extends StatefulWidget {
  @override
  _EnglishCourseEState createState() => _EnglishCourseEState();
}

class _EnglishCourseEState extends State<EnglishCourseE> {
  List<DocumentSnapshot> videoLink = [];
  bool isLoading = false;

  getLink() async{
    videoLink = await getAllLink();
    if(videoLink.length != 0){
      setState(() {
        isLoading = true;
      });
    }
  }

  Future<List<DocumentSnapshot>> getAllLink() {
    // return Firestore.instance.collection('chandu_aiya_english_course').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('chandu_aiya_english_course').get().then((snap){
      return snap.docs;
    });
  }

  @override
  void initState() {
    getLink();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: isLoading ? VideoPage(videoLink[0]["L1"],"English Course") : Center(child: CircularProgressIndicator()),
    );
  }
}