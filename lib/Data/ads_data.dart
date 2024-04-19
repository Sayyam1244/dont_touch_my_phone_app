import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';

const String interstatialAdId = "ca-app-pub-5191994333943851/1809282751";
const String interstatialAdId2 = "ca-app-pub-5191994333943851/6743513841";
const String bannerAdId = "ca-app-pub-5191994333943851/9593038468";
const String bannerAdId2 = "ca-app-pub-5191994333943851/6375530953";
const String bannerAdId3 = "ca-app-pub-5191994333943851/3122364426";

class AdService {
  static void loadinterStatial({required String interstatialAdId}) {
    InterstitialAd.load(
      adUnitId: interstatialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  Future<BannerAd> loadBanner(String bannerId) async {
    final bannerAd = await BannerAd(
      adUnitId: bannerId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, err) {
          log("ERR: $err");
          ad.dispose();
        },
      ),
    )
      ..load();

    return bannerAd;
  }
}
