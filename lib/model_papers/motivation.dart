import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ol_panthiya/study_tips/study_tips.dart';

import 'model_papers.dart';

class Motivation extends StatefulWidget {
  @override
  _MotivationState createState() => _MotivationState();
}

class _MotivationState extends State<Motivation> {
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
    // return Firestore.instance.collection('motivation').getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('motivation').get().then((snap){
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
      body: isLoading ? YoutubeTutorials(videoLink[0]["L1"],"motivation",false) : Center(child: CircularProgressIndicator()),
    );
  }
}