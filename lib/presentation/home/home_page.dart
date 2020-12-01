import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_scales/application/actions/settings_action.dart';
import 'package:music_scales/application/reducers/settings_reducer.dart';
import 'package:music_scales/application/store/store.dart';
import 'package:music_scales/domain/chords/chords.dart';
import 'package:music_scales/domain/core/const.dart';
import 'package:music_scales/domain/notes/notes.dart';
import 'package:music_scales/domain/scales/scales.dart';
import 'package:music_scales/domain/settings/settings.dart';
import 'package:music_scales/infrastructure/ads/ads.dart';
import 'package:music_scales/presentation/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../chords/chords.dart';
import 'package:launch_review/launch_review.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_analytics/observer.dart';
import '../icons/my_flutter_app_icons.dart' as CustomIcons;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import '../scale/search.dart';
import '../quiz/quiz.dart';
import '../scale/scales.dart';
import '../example_songs/example_songs.dart';
import '../progression/progression.dart';
import '../chords/chord_probability.dart';
import '../piano/piano.dart';
import '../chords/search_chord.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.analytics, this.observer})
      : super(key: key);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  int showad = 0;
  int adFreq = 100;

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String defaultinstrument = (prefs.getString('instrument') ?? "Piano");
    bool fastChordAudioSpeed = (prefs.getBool('fastChordAudioSpeed') ?? true);
    bool showFlatsInScales = (prefs.getBool('showFlatsInScales') ?? false);
    Settings settings = Settings(
      showFlatsInScales: showFlatsInScales,
      fastChordAudioSpeed: fastChordAudioSpeed,
      instrument: defaultinstrument,
    );
    store.dispatch(SettingsAction(
        settingsActionType: SettingsActionType.setSettings, payload: settings));
  }

  Future<void> _launchPrivPol() async {
    const url = "https://kayaib17.github.io/MusicScalesPrivacyPolicy/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Scales",
            style: TextStyle(
              color: Color.fromRGBO(20, 20, 20, 1),
            )),
        elevation: 1,
      ),
      //bottomNavigationBar: Container(height: adpadding,),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              //height: 110,
              color: Colors.orangeAccent,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/imgs/logo.jpg')),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
              title: Text('Settings', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.settings, size: 24, color: Colors.grey[600]),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
            ),
            Divider(
              height: 0,
              color: Colors.black26,
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
              title: Text('Rate App', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.star, size: 24, color: Colors.grey[600]),
              onTap: () {
                LaunchReview.launch(
                    androidAppId: "com.kaya.musicapp", iOSAppId: "1498463498");
              },
            ),
            Divider(
              height: 0,
              color: Colors.black26,
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
              title: Text('Share App', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.share, size: 24, color: Colors.grey[600]),
              onTap: () {
                if (Platform.isAndroid) {
                  Share.share(
                      'Music Scales: https://play.google.com/store/apps/details?id=com.kaya.musicapp');
                } else {
                  Share.share(
                      'Music Scales: https://apps.apple.com/us/app/music-scales/id1498463498');
                }
              },
            ),
            if (Platform.isAndroid) ...[
              Divider(
                height: 0,
                color: Colors.black26,
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                title: Text('Get Ad Free', style: TextStyle(fontSize: 15)),
                leading: Icon(Icons.shop, size: 24, color: Colors.grey[600]),
                onTap: () {
                  LaunchReview.launch(
                    androidAppId: "com.kaya.musicapppro",
                  );
                },
              ),
            ],
            Divider(
              height: 0,
              color: Colors.black26,
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
              title: Text('About',
                  style: TextStyle(fontSize: 15, color: Colors.black87)),
              leading:
                  Icon(Icons.help_outline, size: 24, color: Colors.grey[600]),
              onTap: () {
                showAboutDialog(
                    applicationIcon: Tab(
                      icon: Image.asset("assets/imgs/appicon.png"),
                    ),
                    applicationName: "Music Scales",
                    context: context,
                    children: <Widget>[
                      Text(
                          "Music Scales is an app that shows the user the notes of a scale or a chord in a selected key, and shows chord progressions for free. The simple design lets the user quickly learn the chords, scales, and progressions on a piano and on a guitar."),
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 16, 14, 0),
                          child: FlatButton(
                              color: Color.fromRGBO(250, 240, 240, 0.6),
                              child: Text("Privacy Policy",
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 11)),
                              onPressed: () {
                                _launchPrivPol();
                              })),
                    ]);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
              child: StaggeredGridView.count(
                crossAxisCount: 2,
                staggeredTiles: [
                  StaggeredTile.count(2, 1),
                  StaggeredTile.count(1, 1),
                  StaggeredTile.count(1, 1),
                  StaggeredTile.count(1, 1),
                  StaggeredTile.count(1, 1),
                  StaggeredTile.count(1, 1),
                  StaggeredTile.count(1, 1),
                  StaggeredTile.count(1, 1),
                  StaggeredTile.count(1, 1),
                ],
                children: <Widget>[
                  FlatButton(
                    shape:
                        RoundedRectangleBorder(), //Fixes empty white space in intersections
                    onPressed: () async {
                      showad++;
                      if (showad % adFreq == 1) {
                        print("show ad");
                        final myInterstitialAd = interstitialAd();
                        await myInterstitialAd.load();
                        await myInterstitialAd.show();
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScalePrintScreen()));
                    },
                    color: Color.fromRGBO(30, 195, 195, 0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          CustomIcons.MyFlutterApp.music_notes,
                          size: 108,
                          color: Color.fromRGBO(200, 0, 0, 1),
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "Scales",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w300),
                            ))
                      ],
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(),
                    onPressed: () async {
                      showad++;
                      if (showad % adFreq == 1) {
                        print("show ad");
                        final myInterstitialAd = interstitialAd();
                        await myInterstitialAd.load();
                        await myInterstitialAd.show();
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChordPrintScreen()));
                    },
                    color: Color.fromRGBO(85, 200, 85, 0.7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          CustomIcons.MyFlutterApp.guitar,
                          size: 98,
                          color: Colors.deepPurple,
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 8, top: 6),
                            child: Text(
                              "Chords",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w300),
                            ))
                      ],
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(),
                    onPressed: () async {
                      showad++;
                      if (showad % adFreq == 1) {
                        print("show ad");
                        final myInterstitialAd = interstitialAd();
                        await myInterstitialAd.load();
                        await myInterstitialAd.show();
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProgPrintScreen()));
                    },
                    color: Color.fromRGBO(130, 155, 240, 0.75),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(
                            CustomIcons.MyFlutterApp.prog,
                            size: 86,
                            color: Colors.green,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 4, top: 10),
                            child: AutoSizeText(
                              "Progressions",
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300),
                              overflow: TextOverflow.ellipsis,
                            ))
                      ],
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(),
                    onPressed: () async {
                      showad++;
                      if (showad % adFreq == 1) {
                        print("show ad");
                        final myInterstitialAd = interstitialAd();
                        await myInterstitialAd.load();
                        await myInterstitialAd.show();
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PianoScreen()));
                    },
                    color: Color.fromRGBO(180, 105, 10, 0.55),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          CustomIcons.MyFlutterApp.piano,
                          size: 88,
                          color: Colors.black,
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 4, top: 10),
                            child: Text(
                              "Piano",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w300),
                              overflow: TextOverflow.ellipsis,
                            ))
                      ],
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(),
                    onPressed: () async {
                      showad++;
                      if (showad % adFreq == 1) {
                        print("show ad");
                        final myInterstitialAd = interstitialAd();
                        await myInterstitialAd.load();
                        await myInterstitialAd.show();
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChordProbScreen()));
                    },
                    color: Color.fromRGBO(220, 70, 70, 0.75),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            FontAwesomeIcons.dice,
                            size: 68,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 14),
                            child: AutoSizeText(
                              "Chord\nPossibility",
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w300),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(),
                    onPressed: () async {
                      showad++;
                      if (showad % adFreq == 1) {
                        print("show ad");
                        final myInterstitialAd = interstitialAd();
                        await myInterstitialAd.load();
                        await myInterstitialAd.show();
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SongsListScreen()));
                    },
                    color: Color.fromRGBO(180, 95, 180, 0.55),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.headphones,
                          size: 72,
                          color: Colors.brown[400],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 14),
                            child: AutoSizeText(
                              "Example\nSongs",
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w300),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(),
                    onPressed: () async {
                      showad++;
                      if (showad % adFreq == 1) {
                        print("show ad");
                        final myInterstitialAd = interstitialAd();
                        await myInterstitialAd.load();
                        await myInterstitialAd.show();
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizScreen()));
                    },
                    color: Color.fromRGBO(226, 175, 13, 0.65),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          CustomIcons.MyFlutterApp.quiz,
                          size: 68,
                          color: Colors.blue,
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 14),
                            child: AutoSizeText(
                              "Quiz",
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w300),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(),
                    onPressed: () async {
                      showad++;
                      if (showad % adFreq == 1) {
                        print("show ad");
                        final myInterstitialAd = interstitialAd();
                        await myInterstitialAd.load();
                        await myInterstitialAd.show();
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                    },
                    color: Color.fromRGBO(120, 155, 210, 0.55),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          size: 88,
                          color: Colors.deepPurple[600],
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 6),
                            child: AutoSizeText(
                              "Scale\nFinder",
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w300),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(),
                    onPressed: () async {
                      showad++;
                      if (showad % adFreq == 1) {
                        print("show ad");
                        final myInterstitialAd = interstitialAd();
                        await myInterstitialAd.load();
                        await myInterstitialAd.show();
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchChordScreen()));

                      //  Navigator.push(context, MaterialPageRoute(builder: (context) => MetronomeScreen()));
                    },
                    color: Color.fromRGBO(80, 190, 105, 0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          size: 88,
                          color: Colors.pink[600],
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 6),
                            child: AutoSizeText(
                              "Chord\nFinder",
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w300),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
