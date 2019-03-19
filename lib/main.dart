import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'chords.dart';
import 'package:launch_review/launch_review.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_analytics/observer.dart';
import "my_flutter_app_icons.dart" as CustomIcons;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'appid.dart';
import 'search.dart';
import 'metronome.dart';
import 'quiz.dart';
import 'scales.dart';
import 'examplesongs.dart';
import 'prog.dart';
import 'chordprob.dart';
import 'piano.dart';


void main() { 
  runApp(MyApp());
}

class Note{
  String note;
  int index;
  Note(this.note, this.index);
}

class Chord{
  String note;
  int index;
  List<int> formula;
  Chord(this.note, this.index, this.formula);
}


class Scale{
  String name;
  int index;
  List<int> formula;
  Scale(this.name, this.index, this.formula);
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Scales',  //Notes
      theme: ThemeData(
        primarySwatch: Colors.orange,
        iconTheme: IconThemeData(
          size: 25,
          opacity: 1,
        ),
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: MyHomePage(
        title: "Home Page",
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String instrument;
double textSize = 28.0;
String speed;

double adpadding = 0;   //If banner ad will be used in the future
int showad = 0;
int showad2 = 0;

var clickednote = "";
var clickedindex = 0;
var clickednotescale = "";
var clickedindexscale = 0;
List<Note> notes = [
  Note("A", 0),
  Note("A#", 1),
  Note("B", 2),
  Note("C", 3),
  Note("C#", 4),
  Note("D", 5),
  Note("D#", 6),
  Note("E", 7),
  Note("F", 8),
  Note("F#", 9),
  Note("G", 10),
  Note("G#", 11),
];



class _MyHomePageState extends State<MyHomePage> {
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: ["Music", "Scales", "Guitar", "Piano", "Instrument", "Songs", "Chords"],
  );

  InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: interstitialid, //InterstitialAd.testAdUnitId,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  InterstitialAd myInterstitial2 = InterstitialAd(
    adUnitId: interstitialid, //InterstitialAd.testAdUnitId,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  InterstitialAd myInterstitial3 = InterstitialAd(
    adUnitId: interstitialid, //InterstitialAd.testAdUnitId,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  @override
  void initState() {
    super.initState();
    _loadInstr();
    _loadSpeed();
  }
  
  @override
  void dispose(){
    myInterstitial?.dispose();
    myInterstitial2?.dispose();
    myInterstitial3?.dispose();
    super.dispose();
  }

  _loadInstr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      instrument = (prefs.getString('instrument') ?? "Piano");
    });
  }

  _loadSpeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      speed = (prefs.getString('speed') ?? "Fast");
    });
  }

  bool loaded = false;

  
  _launchURL() async {
    const url = 'mailto:ibraberatkaya@gmail.com?subject=Report%20A%20Bug&body=';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    if(!loaded){
      precacheImage(AssetImage('lib/assets/imgs/logo.jpg'), context);
      loaded = true;
    }

/*    FirebaseAdMob.instance.initialize(appId: appid);
    myInterstitial..load();
    myInterstitial2..load();
    myInterstitial3..load();
    if(showad == 2)
      myInterstitial..load()..show();
    if(showad == 6)
      myInterstitial2..load()..show();
    if(showad == 11)
      myInterstitial3..load()..show();
*/

    
    return Scaffold(
        appBar: AppBar(
          title: Text("Music Scales", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1),)),
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
                  image: AssetImage('lib/assets/imgs/logo.jpg')),
               ),
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(14, 2, 0, 2),
                title: Text('Settings', style: TextStyle(fontSize: 16)),
                leading: Icon(Icons.settings, size: 26, color: Colors.grey[600]),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                },
              ),
              Divider(height: 0, color: Colors.black26,),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(14, 2, 0, 2),
                title: Text('Rate App', style: TextStyle(fontSize: 16)),
                leading: Icon(Icons.star, size: 26, color: Colors.grey[600]),
                onTap: () {
                  LaunchReview.launch(
                    androidAppId: "com.kaya.musicapp",
                  );
                  },
              ),
              Divider(height: 0, color: Colors.black26,),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(14, 2, 0, 2),
                title: Text('Share App', style: TextStyle(fontSize: 16)),
                leading: Icon(Icons.share, size: 26, color: Colors.grey[600]),
                onTap: () {
                  Share.share('Music Scales: https://play.google.com/store/apps/details?id=com.kaya.musicapp');
                  },
              ),
              Divider(height: 0, color: Colors.black26,),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(14, 2, 0, 2),
                title: Text('Feedback', style: TextStyle(fontSize: 16)),
                leading: Icon(Icons.mail_outline, size: 26, color: Colors.grey[600]),
                onTap: () {
                  _launchURL();
                  },
              ),
              Divider(height: 0, color: Colors.black26,),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(14, 2, 0, 2),
                title: Text('About', style: TextStyle(fontSize: 16, color: Colors.black87)),
                leading: Icon(Icons.help_outline, size: 26, color: Colors.grey[600]),
                onTap: () {
                  showAboutDialog(
                    applicationIcon: Tab(icon: Image.asset("lib/assets/imgs/appicon.png"),),
                    applicationName: "Music Scales",
                    context: context,
                    children: <Widget>[
                      Text("Music Scales is an app that shows the user the notes of a scale or a chord in a selected key, and shows chord progressions for free. The simple design lets the user quickly learn the chords, scales, and progressions on a piano and on a guitar."),
                    ]
                  );
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
                      shape: RoundedRectangleBorder(),    //Fixes empty white space in intersections
                      onPressed: (){
                        showad++;
                        clickednote = "A";
                        clickedindex = 0;
                        clickednotescale = "Major";
                        clickedindexscale = 0;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ScalePrintScreen()));
                      },
                      color: Color.fromRGBO(40, 195, 195, 0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(CustomIcons.MyFlutterApp.music_notes, size: 110, color: Color.fromRGBO(200, 0, 0, 1),),
                          Padding(padding: EdgeInsets.only(bottom: 8), child: Text("Scales", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w300),))
                        ],
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(),
                      onPressed: (){
                        showad++;
                        clickednote = "A";
                        clickedindex = 0;
                        clickednotescale = "Major";
                        clickedindexscale = 0;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChordPrintScreen()));
                      },
                      color: Color.fromRGBO(85, 200, 85, 0.7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(CustomIcons.MyFlutterApp.guitar, size: 100, color: Colors.deepPurple,),
                          Padding(padding: EdgeInsets.only(bottom: 8, top: 6), child:Text("Chords", style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w300),))
                        ],
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(),
                      onPressed: (){
                          showad++;
                          clickednote = "A";
                          clickednotescale = "Major";
                          myindex = 0;
                          progmode = "M";
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProgPrintScreen()));
                        },
                      color: Color.fromRGBO(130, 155, 225, 0.75),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 12), child:Icon(CustomIcons.MyFlutterApp.prog, size: 90, color: Colors.green,),),
                          Padding(padding: EdgeInsets.only(bottom: 4, top: 10), child:AutoSizeText("Progressions", maxLines: 1, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w300), overflow: TextOverflow.ellipsis,))
                        ],
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(),
                      onPressed: (){
                          showad++;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PianoScreen()));
                        },
                      color: Color.fromRGBO(180, 105, 10, 0.55),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(CustomIcons.MyFlutterApp.piano, size: 90, color: Colors.black,),
                          Padding(padding: EdgeInsets.only(bottom: 4, top: 10), child:Text("Piano", style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w300), overflow: TextOverflow.ellipsis,))
                        ],
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(),
                      onPressed: (){
                          showad++;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChordProbScreen()));
                        },
                      color: Color.fromRGBO(220, 70, 70, 0.75),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 10),child: Icon(FontAwesomeIcons.dice, size: 70, color: Colors.blueGrey,),),
                          Padding(padding: EdgeInsets.only(top: 14), child:AutoSizeText("Chord\nPossibility", maxLines: 2, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,))
                        ],
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(),
                      onPressed: (){
                          showad++;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SongsListScreen()));
                        },
                      color: Color.fromRGBO(180, 95, 180, 0.55),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.headphones, size: 75, color: Colors.brown[400],),
                          Padding(padding: EdgeInsets.only(top: 14), child:AutoSizeText("Example\nSongs", maxLines: 2, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,))
                        ],
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(),
                      onPressed: (){
                        Random myrand = new Random();
                        mynotes = [
                          QNote("A", 0, 0),
                          QNote("A#", 1, 0),
                          QNote("B", 2, 0),
                          QNote("C", 3, 0),
                          QNote("C#", 4, 0),
                          QNote("D", 5, 0),
                          QNote("D#", 6, 0),
                          QNote("E", 7, 0),
                          QNote("F", 8, 0),
                          QNote("F#", 9, 0),
                          QNote("G", 10, 0),
                          QNote("G#", 11, 0)
                        ];
                        int rand = myrand.nextInt(34);
                        int randkey = myrand.nextInt(12);
                        selectedScale = scales[rand];
                        myScale = calculateScale(selectedScale, randkey);
                        Set choicesset;
                        int answerindex = myrand.nextInt(myScale.length);
                        ansstr = myScale[answerindex].note;
                        myScale[answerindex].note = "?";
                        nums = ["1", "2", "3", "4", "5", "6", "7"];
                        int randset;
                        choicesset = myScale.toSet();
                        QNote answer = new QNote(ansstr, -1, 0);
                        choices = [answer];
                        while(choicesset.length != 4 + myScale.length){
                          randset = myrand.nextInt(12);
                          if(choicesset.add(mynotes[randset]) == true){
                            choices.add(mynotes[randset]);
                          }
                        }
                        choices.shuffle();
                        showad++;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen()));
                        },
                      color: Color.fromRGBO(226,165,13, 0.65),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(CustomIcons.MyFlutterApp.quiz, size: 70, color: Colors.blue,),
                          Padding(padding: EdgeInsets.only(top: 14), child:AutoSizeText("Quiz", maxLines: 1, style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w300), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,))
                        ],
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(),
                      onPressed: (){
                          showad++;
                          allScales = [
                            [
                              [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                            ],
                            [
                              [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                            ],
                            [
                              [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                            ],
                            [
                              [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                            ],
                            [
                              [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                            ],
                            [
                              [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                            ],
                            [
                              [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                            ],
                            [
                              [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                            ],
                            [
                              [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                            ],
                            [
                              [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                            ],
                            [
                              [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                            ],
                            [
                              [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                            ],
                          ];

                          void allScalesCalculate(){
                            for(int i=0; i<12; i++){
                              for(int j=0; j<41; j++){
                                int index=i;
                                for(int k=0; k<searchScales[j].formula.length+1; k++){
                                  if(k != 0)
                                    index += searchScales[j].formula[k-1];
                                  if(index > 11)
                                    index %= 12;
                                  allScales[i][j].add(searchNotes[index]); 
                                }
                              }
                            }
                          }
                          allScalesCalculate();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                        },
                      color: Color.fromRGBO(120, 155, 210, 0.55),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.search, size: 90, color: Colors.deepPurple[600],),
                          Padding(padding: EdgeInsets.only(bottom: 6), child:AutoSizeText("Scale\nFinder", maxLines: 2, style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w300), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,))
                        ],
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(),
                      onPressed: (){
                          showad++;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MetronomeScreen()));
                        },
                      color: Color.fromRGBO(80, 190, 105, 0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(CustomIcons.MyFlutterApp.metronome, size: 90, color: Colors.pink[600],),
                          Padding(padding: EdgeInsets.only(bottom: 4, top: 6), child:Text("Metronome", style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w300), overflow: TextOverflow.ellipsis,))
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


class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  _changeInstr(String temp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('instrument', temp);
    });
  }
  _loadInstr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      instrument = (prefs.getString('instrument') ?? "Piano");
    });
  }
  
  _changeSpeed(String temp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('speed', temp);
    });
  }

  _loadSpeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      speed = (prefs.getString('speed') ?? "Fast");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
          elevation: 1,
      ),
      //bottomNavigationBar: Container(height: adpadding,),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12, 6, 0, 8),
              padding: EdgeInsets.all(6),
              child: Row(              
                children: <Widget>[
                  Text("Default Instrument:    ", style: TextStyle(fontSize: 18),),
                  DropdownButton<String>(
                    hint: Text("$instrument", style: TextStyle(fontSize: 18),),
                    items: <String>["Piano", "Guitar"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text("$value"),
                      );
                    }).toList(),
                    onChanged: (String newValueSelected) {
                      _changeInstr(newValueSelected);
                      _loadInstr();
                    },
                  ),
                ],
              ),
             ),
            Divider(height: 0, color: Color.fromRGBO(0, 0, 200, 0.2),),
            Container(
              margin: EdgeInsets.fromLTRB(12, 6, 0, 8),
              padding: EdgeInsets.all(6),
              child: Row(              
                children: <Widget>[
                  Text("Chord Audio Speed:    ", style: TextStyle(fontSize: 18),),
                  DropdownButton<String>(
                  hint: Text("$speed", style: TextStyle(fontSize: 18),),
                  items: <String>["Fast", "Slow"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text("$value"),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    _changeSpeed(newValueSelected);
                    _loadSpeed();
                   },
                  ),
                ],
              ),
             ),
            Divider(height: 0, color: Color.fromRGBO(0, 0, 200, 0.2),),
          ],
        ),
      ),
    );
  }
}
