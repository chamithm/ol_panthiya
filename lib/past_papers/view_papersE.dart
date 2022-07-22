import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:super_easy_permissions/super_easy_permissions.dart';
import 'view_papers.dart';

class ViewPapersE extends StatefulWidget {
  String year;
  String subject_name;
  String lan;
  String sub_name;
  int index;
  ViewPapersE(this.year,this.subject_name,this.lan,this.sub_name,this.index);

  @override
  _ViewPapersEState createState() => _ViewPapersEState();
}

class _ViewPapersEState extends State<ViewPapersE> {
  String category;
  String lang = "lan".tr().toString();
  Reference refDef;
  Uint8List bytes;
  String fileName;
  bool isLoding = false;
  bool isLoaded = true;
  File pdfFile;
  File fileSync;
  String work = "Loading..!";

  downloadPdf(String fullPath) async{
    File saveFile = File(fullPath);
    await saveFile.writeAsBytes(bytes, flush:true);
    setState(() {
      isLoding = true;
    });
  }

  @override
  void initState(){
    if(widget.index == 0){
      category = "Past Paper";
    }
    else{
      category = "Marking Scheme";
    }
    checkFile();
    super.initState();
  }

  checkFile() async{
    bool result = await SuperEasyPermissions.askPermission(Permissions.storage);
    if (result) {
      var getPaths = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DCIM);
      String getFullPath = "$getPaths/${widget.year} ${widget.subject_name} $category(${widget.lan}).pdf";
      fileSync  = File(getFullPath);
      print('file contanet is $fileSync');
      if(fileSync.existsSync()){
        setState(() {
          isLoding = true;   
        });
      }
      else{
        setState(() {
          work = "Downloading..!";
        });
        loadFirebase('$category/${widget.sub_name}/${widget.lan}/${widget.year}.pdf');
      }
      print('chamith ok $isLoding');
    } else {
      // Permission denied, do something else
    }
  }

  Future<File> loadFirebase(String url) async{
    try{
      refDef = FirebaseStorage.instance.ref().child(url);
      bytes = await refDef.getData(20971520);
      storeFile(url,bytes);
    }catch(e){
      setState(() {
        isLoaded = false;        
      });
    }
  }

  Future<File> storeFile(String url,List<int> bytes) async{
    fileName = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush:true);
    setState(() {
      pdfFile = file;
    });
    var path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DCIM);
    String fullPath = "$path/${widget.year} ${widget.subject_name} $category(${widget.lan}).pdf";
    downloadPdf(fullPath);
    print(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: isLoding ? ViewPapers(widget.year,widget.subject_name,widget.lan,widget.sub_name,widget.index,fileSync) : lodinng(work),
    );
  }
}

Widget lodinng(String work){
    return Center(
      child: Container(
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                offset: Offset(0,0.5)
              )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator(backgroundColor: Colors.green[400],)),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text(work,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }