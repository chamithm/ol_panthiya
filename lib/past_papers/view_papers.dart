import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:super_easy_permissions/super_easy_permissions.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../admob_service.dart';

class ViewPapers extends StatefulWidget {
  String year;
  String subject_name;
  String lan;
  String sub_name;
  int index;
  File file;
  ViewPapers(this.year,this.subject_name,this.lan,this.sub_name,this.index,this.file);

  @override
  _ViewPapersState createState() => _ViewPapersState();
}

class _ViewPapersState extends State<ViewPapers> {
  
  Future<bool> _onBackPress(){
    return Future<bool>.value(true);
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.only(top:24.0),
          child: SfPdfViewer.file(widget.file),
        ),
      ),
    );
  }
}

//FutterDownloder.enaque