import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chords.dart';
import 'scales.dart';

void main() => runApp(MyApp());

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
int typeselect;   //0 for scale, 1 for chord
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

    return new ListTileTheme(
      iconColor: Colors.red,
      child:
       Scaffold(
        appBar: AppBar(
          title: Text("Notes", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Flexible(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(10,6,10,0),
                itemCount: notes.length,
                separatorBuilder:(BuildContext context, int index) => Divider(height: 4, color: Color.fromRGBO(0, 0, 200, 0.2),),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.fromLTRB(4, -12 + textSize * 0.80, 0, -12 + textSize * 0.85),
                    dense: true,
                    onTap:() {
                      if(typeselect == 0)
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ScaleScreen()));
                      else if(typeselect == 1)
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChordScreen()));
                      clickedindex = notes[index].index;
                      clickednote = notes[index].note;
                    },
                    title: Text(notes[index].note ?? 'broke', style: TextStyle(fontSize: textSize)),
                    leading: Icon(Icons.music_note),
                  );
                },
              )
              ),
            ],
          ),
        ),
      )
      );
    }
}


class ScaleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Scale> scales = [
      Scale("Major", 0),
      Scale("Minor", 1),
    ];
    return ListTileTheme(
      iconColor: Colors.red,
      child:
      Scaffold(
        appBar: AppBar(
          title: Text("Choose a Scale For $clickednote", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
  //             Text("$clickedindex $clickednote"),
              Flexible(
                child: ListView.separated(
                  padding: EdgeInsets.all(10.0),
                  itemCount: scales.length,
                  separatorBuilder:(BuildContext context, int index) => Divider(height: 4, color: Color.fromRGBO(0, 0, 200, 0.2),),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(4, -12 + textSize * 0.85, 0, -12 + textSize * 0.90),
                      dense: true,
                      onTap:() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ScalePrintScreen()));
                        clickedindexscale = scales[index].index;
                        clickednotescale = scales[index].name;
                      },
                      title: Text(scales[index].name ?? 'broke', style: TextStyle(fontSize: textSize)),
                      leading: Icon(Icons.music_note),
                    );
                },
              )
              ),
            ],
        ),
        ),
      )
    );
  }
}



class ScalePrintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> calculateScale(var mode, var key){
    	List<String> theScale = [];
      var index = key;
	    for(int i=0; i<7; i++){
	    	if((i == 2 || i == 5) && mode == 1)
		    	index--;
		    else if(mode == 0 && (i == 3 || i == 7))
			    index--;
		    if(index > 11)
			    index %= 12;
	    	theScale.add(notes[index].note);
        index += 2;
	    	}
      return theScale;
      }
    List<String> myScale;
    myScale = calculateScale(clickedindexscale, clickedindex);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("The $clickednote $clickednotescale Scale", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            /*Container(
              margin: EdgeInsets.fromLTRB(5, 35, 5, 0),
              child: Text(calculateScale(clickedindexscale, clickedindex), textAlign: TextAlign.center, style: TextStyle(fontSize: 20 + textSize * 1.15, color: Colors.red),),
           ),*/
           Padding(padding: EdgeInsets.fromLTRB(56 - textSize, 28, 56-textSize, 18), child: Table(
             border: TableBorder.all(width: 2, color: Color.fromRGBO(150, 0, 40, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("1", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("2", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("3", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("4", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[0]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[1]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[2]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[3]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                  ),
                ],
              ),
              ],
           ),),
           Padding(padding: EdgeInsets.fromLTRB(72 - textSize * 0.35, 0, 72 - textSize * 0.35, 0), child: Table(
             border: TableBorder.all(width: 2, color: Color.fromRGBO(150, 0, 40, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("5", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("6", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("7", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[4]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[5]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[6]}", style: TextStyle(fontSize: textSize * 1.1 , color: Colors.red),))),
                  ),
                ],
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
                items: <double>[20, 24, 26, 28, 30, 32].map((double value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text("${value.toInt()}"),
                  );
                }).toList(),
                onChanged: (double newValueSelected) {
                  _changeText(newValueSelected);
                  _loadSize();
                  //textSize = newValueSelected;
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
