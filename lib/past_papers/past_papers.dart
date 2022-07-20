import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ol_panthiya/past_papers/view_papers.dart';
import 'package:super_easy_permissions/super_easy_permissions.dart';
import '../admob_service.dart';
import '../images.dart';
import '../responsive_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'revision_page.dart';
import 'view_papersE.dart';

class PastPapers extends StatefulWidget {
  String lan;
  PastPapers(this.lan);
  @override
  _PastPapersState createState() => _PastPapersState();
}

class _PastPapersState extends State<PastPapers> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            backgroundColor: Colors.blueGrey[600],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.0),
              child: TabBar(
                indicatorWeight: 2.0,
                indicatorColor: Colors.blue[100],
                unselectedLabelColor: Colors.white,
                labelColor: Colors.red[100],
                tabs: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Container(
                      child: Column(
                        children: [
                          //Icon(Icons.cast_for_education,size: 20.0,),
                          Text("Revision",style: TextStyle(fontSize: 12.0),textAlign: TextAlign.center,),
                        ],
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Container(
                      child: Column(
                        children: [
                          //Icon(Icons.school,size: 20.0,),
                          Text("Past Papers",style: TextStyle(fontSize: 12.0),textAlign: TextAlign.center,),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              RevisionPage(widget.lan),
              TopContainerPortrait(widget.lan),
            ], 
          ),
        ),
      ),
      // child: ResponsiveWidget(
      //   portraitLayout: TopContainerPortrait(widget.lan),
      //   landscapeLayout: TopContainerLandscape(widget.lan),
      // ),
    );
  }
}

class DounloadPastPapers extends StatefulWidget {
  String subject_name;
  String lan;
  String sub_name;
  DounloadPastPapers(this.subject_name,this.sub_name,this.lan);
  @override
  _DounloadPastPapersState createState() => _DounloadPastPapersState();
}

class _DounloadPastPapersState extends State<DounloadPastPapers> { 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:12.0,left: 12.0,right: 12.0),
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueGrey[700],
            elevation: 0.0,
            title: Text(widget.subject_name.tr().toString(),style: TextStyle(color: Colors.blue[50],fontSize: 13.0),),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(10.0), 
                child: TabBar(
                  isScrollable: false,
                  indicatorWeight: 1.0,
                  indicatorColor: Colors.red[50],
                  unselectedLabelColor: Colors.blue[50],
                  labelColor: Colors.red[50],
                  tabs: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom:4.0),
                      child: Text("2019",style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:4.0),
                      child: Text("2018",style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:4.0),
                      child: Text("2017",style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:4.0),
                      child: Text("2016",style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:4.0),
                      child: Text("2015",style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
          ),
          body:TabBarView(
            children: [
              GetPassPapers("2019",widget.subject_name.tr().toString(),widget.lan,widget.sub_name),
              GetPassPapers("2018",widget.subject_name.tr().toString(),widget.lan,widget.sub_name),
              GetPassPapers("2017",widget.subject_name.tr().toString(),widget.lan,widget.sub_name),
              GetPassPapers("2016",widget.subject_name.tr().toString(),widget.lan,widget.sub_name),
              GetPassPapers("2015",widget.subject_name.tr().toString(),widget.lan,widget.sub_name),
            ], 
          ),
        ),
      ),
    );
  }
}

class GetPassPapers extends StatefulWidget {
  String year;
  String subject_name;
  String lan;
  String sub_name;
  GetPassPapers(this.year,this.subject_name,this.lan,this.sub_name);
  @override
  _GetPassPapersState createState() => _GetPassPapersState();
}

class _GetPassPapersState extends State<GetPassPapers> {
  List<String> name = ["Past Paper","Marking Scheme"];
  bool isLoading = true;

  int count(){
    if(widget.year == "2017" || widget.year == "2016" || widget.year == "2015"){
      return 1;
    }
    else{
      if(widget.sub_name == "history" && widget.year == "2019"){
        return 1;
      }
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Container(
      color: Colors.blueGrey[800],
      child: ListView.builder(
        itemCount: count(),
        itemBuilder: (context,index){
          return InkWell(
            onTap: () async{
              bool result = await SuperEasyPermissions.askPermission(Permissions.storage);
              if (result) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPapersE(widget.year,widget.subject_name,widget.lan,widget.sub_name,index)));
              } else {
                // Permission denied, do something else
              }
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(14.0, 16.0, 14.0, 0.0),
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.blueGrey[600],
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    offset: Offset(0,0.5)
                  )
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.cyan[900],
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),bottomLeft: Radius.circular(15.0)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left:10.0,right:10.0),
                        child: Text(widget.year,style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.w600),),
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Text("${widget.subject_name} ${name[index]}",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600,color: Colors.white),),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    ) : Center(child: CircularProgressIndicator());
  }
}

class TopContainerPortrait extends StatefulWidget {
  String lan;
  TopContainerPortrait(this.lan);
  @override
  _TopContainerPortraitState createState() => _TopContainerPortraitState();
}

class _TopContainerPortraitState extends State<TopContainerPortrait> {
   List<Color> containerColor = [Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white];
  
  @override
  Widget build(BuildContext context) {
    //EasyLocalization.of(context).locale = Locale(widget.lan);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          backgroundColor: Colors.blueGrey[900],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueGrey[900],
            elevation: 0.0,
            title: Text("Past Papers Download",style: TextStyle(color: Colors.white,fontSize: 14.0),),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: TabBar(
                isScrollable: true,
                indicatorWeight: 4.0,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.white,
                labelColor: Colors.red[100],
                // onTap: (index){
                //   setState(() {
                //     containerColor[index] = Colors.blue[200];
                //     for(int i=0;i<6;i++){
                //       if(i != index){
                //         containerColor[i] = Colors.white;
                //       }
                //     }
                //   });
                // },
                tabs: [
                  Column(
                    children: [
                      Container(
                        width:50.0,
                        height:50.0,
                        decoration:BoxDecoration(
                          color: containerColor[0],
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey[700],
                            child: Icon(Icons.calculate)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("S1".tr().toString(),style: TextStyle(fontSize:12.0),),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width:50.0,
                        height:50.0,
                        decoration:BoxDecoration(
                          color: containerColor[1],
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey[700],
                            child: Icon(Icons.science_outlined)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("S2".tr().toString(),style: TextStyle(fontSize:12.0),),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width:50.0,
                        height:50.0,
                        decoration:BoxDecoration(
                          color: containerColor[2],
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey[700],
                            child: Icon(Icons.language)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("S3".tr().toString(),style: TextStyle(fontSize:12.0),),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width:50.0,
                        height:50.0,
                        decoration:BoxDecoration(
                          color: containerColor[3],
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey[700],
                            child: Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Text("අ",style: TextStyle(fontSize:26.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("S4".tr().toString(),style: TextStyle(fontSize:12.0),),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width:50.0,
                        height:50.0,
                        decoration:BoxDecoration(
                          color: containerColor[4],
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey[600],
                            child: Image.asset(
                              Images.darmachakra,
                              width: 25.0,
                              height: 25.0,
                              color: Colors.blue[100],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("S5".tr().toString(),style: TextStyle(fontSize:12.0),),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width:50.0,
                        height:50.0,
                        decoration:BoxDecoration(
                          color: containerColor[5],
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey[700],
                            child: Icon(Icons.filter_hdr_outlined)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("S6".tr().toString(),style: TextStyle(fontSize:12.0),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              DounloadPastPapers("S1","maths","lan".tr().toString()),
              DounloadPastPapers("S2","science","lan".tr().toString()),
              DounloadPastPapers("S3","english","si"),
              DounloadPastPapers("S4","sinhala","si"),
              DounloadPastPapers("S5","buddhist","si"),
              DounloadPastPapers("S6","history","si"),
            ], 
          ),
          bottomNavigationBar: Container(
            height: 50.0,
            child: AdWidget(
              key: UniqueKey(),
              ad: AdMobService.createBannerAd()..load(),
            ),
          ),
        ),
    );
  }
}

class TopContainerLandscape extends StatefulWidget {
  String lan;
  TopContainerLandscape(this.lan);
  @override
  _TopContainerLandscapeState createState() => _TopContainerLandscapeState();
}

class _TopContainerLandscapeState extends State<TopContainerLandscape> {
  List<Color> containerColor = [Colors.green[200],Colors.white,Colors.white,Colors.white,Colors.white,Colors.white];
  ScrollController _scrollBottomBarController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    //EasyLocalization.of(context).locale = Locale(widget.lan);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: new NestedScrollView(
        controller: _scrollBottomBarController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blueGrey[900],
              elevation: 0.0,
              title: Text("Past Papers Download",style: TextStyle(color: Colors.white,fontSize: 14.0),),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(80.0),
                child: TabBar(
                  isScrollable: true,
                  indicatorWeight: 4.0,
                  indicatorColor: Colors.transparent,
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.red[100],
                  onTap: (index){
                    setState(() {
                      containerColor[index] = Colors.blue[200];
                      for(int i=0;i<6;i++){
                        if(i != index){
                          containerColor[i] = Colors.white;
                        }
                      }
                    });
                  },
                  tabs: [
                    Column(
                      children: [
                        Container(
                          width:50.0,
                          height:50.0,
                          decoration:BoxDecoration(
                            color: containerColor[0],
                            borderRadius: BorderRadius.circular(50.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey[700],
                              child: Icon(Icons.calculate)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text("S1".tr().toString(),style: TextStyle(fontSize:12.0),),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width:50.0,
                          height:50.0,
                          decoration:BoxDecoration(
                            color: containerColor[1],
                            borderRadius: BorderRadius.circular(50.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey[700],
                              child: Icon(Icons.science_outlined)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text("S2".tr().toString(),style: TextStyle(fontSize:12.0),),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width:50.0,
                          height:50.0,
                          decoration:BoxDecoration(
                            color: containerColor[2],
                            borderRadius: BorderRadius.circular(50.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey[700],
                              child: Icon(Icons.language)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text("S3".tr().toString(),style: TextStyle(fontSize:12.0),),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width:50.0,
                          height:50.0,
                          decoration:BoxDecoration(
                            color: containerColor[3],
                            borderRadius: BorderRadius.circular(50.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey[700],
                              child: Padding(
                                padding: const EdgeInsets.only(bottom:8.0),
                                child: Text("අ",style: TextStyle(fontSize:26.0)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text("S4".tr().toString(),style: TextStyle(fontSize:12.0),),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width:50.0,
                          height:50.0,
                          decoration:BoxDecoration(
                            color: containerColor[4],
                            borderRadius: BorderRadius.circular(50.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey[700],
                              child: Image.asset(
                                Images.darmachakra,
                                width: 25.0,
                                height: 25.0,
                                color: Colors.blue[100],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text("S5".tr().toString(),style: TextStyle(fontSize:12.0),),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width:50.0,
                          height:50.0,
                          decoration:BoxDecoration(
                            color: containerColor[5],
                            borderRadius: BorderRadius.circular(50.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey[700],
                              child: Icon(Icons.filter_hdr_outlined)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text("S6".tr().toString(),style: TextStyle(fontSize:12.0),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: new TabBarView(
          children: <Widget>[
            DounloadPastPapers("S1","maths",widget.lan),
            DounloadPastPapers("S2","science",widget.lan),
            DounloadPastPapers("S3","english","si"),
            DounloadPastPapers("S4","sinhala","si"),
            DounloadPastPapers("S5","buddhist","si"),
            DounloadPastPapers("S6","history","si"),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 50.0,
          child: AdWidget(
            key: UniqueKey(),
            ad: AdMobService.createBannerAd()..load(),
          ),
        ),
    );
  }
}

