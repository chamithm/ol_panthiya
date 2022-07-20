import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import '../images.dart';
import '../responsive_widget.dart';
import '../size_config.dart';
import '../tab.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var item=List<String>.generate(100, (index)=>'Item $index');

  List<DocumentSnapshot> updateLink = [];
  bool isUpdate = false;
  String link = "https://www.britannica.com/animal/dog";

  Future<List<DocumentSnapshot>> getAllLink() {
    // return Firestore.instance.collection("updateApp").getDocuments().then((snap){
    //   return snap.documents;
    // });
    return FirebaseFirestore.instance.collection('updateApp').get().then((snap){
      return snap.docs;
    });
  }

  Future<bool> updateApp() async {
    updateLink =  await getAllLink();
    setState(() {
      if(updateLink.length != 0 && updateLink[0]['L1'][0] == "true"){
        isUpdate = true;
        link = updateLink[0]['L1'][1];
      }
    });
  }

  Future<bool> _onBackPress(){
    //_showInterstitialAd();
    //return Future<bool>.value(true);
    SystemNavigator.pop();
  }

  @override
  void initState() {
    updateApp();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.blueGrey[800],
          body: ResponsiveWidget(
            portraitLayout: TopContainerPortrait(isUpdate,link),
            landscapeLayout: TopContainerLandscape(),
          ), 
        ),
      ),
    );
  }
  
}


class PortraitCard extends StatelessWidget {
  final String imagePath, title;

  const PortraitCard({Key key, this.imagePath, this.title,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: Container(
            width: SizeConfig.isMobilePortrait ? 24.79 * SizeConfig.heightAvg : 20.0 * SizeConfig.heightAvg,
            //height: 150.0,
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,
                  offset: Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 5 Vertically
                  ),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(1.5 * SizeConfig.heightMultiplier),
              ),
              child: AspectRatio(
                aspectRatio: 0.8,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                )
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.5 * SizeConfig.heightMultiplier,bottom: 0.5 * SizeConfig.heightMultiplier),
          child: Text(
            title,
            style: TextStyle(
              fontSize:1.5 * SizeConfig.heightMultiplier,color: Colors.grey[50].withOpacity(0.7),fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class TopContainerLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 38.85 * SizeConfig.heightMultiplier,
            width: 48.87 * SizeConfig.heightMultiplier,
            child: ImageCarousel(),
          ),
          Container(
            height: 46.61 * SizeConfig.heightMultiplier,
            width: 49.5 * SizeConfig.heightMultiplier,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:1 * SizeConfig.heightMultiplier, right: 1 * SizeConfig.heightMultiplier,bottom: 1 * SizeConfig.heightMultiplier),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[800],
                        borderRadius: BorderRadius.all(
                          Radius.circular(0.75 * SizeConfig.heightMultiplier),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top:1.0 * SizeConfig.heightMultiplier,left:1.0 * SizeConfig.heightMultiplier,bottom: 0.6 * SizeConfig.heightMultiplier),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("LEARNING",
                                style: TextStyle(
                                  fontSize:1.75 * SizeConfig.heightMultiplier,color: Colors.white,fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxHeight: 15.3 * SizeConfig.heightMultiplier),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => StartTab(1)));
                                        },
                                        child: PortraitCard(
                                          imagePath: Images.video,
                                          title: "Every Lessons",
                                        ),
                                      ),
                                      SizedBox(width: 9.73 * SizeConfig.widthMultiplier,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => StartTab(3)));
                                        },
                                        child: PortraitCard(
                                          imagePath: Images.study_tips,
                                          title: "Road to Success",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:1.0 * SizeConfig.heightMultiplier,right: 1.0 * SizeConfig.heightMultiplier),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[800],
                        borderRadius: BorderRadius.all(
                          Radius.circular(0.75 * SizeConfig.heightMultiplier),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top:1.0 * SizeConfig.heightMultiplier,left:1.0 * SizeConfig.heightMultiplier,bottom: 0.6 * SizeConfig.heightMultiplier),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("CHALLENGING",
                                style: TextStyle(
                                  fontSize:1.75 * SizeConfig.heightMultiplier,color: Colors.white,fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxHeight: 15.3 * SizeConfig.heightMultiplier),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => StartTab(2)));
                                        },
                                        child: PortraitCard(
                                          imagePath: Images.past_papers,
                                          title: "With Answers",
                                        ),
                                      ),
                                      SizedBox(width: 9.73 * SizeConfig.widthMultiplier,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => StartTab(4)));
                                        },
                                        child: PortraitCard(
                                          imagePath: Images.motivation,
                                          title: "For The Winners",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopContainerPortrait extends StatelessWidget {

  bool isUpdate;
  String link;

  TopContainerPortrait(this.isUpdate,this.link);

  _launchURL() async {
    await FlutterWebBrowser.openWebPage(url: link);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          height: 32.34 * SizeConfig.heightMultiplier,
          decoration: BoxDecoration(
            color: Colors.blueGrey[800],
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                //offset: Offset(15.0, 20.0),
                blurRadius: 12.0,
              )
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              FractionallySizedBox(
                heightFactor: 0.2,
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left:2.0 * SizeConfig.heightMultiplier,top:1.7 * SizeConfig.heightMultiplier),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("The best study way is self learning. It's so funny and sucessful.",
                          style: TextStyle(
                            fontSize:2.92 * SizeConfig.widthMultiplier,color: Colors.grey[300],fontWeight: FontWeight.w900,
                          ),
                        ),
                        Row(
                          children: [
                            Text(DateFormat.yMMMd().format(DateTime.now()),
                              style: TextStyle(
                                fontSize:2.68 * SizeConfig.widthMultiplier
                                ,color: Colors.grey[400],fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 2.2 * SizeConfig.heightMultiplier,
                            ),
                            Visibility(
                              visible: isUpdate,
                              child: SizedBox(
                                height: 2.2 * SizeConfig.heightMultiplier,
                                width: 17.70 * SizeConfig.heightMultiplier,
                                child: Material(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.blue[800],
                                  child: MaterialButton(
                                    onPressed: (){
                                      _launchURL();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 0.96 * SizeConfig.heightMultiplier),
                                      child: Text("Click here to Update",style: TextStyle(fontSize: 1.27 * SizeConfig.heightMultiplier,color: Colors.white),),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ImageCarousel(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(1 * SizeConfig.heightMultiplier),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
              borderRadius: BorderRadius.all(
                Radius.circular(0.75 * SizeConfig.heightMultiplier),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(1.0 * SizeConfig.heightMultiplier),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("LEARNING",
                      style: TextStyle(
                        fontSize:1.75 * SizeConfig.heightMultiplier,color: Colors.white,fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: 21.0 * SizeConfig.heightMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => StartTab(1)));
                              },
                              child: PortraitCard(
                                imagePath: Images.video,
                                title: "Every Lessons",
                              ),
                            ),
                            SizedBox(width: 9.73 * SizeConfig.widthMultiplier,),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => StartTab(3)));
                              },
                              child: PortraitCard(
                                imagePath: Images.study_tips,
                                title: "Road to Success",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left:1.0 * SizeConfig.heightMultiplier,right: 1.0 * SizeConfig.heightMultiplier),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
              borderRadius: BorderRadius.all(
                Radius.circular(0.75 * SizeConfig.heightMultiplier),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(1.0 * SizeConfig.heightMultiplier),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("CHALLENGING",
                      style: TextStyle(
                        fontSize:1.75 * SizeConfig.heightMultiplier,color: Colors.white,fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: 21.0 * SizeConfig.heightMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => StartTab(2)));
                              },
                              child: PortraitCard(
                                imagePath: Images.past_papers,
                                title: "With Answers",
                              ),
                            ),
                            SizedBox(width: 9.73 * SizeConfig.widthMultiplier,),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => StartTab(4)));
                              },
                              child: PortraitCard(
                                imagePath: Images.motivation,
                                title: "For The Winners",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ); 
  }
}

class ImageCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: SizeConfig.isPortrait ? 0.85 :1.0,
      alignment: Alignment.topCenter,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage(Images.cr_third),
          AssetImage(Images.cr_first),
          AssetImage(Images.cr_secound),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds:1000),
        autoplayDuration: Duration(seconds: 8),
        dotSize: 4.0,
        dotColor: Colors.red,
        indicatorBgPadding: 8.0,
      ),
    );
  }
}
