import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_scales/domain/core/const.dart';
import 'package:music_scales/infrastructure/ads/ads.dart';
import 'package:music_scales/presentation/chords/chord_probability.dart';
import 'package:music_scales/presentation/example_songs/example_songs.dart';
import 'package:music_scales/presentation/piano/piano.dart';
import 'package:music_scales/presentation/progression/progression_detail.dart';
import 'package:music_scales/presentation/widgets/card/card.dart';
import '../icons/my_flutter_app_icons.dart' as CustomIcons;

class ProgressionPage extends StatefulWidget {
  @override
  _ProgressionPageState createState() => _ProgressionPageState();
}

class _ProgressionPageState extends State<ProgressionPage> {
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
                icon: Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Icon(
                    FontAwesomeIcons.dice,
                    size: 48,
                    color: Colors.blueGrey,
                  ),
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
                          builder: (context) => ChordProbScreen()));
                },
                subtitle: "View possibilites about popular chord progressions!",
                title: "Chord Possibility",
                color: Color.fromRGBO(220, 70, 70, 0.75),
                titleSize: 24,
                subtitleSize: 16,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: ButtonCard(
                icon: Icon(
                  CustomIcons.MyFlutterApp.piano,
                  size: 48,
                  color: Colors.black,
                ),
                onPressed: () async {
                  showad++;
                  if (showad % adFreq == 1) {
                    final myInterstitialAd = interstitialAd();
                    await myInterstitialAd.load();
                    await myInterstitialAd.show();
                  }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PianoScreen()));
                },
                subtitle: "Play notes on a piano!",
                title: "Piano",
                color: Color.fromRGBO(180, 105, 10, 0.55),
                titleSize: 32,
                subtitleSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: ButtonCard(
                icon: Icon(
                  FontAwesomeIcons.headphones,
                  size: 48,
                  color: Colors.brown[400],
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
                          builder: (context) => SongsListScreen()));
                },
                subtitle: "View example songs with a progression!",
                title: "Example Songs",
                color: Color.fromRGBO(180, 95, 180, 0.55),
                titleSize: 26,
                subtitleSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
