import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ol_panthiya/admob_service.dart';
import '../images.dart';
import '../responsive_widget.dart';
import '../size_config.dart';
import 'english_course.dart';
import 'english_courseE.dart';
import 'grade10/buddhist10.dart';
import 'grade10/english10.dart';
import 'grade10/history10.dart';
import 'grade10/maths10.dart';
import 'grade10/science10.dart';
import 'grade10/sinhala10.dart';
import 'grade11/buddhist11.dart';
import 'grade11/english11.dart';
import 'grade11/sinhala11.dart';
import 'grade11/history11.dart';
import 'grade11/maths11.dart';
import 'grade11/science11.dart';
import 'package:easy_localization/easy_localization.dart';

class VideoLessions extends StatefulWidget {
  String lan;
  VideoLessions(this.lan);
  @override
  _VideoLessionsState createState() => _VideoLessionsState();
}
//test for test3
//edited in video_lessons page
class _VideoLessionsState extends State<VideoLessions> {
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            backgroundColor: Colors.blueGrey[600],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.0),
              child: TabBar(
                indicatorWeight: 1.0,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.white,
                labelColor: Colors.red[100],
                tabs: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Container(
                      child: Column(
                        children: [
                          Icon(Icons.cast_for_education,size: 20.0,),
                          Text("Grade 10",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center,),
                        ],
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Container(
                      child: Column(
                        children: [
                          Icon(Icons.school,size: 20.0,),
                          Text("Grade 11",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center,),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              ResponsiveWidget(
                portraitLayout: TopContainerPortrait(widget.lan,10,true),
                landscapeLayout: TopContainerLandscape(widget.lan,10,true),
              ),
              ResponsiveWidget(
                portraitLayout: TopContainerPortrait(widget.lan,11,false),
                landscapeLayout: TopContainerLandscape(widget.lan,11,false),
              ),
            ], 
          ),
        ),
        bottomNavigationBar: Container(
          height: 50.0,
          color: Colors.blueGrey[900],
          child: AdWidget(
            key: UniqueKey(),
            ad: AdMobService.createBannerAd()..load(),
          ),
        ),
      ),
    );
  }
}

class TopContainerPortrait extends StatefulWidget {
  String lan;
  int grade;
  bool is10;
  TopContainerPortrait(this.lan,this.grade,this.is10);
  @override
  _TopContainerPortraitState createState() => _TopContainerPortraitState();
}

class _TopContainerPortraitState extends State<TopContainerPortrait> {
  List<Color> containerColor = [Colors.green[200],Colors.white,Colors.white,Colors.white,Colors.white,Colors.white];
  //check new branch
  //check new branch today
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey[900],
          elevation: 0.0,
          title: Text("Grade ${widget.grade} subjects",style: TextStyle(color: Colors.white,fontSize: 14.0),),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: Row(
                children: [
                  SizedBox(
                    height: 3.1 * SizeConfig.heightMultiplier,
                    width: 17.70 * SizeConfig.heightMultiplier,
                    child: Material(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.blueGrey[700],
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EnglishCourseE()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("Free English Course",style: TextStyle(fontSize: 1.27 * SizeConfig.heightMultiplier,color: Colors.blue[50]),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                  containerColor[index] = Colors.green[200];
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
        body: widget.is10 ? tabBar10(widget.lan) : tabBar11(widget.lan),
      ),
    );
  }
}

Widget tabBar10(String lan){
  return TabBarView(
    children: [
      Maths10(lan),
      Science10(lan),
      English10(),
      Sinhala10(),
      Buddhist10(),
      History10(),
    ], 
  );
}

Widget tabBar11(String lan){
  return TabBarView(
    children: [
      Maths11(lan),
      Science11(lan),
      English11(),
      Sinhala11(),
      Buddhist11(),
      History11(),
    ], 
  );
}

class TopContainerLandscape extends StatefulWidget {
  String lan;
  int grade;
  bool is10;
  TopContainerLandscape(this.lan,this.grade,this.is10);
  @override
  _TopContainerLandscapeState createState() => _TopContainerLandscapeState();
}

class _TopContainerLandscapeState extends State<TopContainerLandscape> {
  List<Color> containerColor = [Colors.green[200],Colors.white,Colors.white,Colors.white,Colors.white,Colors.white];
  ScrollController _scrollBottomBarController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: NestedScrollView(
          controller: _scrollBottomBarController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.blueGrey[900],
                elevation: 0.0,
                title: Text("Grade ${widget.grade} subjects",style: TextStyle(color: Colors.white,fontSize: 14.0),),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 3.1 * SizeConfig.heightMultiplier,
                          width: 18.30 * SizeConfig.heightMultiplier,
                          child: Material(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.blueGrey[700],
                            child: MaterialButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EnglishCourseE()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text("Free English Course",style: TextStyle(fontSize: 1.27 * SizeConfig.heightMultiplier,color: Colors.blue[50]),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                        containerColor[index] = Colors.green[200];
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
                                backgroundColor: Colors.blueGrey[900],
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
          body: widget.is10 ? tabBar10(widget.lan) : tabBar11(widget.lan),
        ),
      ),
    );
  }
}
