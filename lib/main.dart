import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'chords.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'appid.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        iconTheme: IconThemeData(
          size: 25,
          opacity: 1,
        ),
      ),
      home: MyHomePage(title: 'Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String instrument;
double textSize = 28.0;
String speed;
int typeselect;   //0 for scale, 1 for chord, 2 for progression

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

  @override
  void initState() {
    super.initState();
    //_loadSize();
    _loadInstr();
    _loadSpeed();
  }
  
  @override
  void dispose(){
    myInterstitial?.dispose();
    myInterstitial2?.dispose();
    super.dispose();
  }

  _loadInstr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      instrument = (prefs.getString('instrument') ?? "Piano");
    });
  }

  /*_loadSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      textSize = (prefs.getDouble('textSize') ?? 28.0);
    });
  }*/

  _loadSpeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      speed = (prefs.getString('speed') ?? "Fast");
    });
  }

  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    if(!loaded){
      precacheImage(AssetImage('lib/assets/imgs/logo.jpg'), context);
      loaded = true;
    }

    FirebaseAdMob.instance.initialize(appId: appid);
    myInterstitial..load();
    myInterstitial2..load();
    if(showad > 2)
      myInterstitial..load()..show();
    if(showad2 > 12)
      myInterstitial2..load()..show();


    
    return new ListTileTheme(
      iconColor: Colors.red,
      child:
       Scaffold(
        appBar: AppBar(
          title: Text("Music Scales", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
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
              Padding(padding: EdgeInsets.fromLTRB(2, 1, 2, 0), child: Divider(height: 0, color: Colors.black54,)),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 6, 15, 6),
                title: Text('Settings', style: TextStyle(fontSize: 18)),
                trailing: Icon(Icons.settings),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                },
              ),
              Padding(padding: EdgeInsets.fromLTRB(2, 1, 2, 0), child: Divider(height: 0, color: Colors.black54,)),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 6, 15, 6),
                title: Text('About', style: TextStyle(fontSize: 18, color: Colors.black87)),
                trailing: Icon(Icons.help_outline),
                onTap: () {showAboutDialog(
                  applicationIcon: Tab(icon: Image.asset("lib/assets/imgs/appicon.png"),),
                  applicationName: "Music Scales",
                  context: context,
                  children: <Widget>[
                    Text("Music Scales is an app that shows the user the notes of a scale or a chord in a selected key, and shows chord progressions for free. The simple design lets the user quickly learn the chords, scales, and progressions on a piano and on a guitar."),
                  ]
                  );
                },
              )
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: RaisedButton(
                      onPressed: (){
                          showad++;
                          showad2++;
                          typeselect = 0;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen()));
                        },
                        elevation: 1,
                        highlightElevation: 1,
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        color: Color.fromRGBO(240, 120, 120, 0.7),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        child: Center( child: Text("Scales 🎼", style: TextStyle(fontSize: textSize + 1, fontWeight: FontWeight.normal),),),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(4, 0, 4, 0), child: Divider(height: 0, color: Colors.black54,)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: RaisedButton(
                      onPressed: (){
                        showad++;
                        showad2++;
                        typeselect = 1;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen()));
                      },
                      elevation: 1,
                      highlightElevation: 1,
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      color: Color.fromRGBO(120, 240, 120, 0.7),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child:  Center( child: Text("Chords 🎸", style: TextStyle(fontSize: textSize + 1, fontWeight: FontWeight.normal),),),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(4, 0, 4, 0), child: Divider(height: 0, color: Colors.black54,)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: RaisedButton(
                      onPressed: (){
                          showad++;
                          showad2++;
                          typeselect = 2;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen()));
                        },
                      elevation: 1,
                      highlightElevation: 1,
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      color: Color.fromRGBO(150, 165, 250, 0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child:  Center( child: Text("Progressions 🎶", style: TextStyle(fontSize: textSize + 1, fontWeight: FontWeight.normal),),),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(4, 0, 4, 0), child: Divider(height: 0, color: Colors.black54,)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: RaisedButton(
                      onPressed: (){
                          showad++;
                          showad2++;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PianoScreen()));
                        },
                      elevation: 1,
                      highlightElevation: 1,
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      color: Color.fromRGBO(250, 135, 50, 0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child:  Center( child: Text("Piano 🎹", style: TextStyle(fontSize: textSize + 1, fontWeight: FontWeight.normal),),),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(4, 0, 4, 0), child: Divider(height: 0, color: Colors.black54,)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: RaisedButton(
                      onPressed: (){
                          showad++;
                          showad2++;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChordProbScreen()));
                        },
                      elevation: 1,
                      highlightElevation: 1,
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      color: Color.fromRGBO(50, 235, 250, 0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child:  Center( child: Text("Chord Possibility 🎲", style: TextStyle(fontSize: textSize - 1, fontWeight: FontWeight.normal),),),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(4, 0, 4, 0), child: Divider(height: 0, color: Colors.black54,)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: RaisedButton(
                      onPressed: (){
                          showad++;
                          showad2++;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SongsListScreen()));
                        },
                      elevation: 1,
                      highlightElevation: 1,
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      color: Color.fromRGBO(250, 135, 250, 0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child:  Center( child: Text("Example Songs 🎧", style: TextStyle(fontSize: textSize - 1, fontWeight: FontWeight.normal),),),
                    ),
                  ),
                ],
              ),
              ),
            ],
          ),
        ),
      )
      );
    }
  }

class NoteScreen extends StatelessWidget {
   @override
  Widget build(BuildContext context) {

    
    return
       Scaffold(
        appBar: AppBar(
          title: Text("Notes", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
        ),
        
        //bottomNavigationBar: Container(height: adpadding,),
        body: GridView.count(
          physics: BouncingScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1,
          padding: EdgeInsets.fromLTRB(12, 24, 12, 0),
          children: List.generate(12, (index){
            return Center(
              child: Container( 
                  width: 42 + textSize * 1.65,
                  height: 42 + textSize * 1.65,
                  //decoration: BoxDecoration(, borderRadius: BorderRadius.circular(36)),
                child:RaisedButton(
                  onPressed: (){
                    showad++;
                    showad2++;
                    clickedindex = notes[index].index;
                    clickednote = notes[index].note;
                    key = notes[index].note;
                    if(typeselect == 0 || typeselect == 1){
                      clickedindexscale = 0;
                      clickednotescale = "Major";
                    }
                    if(typeselect == 0) 
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ScalePrintScreen()));
                    else if(typeselect == 1) 
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChordPrintScreen()));
                    else if(typeselect == 2) 
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProgScreen()));
                  },
                  elevation: 1,
                  highlightElevation: 1,
                  color: Color.fromRGBO(202, 242, 242, 0.9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(42)),
                  
                  child:  Center(
                      child: Text("${notes[index].note}", style: TextStyle(color: Color.fromRGBO(255, 19, 23, 1), fontSize: textSize * 1.2, fontWeight: FontWeight.normal),)),
                    ),
                ),
              );
            }
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
/*
  _changeText(double temp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble('textSize', temp);
    });
  }
  _loadSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      textSize = (prefs.getDouble('textSize') ?? 28.0);
    });
  }
*/
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
              margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
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
              margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
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
            /*Container(
              margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
              padding: EdgeInsets.all(5),
              child: Row(              
                children: <Widget>[
                  Text("Select Text Size:  ", style: TextStyle(fontSize: 18),),
                  DropdownButton<double>(
                  hint: Text("${textSize.toInt()}", style: TextStyle(fontSize: 18),),
                  items: <double>[24, 26, 28, 30].map((double value) {
                    return DropdownMenuItem<double>(
                      value: value,
                      child: Text("${value.toInt()}"),
                    );
                  }).toList(),
                  onChanged: (double newValueSelected) {
                    _changeText(newValueSelected);
                    _loadSize();
                   },
                  ),
                ],
              ),
             ),
                Divider(height: 1, color: Color.fromRGBO(0, 0, 200, 0.2),),*/
          ],
        ),
      ),
    );
  }
}
