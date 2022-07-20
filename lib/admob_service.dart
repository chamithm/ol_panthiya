import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService{
  static String bannerAdUnitId = "ca-app-pub-5630497991413712/9012949383";
  

  static initialize() {
    if(MobileAds.instance == null){
      MobileAds.instance.initialize();
    }
  }

  static BannerAd createBannerAd(){
    BannerAd ad = new BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) { 
          print("Ad Loaded");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error){
          print("error is $error");
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print("Ad opened"),
        onAdClosed: (Ad ad) => print("Ad close"),
      ),
      request: AdRequest(),
    );
    return ad;
  }
}