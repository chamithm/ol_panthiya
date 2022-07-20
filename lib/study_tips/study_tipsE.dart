import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ol_panthiya/study_tips/study_tips.dart';

class StudyTipsE extends StatefulWidget {
  @override
  _StudyTipsEState createState() => _StudyTipsEState();
}

class _StudyTipsEState extends State<StudyTipsE> {
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
    // return Firestore.instance.collection('study_tips').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('study_tips').get().then((snap){
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
      backgroundColor: Colors.blueGrey[900],
      body: isLoading ? StudyTips(videoLink[0]["L1"],"study_tips") : Center(child: CircularProgressIndicator()),
    );
  }
}

//Navigator.push(context, MaterialPageRoute(builder: (context) => StudyTips(videoLink[0]["L1"])))