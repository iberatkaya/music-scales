import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main.dart';
import 'dart:math';

void main() => runApp(ProgScreen());

class Chord{
  String name;
  String mode;
  int index;
  Chord(this.name, this.mode, this.index);
}
List<Chord> majorChords = [
  Chord("A", "M", 0),
  Chord("A#", "M", 1),
  Chord("B", "M", 2),
  Chord("C", "M", 3),
  Chord("C#", "M", 4),
  Chord("D", "M", 5),   
  Chord("D#", "M", 6),
  Chord("E", "M", 7),
  Chord("F", "M", 8),
  Chord("F#", "M", 9),
  Chord("G", "M", 10),
  Chord("G#", "M", 11),
];
List<Chord> minorChords = [   
  Chord("Am", "m", 0),
  Chord("A#m", "m", 1),
  Chord("Bm", "m", 2),    
  Chord("Cm", "m", 3),
  Chord("C#m", "m", 4),
  Chord("Dm", "m", 5),
  Chord("D#m", "m", 6),
  Chord("Em", "m", 7),
  Chord("Fm", "m", 8),
  Chord("F#m", "m", 9),
  Chord("Gm", "m", 10),
  Chord("G#m", "m", 11), 
];
List<Chord> dimChords = [
  Chord("Adim", "dim", 0),
  Chord("A#dim", "dim", 1),
  Chord("Bdim", "dim", 2),
  Chord("Cdim", "dim", 3),
  Chord("C#dim", "dim", 4),
  Chord("Ddim", "dim", 5),
  Chord("D#dim", "dim", 6),
  Chord("Edim", "dim", 7),
  Chord("Fdim", "dim", 8),
  Chord("F#dim", "dim", 9),
  Chord("Gdim", "dim", 10),
  Chord("G#dim", "dim", 11),
];

String mode;
String key;
int myindex;
List<Chord> theScale;

class ProgScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
  
    List<Scale> scales = [
      Scale("Major", 0),
      Scale("Minor", 1),
    ];
    return ListTileTheme(
      iconColor: Colors.red,
      child:
      Scaffold(
        appBar: AppBar(
          title: Text("Choose a Chord For $clickednote", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(10, 4, 10, 10),
                  itemCount: scales.length,
                  separatorBuilder:(BuildContext context, int index) => Divider(height: 4, color: Color.fromRGBO(0, 0, 200, 0.2),),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(4, -12 + textSize * 0.85, 0, -12 + textSize * 0.90),
                      dense: true,
                      onTap:() {
                        myindex = clickedindex;
                        if(scales[index].index == 0)
                          mode = "M";
                        else if(scales[index].index == 1)
                          mode = "m";
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProgPrintScreen()));
                      },
                      title: Text(scales[index].name ?? 'broke', style: TextStyle(fontSize: textSize)),
                      leading: Icon(FontAwesomeIcons.itunesNote),
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

class ProgPrintScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    List<Chord> scaleChords(String themode, int thekey){
    List<Chord> theChords = [];
    int index = thekey;
    if(themode == "M"){    
      for(int i=0; i<7; i++){   //3 5 7 8 10 0 2
		    if(i == 3)
          index--;
        if(index > 11)
			    index %= 12;
        if(i == 1 || i == 2 || i == 5){
          theChords.add(minorChords[index]);
          }
        else if(i != 6)
          theChords.add(majorChords[index]);
        else 
          theChords.add(dimChords[index]);
        index += 2;
	    	}
      }
    if(themode == "m"){
      for(int i=0; i<7; i++){   //0 2 3 5 7 8 10
		    if(i == 2 || i == 5)
          index--;
        if(index > 11)
			    index %= 12;
        if(i == 0 || i == 3 || i == 4){
          theChords.add(minorChords[index]);
          }
        else if(i != 1)
          theChords.add(majorChords[index]);
        else 
          theChords.add(dimChords[index]);
        index += 2;
	    	}  
    }
    return theChords;
    }
  theScale = scaleChords(mode, myindex);


  return Scaffold(
    appBar: AppBar(
      title: Text("The ${theScale[0].name} Diatonic Chords", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
      elevation: 1,
     ),
    floatingActionButton: FloatingActionButton(
      child: Icon(FontAwesomeIcons.diceFour),
      elevation: 2,
      backgroundColor: Colors.orangeAccent,
      foregroundColor: Colors.deepPurple,
      tooltip: "Generate a random progression",
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => RandomProgScreen()));
      },
    ),
    
    body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(42 - textSize, 28, 42-textSize, 18), child: Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
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
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[0].name}", style: TextStyle(fontSize: textSize * 0.85, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[1].name}", style: TextStyle(fontSize: textSize * 0.85, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[2].name}", style: TextStyle(fontSize: textSize * 0.85, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[3].name}", style: TextStyle(fontSize: textSize * 0.85, color: Colors.red),))),
                  ),
                ],
              ),
              ],
           ),),
           Padding(padding: EdgeInsets.fromLTRB(58 - textSize * 0.35, 0, 58 - textSize * 0.35, 0), child: Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
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
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[4].name}", style: TextStyle(fontSize: textSize * 0.85, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[5].name}", style: TextStyle(fontSize: textSize * 0.85, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[6].name}", style: TextStyle(fontSize: textSize * 0.85 , color: Colors.red),))),
                  ),
                ],
              ),
              ],
           ),
           ),
         ],
       ),
       ),
      ),
    );
  }
}


class RandomProgScreen extends StatelessWidget{
  Widget build(BuildContext content){
    List<List> progs(){
      List<List> theProgs;
      if(mode == "M")
        theProgs = [[1, 4, 5], [1, 5, 6, 4], [2, 5, 1], [1, 6, 4, 5], [1, 4, 2, 5], [1, 4, 1, 5], [1, 3, 4, 5]];
      else if(mode == "m")
        theProgs = [[1, 6, 7], [1, 4, 6], [1, 4, 5], [1, 6, 3, 7], [1, 7, 6, 7], [6, 7, 1, 1], [1, 4, 5, 1]];
      return theProgs;
    }
    List<List> progressions = progs();
    Column progTable(int number){
      if(progressions[number].length == 3){
        return Column(children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(0, 26, 0, 6), child:Text("Formula: ${progressions[number][0]} - ${progressions[number][1]} - ${progressions[number][2]}", style: TextStyle(fontSize: 28, color: Color.fromRGBO(70, 70, 70, 0.8)),),),
          Padding(padding: EdgeInsets.fromLTRB(8, 2, 8, 0), child: Divider(color: Color.fromRGBO(30, 30, 30, 0.7),),),
          Padding(
            padding: EdgeInsets.fromLTRB(56 - textSize * 0.45, 20, 56 - textSize * 0.45, 0),
            child: Table(
              border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
              children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${progressions[number][0]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${progressions[number][1]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${progressions[number][2]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[progressions[number][0]-1].name}", style: TextStyle(fontSize: textSize, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[progressions[number][1]-1].name}", style: TextStyle(fontSize: textSize, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[progressions[number][2]-1].name}", style: TextStyle(fontSize: textSize, color: Colors.red),))),
                  ),
                ],
              ),
              ],
              ),
            )
            ],
          );
        }
        if(progressions[number].length == 4){
          return Column(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(0, 26, 0, 6), child:Text("Formula: ${progressions[number][0]} - ${progressions[number][1]} - ${progressions[number][2]} - ${progressions[number][3]}", style: TextStyle(fontSize: 28, color: Color.fromRGBO(70, 70, 70, 0.8)),),),
            Padding(padding: EdgeInsets.fromLTRB(8, 2, 8, 0), child: Divider(color: Color.fromRGBO(30, 30, 30, 0.7),),),
            Padding(padding: EdgeInsets.fromLTRB(44 - textSize * 0.6, 20, 44 - textSize * 0.6, 0), 
              child:Table(
                border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
                children: <TableRow>[
                  TableRow(
                    children: <TableCell>[
                      TableCell(
                        child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${progressions[number][0]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                      ),
                      TableCell(
                        child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${progressions[number][1]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                      ),
                      TableCell(
                        child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${progressions[number][2]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                      ),
                      TableCell(
                        child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${progressions[number][3]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <TableCell>[
                      TableCell(
                        child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[progressions[number][0]-1].name}", style: TextStyle(fontSize: textSize, color: Colors.red),))),
                      ),
                      TableCell(
                        child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[progressions[number][1]-1].name}", style: TextStyle(fontSize: textSize, color: Colors.red),))),
                      ),
                      TableCell(
                        child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[progressions[number][2]-1].name}", style: TextStyle(fontSize: textSize, color: Colors.red),))),
                      ),
                      TableCell(
                        child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${theScale[progressions[number][3]-1].name}", style: TextStyle(fontSize: textSize, color: Colors.red),))),
                      ),
                    ],
                  ),
                  ],
                ),
              ),
          ],
          );
        }
      }
    Random rand = new Random();
    int myrand = rand.nextInt(progressions.length);
    return Scaffold(
       appBar: AppBar(
         title: Text("Random ${theScale[0].name} Progression"),
         elevation: 1,  
       ),
       body: SingleChildScrollView(
         child: Center(
          child: Column(
            children: <Widget>[
              progTable(myrand),
            ],
          ),
         ),
       ),
    );
  }
}