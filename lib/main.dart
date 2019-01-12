import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'chords.dart';
import 'scales.dart';
import 'prog.dart';

void main() { 
  /*SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {*/runApp(MyApp());/*});*/
}

class Note{
  String note;
  int index;
  Note(this.note, this.index);
}

class Scale{
  String name;
  int index;
  Scale(this.name, this.index);
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

double textSize;
int typeselect;   //0 for scale, 1 for chord, 2 for progression
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

@override
  void initState() {
    super.initState();
    _loadSize();
  }

  _loadSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      textSize = (prefs.getDouble('textSize') ?? 28.0);
    });
  }

  @override
  Widget build(BuildContext context) {

    return new ListTileTheme(
      iconColor: Colors.red,
      child:
       Scaffold(
        appBar: AppBar(
          title: Text("Music Scales", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
        ),
        drawer: Drawer(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
              height: 110,
              child: DrawerHeader(
                child: Padding(
                  child: Text('Menu', style: TextStyle(fontSize: 24)),
                  padding: EdgeInsets.fromLTRB(12, 6, 0, 0),
                  ),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                ),
               ),
              ),
              //Padding(padding: EdgeInsets.fromLTRB(4, 0, 2, 0), child: Divider(height: 4, color: Colors.black54,)),
              ListTile(
                title: Text('Settings', style: TextStyle(fontSize: 18)),
                trailing: Icon(Icons.settings),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Flexible(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("Scales", style: TextStyle(fontSize: textSize + 4),),
                    contentPadding: EdgeInsets.fromLTRB(24, -12 + textSize * 0.95, 0, -12 + textSize * 1),
                    onTap: (){
                      typeselect = 0;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen()));
                    },
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(4, 0, 2, 0), child: Divider(height: 4, color: Colors.black54,)),
                  ListTile(
                    title: Text("Chords", style: TextStyle(fontSize: textSize + 4),),
                    contentPadding: EdgeInsets.fromLTRB(24, -12 + textSize * 0.95, 0, -12 + textSize * 1),
                    onTap: (){
                      typeselect = 1;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen()));
                    },
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(4, 0, 2, 0), child: Divider(height: 4, color: Colors.black54,)),
                  ListTile(
                    title: Text("Progressions", style: TextStyle(fontSize: textSize + 2),),
                    contentPadding: EdgeInsets.fromLTRB(24, -12 + textSize * 0.95, 0, -12 + textSize * 1),
                    onTap: (){
                      typeselect = 2;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen()));
                    },
                  ),
                  //Padding(padding: EdgeInsets.fromLTRB(4, 0, 2, 0), child: Divider(height: 4, color: Colors.black54,)),
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
        body: GridView.count(
          physics: BouncingScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1,
          padding: EdgeInsets.fromLTRB(12, 24, 12, 0),
          children: List.generate(12, (index){
            
            return Center(
              child: GestureDetector(
                onTap: (){
                  clickedindex = notes[index].index;
                  clickednote = notes[index].note;
                  key = notes[index].note;
                  if(typeselect == 0) 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ScaleScreen()));
                  else if(typeselect == 1) 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChordScreen()));
                  else if(typeselect == 2) 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProgScreen()));
                },
                child:Container( 
                  width: 40 + textSize * 1.65,
                  height: 40 + textSize * 1.65,
                  decoration: BoxDecoration(color: Color.fromRGBO(110,240,255,0.15), borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: Text("${notes[index].note}", style: TextStyle(color: Color.fromRGBO(255, 39, 43, 1), fontSize: textSize * 1.2),)),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
          elevation: 1,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
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
                Divider(height: 1, color: Color.fromRGBO(0, 0, 200, 0.2),),
          ],
        ),
      ),
    );
  }
}
