import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ol_panthiya/tab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'size_config.dart';

class IntroScreen extends StatefulWidget {

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String lan = "si";
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 36.1 * SizeConfig.heightMultiplier,
              height: 33.69 * SizeConfig.heightMultiplier,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                      blurRadius: 5,
                      offset: Offset(0,0.5)
                    ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.68 * SizeConfig.heightMultiplier),
                    child: Text("Select your medium.",style: TextStyle(color: Colors.white,fontSize: 1.93 * SizeConfig.heightMultiplier,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  ListTile(  
                    title: Text('සිංහල මාධ්‍යය',style: TextStyle(color: Colors.white,fontSize: 1.93 * SizeConfig.heightMultiplier),),  
                    leading: Radio(  
                      value: "si",  
                      groupValue: lan,
                      activeColor: Colors.white, 
                      onChanged: (value) async {  
                        setState(() {  
                          lan = value;
                        });
                      },  
                    ),  
                  ),
                  ListTile(  
                    title: Text('English Medium',style: TextStyle(color: Colors.white,fontSize: 1.93 * SizeConfig.heightMultiplier),),  
                    leading: Radio(  
                      value: "en",  
                      groupValue: lan, 
                      activeColor: Colors.white,  
                      onChanged: (value) async {  
                        setState((){  
                          lan = value; 
                        }); 
                      },  
                    ),  
                  ),
                  SizedBox(
                    height: 4.21 * SizeConfig.heightMultiplier,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 1.44 * SizeConfig.heightMultiplier),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        height: 4.1 * SizeConfig.heightMultiplier,
                        width: 10.30 * SizeConfig.heightMultiplier,
                        child: Material(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white30,
                          child: MaterialButton(
                            onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString("language", lan);
                              setState(() {
                                context.setLocale(Locale(lan));
                                print(context.locale.toString());
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => InstructionPage()));
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => StartTab(0)));
                            },
                            child: Text("Next",style: TextStyle(fontSize: 1.57 * SizeConfig.heightMultiplier,color: Colors.white),),
                          ),
                        ),
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

class InstructionPage extends StatefulWidget {

  @override
  _InstructionPageState createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Padding(
        padding: EdgeInsets.only(left: 1.93 * SizeConfig.heightMultiplier,right: 1.93 * SizeConfig.heightMultiplier),
        child: Center(
          child: Container(
            width: 46.1 * SizeConfig.heightMultiplier,
            height: 45.69 * SizeConfig.heightMultiplier,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                    blurRadius: 5,
                    offset: Offset(0,0.5)
                  ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 0.96 * SizeConfig.heightMultiplier,right: 0.96 * SizeConfig.heightMultiplier),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("OL පන්තිය App  එක භාවිතයෙන්,",style: TextStyle(color: Colors.white,fontSize: 2.05 * SizeConfig.heightMultiplier),),
                  Padding(
                    padding: EdgeInsets.only(top:1.2 * SizeConfig.heightMultiplier),
                    child: Text("වඩාත් පහසුවෙන් හා ආකර්ෂනීය ලෙස අධ්‍යනය කටයුතු සිදු කරගැනීම සදහා YouTube tutorials එක්‌ එක්‌ පාඩමට අදාලව පිලිවෙලින් සකසා ඇත.",style: TextStyle(color: Colors.white,fontSize: 1.68 * SizeConfig.heightMultiplier),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.96 * SizeConfig.heightMultiplier),
                    child: Text("ඔබගේ මුදල් ඉතිරිකරගනිමින් අවම Data ප්‍රමාණයෙන් පරිශිලනයට ඔබගේ sim card පතට අදාල YouTube data package භාවිත කරන්න.",style: TextStyle(color: Colors.white,fontSize: 1.68 * SizeConfig.heightMultiplier),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.96 * SizeConfig.heightMultiplier),
                    child: Text("විශේෂයෙන් මෙම දුෂ්කර අවස්ථාවේ YouTube හරහා නොමිලේ දූ දරුවන්ට අධ්‍යාපනය ලබා දීමට වෙර දරන සියළුම ගුරුවරුන්ට අපගේ උත්තමාචාරය පිරිනමමු.",style: TextStyle(color: Colors.white,fontSize: 1.68 * SizeConfig.heightMultiplier),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 1.44 * SizeConfig.heightMultiplier),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        height: 4.1 * SizeConfig.heightMultiplier,
                        width: 10.30 * SizeConfig.heightMultiplier,
                        child: Material(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white30,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => StartTab(0)));
                            },
                            child: Text("Done",style: TextStyle(fontSize: 1.57 * SizeConfig.heightMultiplier,color: Colors.white),),
                          ),
                        ),
                      ),
                    ),
                  ), 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
