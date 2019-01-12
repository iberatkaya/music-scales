import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'main.dart';

void main() => runApp(ChordScreen());


class ChordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Scale> scales = [
      Scale("Major", 0),
      Scale("Minor", 1),
      Scale("Major 7th", 2),
      Scale("Sus2", 3),
      Scale("Sus4", 4),
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
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(10, 4, 10, 10),
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

class ChordPrintScreen extends StatefulWidget{
  @override
  _ChordPrintScreen createState() => _ChordPrintScreen();
}

class _ChordPrintScreen extends State<ChordPrintScreen> {

  @override
  Widget build(BuildContext context) {
    List<String> calculateChord(var mode, var key){
    	List<String> theNotes = [];
      var index = key;
      int ctr = 3;
	    if(mode == 0 || mode == 1 || mode == 2){
        for(int i=0; i<ctr; i++){
          if(i == 1 && (mode == 0 || mode == 2)){  //Major and Major 7
            index++;
          }
          else if(i == 2 && mode == 1){
            index++;
          }
          if(i == 2 && mode == 2) //Major 7
            ctr++;
          if(i == 3 && mode == 2)   //Major 7
            index++;
          if(index > 11)
            index %= 12;
          theNotes.add(notes[index].note);
          index += 3;     //A A# B C C# D D# E F F# G G#
	    	}                 //0 3 7 m   0 4 7 M   0 4 7 11
      }
      else if(mode == 3 || mode == 4){    //0 2 7 sus2   0 5 7 sus4
        for(int i=0; i<3; i++){
          if(i == 1 && mode == 3)   //Sus2
            index--;
          if(i == 2 && mode == 3)   //Sus2
            index += 2;
          if(i == 1 && mode == 4)   //Sus4
            index += 2;
          if(i == 2 && mode == 4)   //Sus4
            index--;
          if(index > 11)
            index %= 12;
          theNotes.add(notes[index].note);
          index += 3;
        }
      }
      return theNotes;
      }
    List<String> myNotes = calculateChord(clickedindexscale, clickedindex);
    
    Padding mytable(int mode){
      Padding thetable;
      String the3rd = "3";
      if(mode == 3)
        the3rd = "2";
      if(mode == 4)
        the3rd = "4";
      if(!(mode == 2)){
        thetable = Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.45, 28, 56 - textSize * 0.45, 10),
            child: Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
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
            ),
           );
        }
      else if(mode == 2){
        thetable = Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.6, 28, 56 - textSize * 0.6, 10), 
          child:Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("1", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("3", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
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
            ),
           );
        }
      return thetable;
    }
    String titleText(String key, String mode){
      if(mode == "Major")
        return "The $key Chord";
      else if(mode == "Minor")
        return "The ${key}m Chord";
      else if(mode == "Major 7th")
        return "The ${key}maj7 Chord";
      else if(mode == "Sus2")
        return "The ${key}sus2 Chord";
      else if(mode == "Sus4")
        return "The ${key}sus4 Chord"; 
      return "The $key $mode Chord";
    }

    String urlChord(String mode, List<String> notes, String instr){
      String url;
      if(!notes[0].contains("#")){
        if(mode == "Major")
          url = "$instr-${notes[0]}-${notes[0].toLowerCase()}-n-l-${notes[0].toLowerCase()}-${notes[1].toLowerCase()}-${notes[2].toLowerCase()}";
        else if(mode == "Minor")
          url = "$instr-${notes[0]}m-${notes[0].toLowerCase()}-n-l-${notes[0].toLowerCase()}-${notes[1].toLowerCase()}-${notes[2].toLowerCase()}";
        else if(mode == "Major 7th")
          url = "$instr-${notes[0]}maj7-${notes[0].toLowerCase()}-n-l-${notes[0].toLowerCase()}-${notes[1].toLowerCase()}-${notes[2].toLowerCase()}-${notes[3].toLowerCase()}";
        else if(mode == "Sus2")
          url = "$instr-${notes[0]}sus2-${notes[0].toLowerCase()}-n-l-${notes[0].toLowerCase()}-${notes[1].toLowerCase()}-${notes[2].toLowerCase()}";
        else if(mode == "Sus4")
          url = "$instr-${notes[0]}sus4-${notes[0].toLowerCase()}-n-l-${notes[0].toLowerCase()}-${notes[1].toLowerCase()}-${notes[2].toLowerCase()}"; 
        return url.replaceAll("#", "s");
      }
    else{
        if(mode == "Major")
          url = "$instr-${notes[0]}-${notes[0].toLowerCase()}-l-${notes[0].toLowerCase()}-${notes[1].toLowerCase()}-${notes[2].toLowerCase()}";
        else if(mode == "Minor")
          url = "$instr-${notes[0]}m-${notes[0].toLowerCase()}-l-${notes[0].toLowerCase()}-${notes[1].toLowerCase()}-${notes[2].toLowerCase()}";
        else if(mode == "Major 7th")
          url = "$instr-${notes[0]}maj7-${notes[0].toLowerCase()}-l-${notes[0].toLowerCase()}-${notes[1].toLowerCase()}-${notes[2].toLowerCase()}-${notes[3].toLowerCase()}";
        else if(mode == "Sus2")
          url = "$instr-${notes[0]}sus2-${notes[0].toLowerCase()}-l-${notes[0].toLowerCase()}-${notes[1].toLowerCase()}-${notes[2].toLowerCase()}";
        else if(mode == "Sus4")
          url = "$instr-${notes[0]}sus4-${notes[0].toLowerCase()}-l-${notes[0].toLowerCase()}-${notes[1].toLowerCase()}-${notes[2].toLowerCase()}"; 
        return url.replaceFirst("#", "s").replaceFirst("#", "-sharp").replaceAll("#", "s");  
    }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${titleText(clickednote, clickednotescale)}", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
          child: Column(
            children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(22, 20, 22, 0), 
              child: CachedNetworkImage(
                imageUrl:'https://www.scales-chords.com/chord-charts/${urlChord(clickednotescale, myNotes, "piano")}.jpg',
                placeholder: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.orangeAccent,
                ),
                errorWidget: Column(children: <Widget>[
                    Padding( 
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 6),
                      child:Text("No Internet Connection!", style: TextStyle(color: Color.fromRGBO(50, 50, 50, 0.6), fontSize: 20),),
                    ),
                    Icon(Icons.error, color: Colors.red),
                  ],
                ),
                ),
              ),
            mytable(clickedindexscale),
      ],
      ),
      ),
      ),
    );
  }
}
