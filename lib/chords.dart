import 'package:flutter/material.dart';
import 'main.dart';

void main() => runApp(ChordScreen());

class ChordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Scale> scales = [
      Scale("Major", 0),
      Scale("Minor", 1),
      Scale("Major 7th", 2),
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
                  padding: EdgeInsets.all(10.0),
                  itemCount: scales.length,
                  separatorBuilder:(BuildContext context, int index) => Divider(height: 4, color: Color.fromRGBO(0, 0, 200, 0.2),),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                     contentPadding: EdgeInsets.fromLTRB(4, -12 + textSize * 0.85, 0, -12 + textSize * 0.90),
                     dense: true,
                      onTap:() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChordPrintScreen()));
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

class ChordPrintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> calculateChord(var mode, var key){
    	List<String> theNotes = [];
      var index = key;
      int ctr = 3;
	    for(int i=0; i<ctr; i++){
        if(i == 1 && (mode == 0 || mode == 2)){
          index++;
        }
        else if(i == 2 && mode == 1){
          index++;
        }
        if(i == 2 && mode == 2)
          ctr++;
        if(i == 3 && mode == 2)
          index++;
        if(index > 11)
			    index %= 12;
        theNotes.add(notes[index].note);
        index +=3;     //A A# B C C# D D# E F F# G G#
	    	}             //0 3 7 m   0 4 7 M   0 4 7 11
      return theNotes;
      }
    String the3rd = "3";
    if(clickedindexscale == 1)
      the3rd = "3b";
    List<String> myNotes = calculateChord(clickedindexscale, clickedindex);
    
    Table mytable(int mode){
      Table thetable;
      if(mode == 0 || mode == 1){
        thetable = Table(
             border: TableBorder.all(width: 2, color: Color.fromRGBO(150, 0, 40, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("1", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("$the3rd", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("5", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myNotes[0]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myNotes[1]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myNotes[2]}", style: TextStyle(fontSize: textSize * 1.1 , color: Colors.red),))),
                  ),
                ],
              ),
              ],
           );
        }
      else if(mode == 2){
        thetable = Table(
             border: TableBorder.all(width: 2, color: Color.fromRGBO(150, 0, 40, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("1", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("$the3rd", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("5", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("7", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myNotes[0]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myNotes[1]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myNotes[2]}", style: TextStyle(fontSize: textSize * 1.1 , color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myNotes[3]}", style: TextStyle(fontSize: textSize * 1.1 , color: Colors.red),))),
                  ),
                ],
              ),
              ],
           );
        }
      return thetable;
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("The $clickednote $clickednotescale Chord", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
/*            Container(
              margin: EdgeInsets.fromLTRB(5, 35, 5, 0),
              child: Text(calculateChord(clickedindexscale, clickedindex), textAlign: TextAlign.center, style: TextStyle(fontSize: 20 + textSize * 1.15, color: Colors.red),),
           ),*/
           Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.35, 28, 56 - textSize * 0.35, 0), 
            child: mytable(clickedindexscale),
           ),
      ],
      ),
      ),
    );
  }
}
