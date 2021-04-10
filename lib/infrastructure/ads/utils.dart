import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/services.dart';

import 'ads.dart';
import 'const.dart';

InterstitialAd? interstitialAd() => enableInterstitialAds
    ? InterstitialAd(
        adUnitId: interstitialid,
        targetingInfo: MobileAdTargetingInfo(
          testDevices: <String>[deviceTestId],
          keywords: [
            "Music",
            "Scales",
            "Guitar",
            "Piano",
            "Instrument",
            "Songs",
            "Chords"
          ],
        ),
        listener: (MobileAdEvent event) {
          print(event);
          if (event == MobileAdEvent.closed) {
            SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          }
          if (event == MobileAdEvent.clicked) {
            SystemChrome.setEnabledSystemUIOverlays([]);
          }
        },
      )
    : null;
