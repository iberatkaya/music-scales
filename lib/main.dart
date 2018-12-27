import 'package:flutter/material.dart';

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
      home: MyHomePage(title: '   Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

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
  Widget build(BuildContext context) {

    return new ListTileTheme(
      iconColor: Colors.red,
      child:
       Scaffold(
        appBar: AppBar(
          title: Text("  Notes", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
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
                    contentPadding: EdgeInsets.fromLTRB(4, 6, 0, 10),
                    dense: true,
                    onTap:() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
                      clickedindex = notes[index].index;
                      clickednote = notes[index].note;
                    },
                    title: Text(notes[index].note ?? 'broke', style: TextStyle(fontSize: 28)),
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

class SecondScreen extends StatelessWidget {
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
                      contentPadding: EdgeInsets.fromLTRB(4, 6, 0, 10),
                      dense: true,
                      onTap:() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdScreen()));
                        clickedindexscale = scales[index].index;
                        clickednotescale = scales[index].name;
                      },
                      title: Text(scales[index].name ?? 'broke', style: TextStyle(fontSize: 26)),
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

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String calculateScale(var mode, var key){
    	String theScale = "";
      var index = key;
	    for(int i=0; i<7; i++){
	    	if((i == 2 || i == 5) && mode == 1)
		    	index--;
		    else if(mode == 0 && (i == 3 || i == 7))
			    index--;
		    if(index > 11)
			    index %= 12;
        if(i == 4)
          theScale += '\n';
	    	theScale += notes[index].note + " ";
        index += 2;
	    	}
      return theScale;
      };

    return Scaffold(
      appBar: AppBar(
        title: Text("The $clickednote $clickednotescale Scale", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(5, 35, 5, 0),
              child: Text(calculateScale(clickedindexscale, clickedindex), textAlign: TextAlign.center, style: TextStyle(fontSize: 60, color: Colors.red),),
           ),
      ],
      ),
      ),
    );
  }
}

