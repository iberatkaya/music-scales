import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_scales/domain/core/const.dart';
import 'package:music_scales/infrastructure/ads/ads.dart';
import 'package:music_scales/presentation/chords/search_chord.dart';
import 'package:music_scales/presentation/progression/progression_detail.dart';
import 'package:music_scales/presentation/quiz/quiz.dart';
import 'package:music_scales/presentation/widgets/card/card.dart';
import '../icons/my_flutter_app_icons.dart' as CustomIcons;
import 'chords.dart';

class ChordPage extends StatefulWidget {
  @override
  _ChordPageState createState() => _ChordPageState();
}

class _ChordPageState extends State<ChordPage> {
  int showad = 0;
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
                          builder: (context) => ChordPrintScreen()));
                },
                subtitle: "Learn about chord progressions!",
                title: "Chords",
                color: Color.fromRGBO(130, 155, 240, 0.75),
                titleSize: 32,
                subtitleSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: ButtonCard(
                icon: Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Icon(
                    CustomIcons.MyFlutterApp.quiz,
                    size: 48,
                    color: Colors.blue,
                  ),
                ),
                onPressed: () async {
                  showad++;
                  if (showad % adFreq == 1) {
                    final myInterstitialAd = interstitialAd();
                    await myInterstitialAd.load();
                    await myInterstitialAd.show();
                  }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuizScreen()));
                },
                subtitle: "Play a quiz about scales!",
                title: "Quiz",
                color: Color.fromRGBO(80, 190, 105, 0.6),
                titleSize: 32,
                subtitleSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: ButtonCard(
                icon: Icon(
                  Icons.search,
                  size: 48,
                  color: Colors.pink[600],
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
                          builder: (context) => SearchChordScreen()));
                },
                subtitle: "Search for a chord with a note!",
                title: "Chord Finder",
                color: Color.fromRGBO(120, 155, 210, 0.55),
                titleSize: 28,
                subtitleSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
