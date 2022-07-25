import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ol_panthiya/page/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './tabBar.dart';
import 'images.dart';
import 'model_papers/model_papers.dart';
import 'model_papers/motivation.dart';
import 'past_papers/past_papers.dart';
import 'size_config.dart';
import 'study_tips/study_tips.dart';
import 'study_tips/study_tipsE.dart';
import 'video/video_lessions.dart';

class StartTab extends StatefulWidget {
  int startTabIndex = 0;
  StartTab(this.startTabIndex);
  @override
  _StartTabState createState() => _StartTabState();
}
//check for test4 branch
//edit on tab.dart page
//testing a ammend
class _StartTabState extends State<StartTab> with SingleTickerProviderStateMixin {
  bool isLoading = false;
  SharedPreferences prefs;

  getLang() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;      
    });
  }

  void exit(){
    var alert = AlertDialog(
      content: Container(
        height: 10.61 * SizeConfig.heightMultiplier,
        child: Column(
          children: [
            Container(
              height: 3.61 * SizeConfig.heightMultiplier,
              width: 30.10 * SizeConfig.heightMultiplier,
              color: Colors.blue[800],
              child: Center(
                child: Text("Exit",style: TextStyle(color: Colors.white,fontSize: 1.68 * SizeConfig.heightMultiplier),)
              ),
            ),
            SizedBox(
              height: 3.85 * SizeConfig.heightMultiplier,
            ),
            Text("Are you sure want to Exit?",style: TextStyle(fontSize: 1.98 * SizeConfig.heightMultiplier)),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            SystemNavigator.pop();
          },
          child: Text("Exit",style: TextStyle(color: Colors.red,fontSize: 1.68 * SizeConfig.heightMultiplier),),
        ),
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text("Cancel",style: TextStyle(color: Colors.blue,fontSize: 1.68 * SizeConfig.heightMultiplier),),
        ),
      ],
    );
    showDialog(context: context,builder:(_) => alert);
  }
  //create test branch
  String getLanguage(){
    String lang = prefs.getString("language");
    String laguage;
    if(lang == "si"){
      setState(() {
        laguage = "සිංහල";
      });
    }
    else{
      setState(() {
        laguage = "English";  
      });
    }
    return laguage;
  }

  Color getLanguageColor() {
    Color language_color;
    if(prefs.getString("language") == "si"){
      setState(() {
        language_color = Colors.green;
      });
    }
    else{
      setState(() {
        language_color = Colors.purple;      
      });
    }
    return language_color;
  }

  @override
  void initState(){
    getLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: widget.startTabIndex,
      child: isLoading ? Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.cyan[900],
          title: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: AppBarTitle("O/L PANTHIYA"),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.0), 
            child: TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 4.0,
              tabs: [
                Padding(
                  padding: const EdgeInsets.only(bottom:6.0),
                  child: Text("Home",
                    style: TextStyle(color: Colors.white,fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:6.0),
                  child: Text("Video Tutorials",
                    style: TextStyle(color: Colors.white,fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:6.0),
                  child: Text("Past Papers",
                    style: TextStyle(color: Colors.white,fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:6.0),
                  child: Text("Study Tips",
                    style: TextStyle(color: Colors.white,fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:6.0),
                  child: Text("For the Winners",
                    style: TextStyle(color: Colors.white,fontSize: 14.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: Container(
          width: 30.08 * SizeConfig.heightMultiplier,
          child: Drawer(
            child:ListView(
              children:<Widget>[
                Container(
                  height: 9.63 * SizeConfig.heightMultiplier,
                  color: Colors.blue[700],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[800],
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: SizedBox(
                          height: 6.02 * SizeConfig.heightMultiplier,
                          child: Image(image: new AssetImage(Images.sIcon)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:0.96 * SizeConfig.heightMultiplier,),
                        child: Center(child: Text("O/L Panthiya",style: TextStyle(color: Colors.white,fontSize: 2.17 * SizeConfig.heightMultiplier,fontWeight: FontWeight.w400),)),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('Language',style: TextStyle(fontSize:1.93 * SizeConfig.heightMultiplier,),),
                  leading: Icon(Icons.language, color: Colors.red,),
                  trailing: Container(
                    width: 7.22 * SizeConfig.heightMultiplier,
                    height: 2.41 * SizeConfig.heightMultiplier,
                    decoration: BoxDecoration(
                      color: getLanguageColor(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    child: Center(child: Text(getLanguage(),style: TextStyle(color: Colors.white,fontSize: 1.44 * SizeConfig.heightMultiplier),))
                  ),
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) => ChangeLanguage(prefs.getString("language"))
                    );
                  },
                ),
                ListTile(
                  title: Text('Rate Us',style: TextStyle(fontSize:1.93 * SizeConfig.heightMultiplier),),
                  leading: Icon(Icons.rate_review, color: Colors.red,),
                  onTap: (){},
                ),
                ListTile(
                  title: Text('Contact Us',style: TextStyle(fontSize:1.93 * SizeConfig.heightMultiplier),),
                  leading: Icon(Icons.email, color: Colors.blue,),
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) => ContactUs()
                    );
                  },
                ),
                ListTile(
                  title: Text('Exit',style: TextStyle(fontSize:1.93 * SizeConfig.heightMultiplier),),
                  leading: Icon(Icons.transit_enterexit, color: Colors.blue,),
                  onTap: (){
                    exit();
                  },
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Home(),
            VideoLessions(getLanguage()),
            PastPapers(getLanguage()),
            StudyTipsE(),
            Motivation(),
          ], 
        ),
      ) : Container(color: Colors.grey[400],),
    );
  }
}

class ChangeLanguage extends StatefulWidget {
  String lan;
  ChangeLanguage(this.lan);
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Container(
        height: 3.61 * SizeConfig.heightMultiplier,
        color: Colors.blue[700],
        child: Center(
          child: Text("Change Medium",style: TextStyle(color: Colors.white,fontSize: 1.68 * SizeConfig.heightMultiplier),)
        ),
      ),
      children: [
        ListTile(  
          title: Text('සිංහල මාධ්‍යය',style: TextStyle(color: Colors.black,fontSize: 1.93 * SizeConfig.heightMultiplier),),  
          leading: Radio(  
            value: "si",  
            groupValue: widget.lan, 
            activeColor: Colors.black, 
            onChanged: (value) async {  
              setState(() {  
                widget.lan = value;
              });
              print(widget.lan);
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // prefs.setString("language", value);
              // print("Language is ${prefs.getString("language")}");
            },  
          ),  
        ),
        ListTile(  
          title: Text('English Medium',style: TextStyle(color: Colors.black,fontSize: 1.93 * SizeConfig.heightMultiplier),),  
          leading: Radio(  
            value: "en",  
            groupValue: widget.lan, 
            activeColor: Colors.black,  
            onChanged: (value) async {  
              setState((){  
                widget.lan = value; 
              }); 
              print(widget.lan);
            },  
          ),  
        ),
        SizedBox(
          height: 3.85 * SizeConfig.heightMultiplier,
        ),
        Padding(
          padding: const EdgeInsets.only(right:8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 3.1 * SizeConfig.heightMultiplier,
                width: 6.80 * SizeConfig.heightMultiplier,
                child: Material(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.blue,
                  child: MaterialButton(
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString("language", widget.lan); 
                      setState(() {
                        context.setLocale(Locale(widget.lan));
                        print(context.locale.toString());
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StartTab(0)));
                    },
                    child: Text("Ok",style: TextStyle(fontSize: 1.37 * SizeConfig.heightMultiplier,color: Colors.white),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: SizedBox(
                  height: 3.1 * SizeConfig.heightMultiplier,
                  width: 8.30 * SizeConfig.heightMultiplier,
                  child: Material(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.red,
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("Close",style: TextStyle(fontSize: 1.37 * SizeConfig.heightMultiplier,color: Colors.white),),
                    ),
                  ),
                ),
              ), 
            ],
          ),
        ),
      ],
    );
  }
}

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  Color iconColor = Colors.grey[800];
  Color containerColor = Colors.grey[200];

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: "chamithmathukorala@gmail.com"));
    setState(() {
      iconColor = Colors.blue;
      containerColor = Colors.blue[100];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Container(
        height: 3.61 * SizeConfig.heightMultiplier,
        width: 36.10 * SizeConfig.heightMultiplier,
        color: Colors.blue[800],
        child: Center(
          child: Text("Contact us",style: TextStyle(color: Colors.white,fontSize: 1.68 * SizeConfig.heightMultiplier),)
        ),
      ),
      children: [
        SizedBox(
          height: 2.41 * SizeConfig.heightMultiplier,
        ),
        Padding(
          padding: EdgeInsets.only(left:2.89 * SizeConfig.heightMultiplier,right: 2.89 * SizeConfig.heightMultiplier),
          child: Container(
            color: containerColor,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.copy,size: 1.93 * SizeConfig.heightMultiplier,color: iconColor,),
                  onPressed: (){
                    _copyToClipboard();
                  }
                ),
                Text("chamithmathukorala@gmail.com",style: TextStyle(color: Colors.black,fontSize: 1.60 * SizeConfig.heightMultiplier),),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.41 * SizeConfig.heightMultiplier,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Close",style: TextStyle(color: Colors.red,),),
          ),
        ),
      ],
    );
  }
}


