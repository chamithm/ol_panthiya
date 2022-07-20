import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ol_panthiya/admob_service.dart';
import 'package:ol_panthiya/tab.dart';
import 'images.dart';
import 'introScreen.dart';
import 'size_config.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/services.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  AdMobService.initialize();
  FlutterDownloader.initialize();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale("en"),
        Locale("si"),
      ],
      path: "assets/translations",
      fallbackLocale: Locale("en"),
      saveLocale: true,
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  Widget splashScreen(){
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new Splash(),
      image: Image(width: 120.0,height: 130.0,image: new AssetImage(Images.sIcon)),
      backgroundColor: Colors.blueGrey[800],
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      title: Text("Lets Learn Happily.",style: TextStyle(color: Colors.white70,fontSize: 16.0,fontWeight: FontWeight.bold),),
      loaderColor: Colors.blueGrey[900],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return LayoutBuilder(
      builder: (context,constraints){
        return OrientationBuilder(
          builder: (context,orientation){
            SizeConfig().init(constraints,orientation);
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: splashScreen(),
            );
          }
        );
      }
    );
  }
}


class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new StartTab(0)));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color:Colors.blueGrey[800],
      ),
    );
  }
}


