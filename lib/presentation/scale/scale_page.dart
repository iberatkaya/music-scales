import 'package:flutter/material.dart';
import 'package:music_scales/domain/core/const.dart';
import 'package:music_scales/infrastructure/ads/ads.dart';
import 'package:music_scales/presentation/progression/progression_detail.dart';
import 'package:music_scales/presentation/scale/scales_detail.dart';
import 'package:music_scales/presentation/scale/search.dart';
import 'package:music_scales/presentation/widgets/card/card.dart';
import '../icons/my_flutter_app_icons.dart' as CustomIcons;

class ScalePage extends StatefulWidget {
  @override
  _ScalePageState createState() => _ScalePageState();
}

class _ScalePageState extends State<ScalePage> {
  int showad = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: ButtonCard(
                icon: Icon(
                  CustomIcons.MyFlutterApp.music_notes,
                  size: 48,
                  color: Color.fromRGBO(200, 0, 0, 1),
                ),
                onPressed: () async {
                  showad++;
                  if (showad % adFreq == 1) {
                    final myInterstitialAd = interstitialAd();
                    await myInterstitialAd.load();
                    await myInterstitialAd.show();
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScalePrintScreen()));
                },
                subtitle: "Learn about scales!",
                title: "Scales",
                color: Color.fromRGBO(30, 195, 195, 0.6),
                titleSize: 34,
                subtitleSize: 22,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: ButtonCard(
                icon: Icon(
                  Icons.search,
                  size: 48,
                  color: Colors.deepPurple[600],
                ),
                onPressed: () async {
                  showad++;
                  if (showad % adFreq == 1) {
                    final myInterstitialAd = interstitialAd();
                    await myInterstitialAd.load();
                    await myInterstitialAd.show();
                  }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                subtitle: "Search for a scale with a chord!",
                title: "Scale Finder",
                color: Color.fromRGBO(120, 155, 210, 0.55),
                titleSize: 32,
                subtitleSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: ButtonCard(
                icon: Icon(
                  CustomIcons.MyFlutterApp.prog,
                  size: 48,
                  color: Colors.green,
                ),
                onPressed: () async {
                  showad++;
                  if (showad % adFreq == 1) {
                    final myInterstitialAd = interstitialAd();
                    await myInterstitialAd.load();
                    await myInterstitialAd.show();
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProgPrintScreen()));
                },
                subtitle: "Learn about chord progressions!",
                title: "Progressions",
                color: Color.fromRGBO(130, 155, 240, 0.75),
                titleSize: 30,
                subtitleSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
