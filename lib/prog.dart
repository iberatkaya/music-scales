import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'main.dart';
import 'dart:math';


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

String progmode;
String key;
int myindex;
List<Chord> theScale;

class ProgPrintScreen extends StatefulWidget{
  @override
  _ProgPrintScreen createState() => _ProgPrintScreen();
}

class _ProgPrintScreen extends State<ProgPrintScreen> {
  AudioPlayer audio = new AudioPlayer();
  @override
  Widget build(BuildContext context){
    
    List<Scale> scales = [
      Scale("Major", 0, []),
      Scale("Minor", 1, []),
    ];

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
  theScale = scaleChords(progmode, myindex);

  String urlAudio(String chord){
    return "https://www.scales-chords.com/chord-sounds/snd-guitar-chord-${chord.replaceFirst("#", "s")}.mp3";
  }

  Future<void> play(String chord) async{
    await audio.play(urlAudio(chord));
    print(urlAudio(chord));
  }

  TableCell tableCell(String chordname){
    return TableCell(
            child: FlatButton(
              padding: EdgeInsets.zero,
              color: Color.fromRGBO(230, 80, 80, 0.12),
              onPressed: (){
                play(chordname);
              },
              child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.6, 0, textSize * 0.65), 
                child: Center(
                  child: Text("$chordname", style: TextStyle(fontSize: textSize * 0.85, color: Colors.red, fontWeight: FontWeight.w400),)
                )
              ),
            ),
          );
  }

  return Scaffold(
    appBar: AppBar(
      title: Text("${theScale[0].name} Diatonic Chords", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
      elevation: 1,
      actions: <Widget>[
          GestureDetector(
            child: Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.help, size: 30,)),
            onTap: (){
              showDialog(
              context: context,
              builder: (ctxt) => AlertDialog(
                title: Text("Help", textAlign: TextAlign.center,),
                content: Text("View the diatonic chords of the key. Click on the dice to view a random progression in the key. Click on the chords to hear them."),
              )
              );
            },
          )
      ],
     ),
    //bottomNavigationBar: Container(height: adpadding,),
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
    
    body: Center(
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 2, left: 28, right: 28),
                color: Color.fromRGBO(255, 225, 225, 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Key", style: TextStyle(fontSize: 20, color: Color.fromRGBO(50, 50, 50, 1)),),
                    DropdownButton(
                      hint: Text(clickednote, style: TextStyle(fontSize: 20, color: Colors.blue),),
                      items: notes.map((Note value){
                        return DropdownMenuItem<Note>(
                          child: Text("${value.note}", style: TextStyle(fontSize: 18),),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (Note newvalue){
                        setState(() {
                          clickednote = newvalue.note;
                          myindex = newvalue.index;
                        });
                      },
                    ),
                  ],
                  ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromRGBO(225, 250, 250, 1),
                  padding: EdgeInsets.only(top: 8, bottom: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Chord", style: TextStyle(fontSize: 20, color: Color.fromRGBO(50, 50, 50, 1)),),
                      DropdownButton(
                        hint: Text(clickednotescale, style: TextStyle(fontSize: 20, color: Colors.deepPurple),),
                        items: scales.map((Scale value){
                          return DropdownMenuItem<Scale>(
                            child: Text("${value.name}", style: TextStyle(fontSize: 18),),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (Scale newvalue){
                          setState(() {
                            clickednotescale = newvalue.name;
                            if(newvalue.name == "Major")
                              progmode = "M";
                            else
                              progmode = "m";
                          });
                        },
                      ),
                    ],
                    ),
                  ),
                ),
              ]
            ),
            Divider(height: 0, color: Colors.black26,),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.fromLTRB(36 - textSize, 16, 36-textSize, 14), 
                    child: Table(
                      border: TableBorder.all(width: 1, color: Color.fromRGBO(20, 0, 160, 0.2)),
                      children: <TableRow>[
                        TableRow(
                          children: <TableCell>[
                            TableCell(
                              child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("1", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.75)),))),
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
                            tableCell(theScale[0].name),
                            tableCell(theScale[1].name),
                            tableCell(theScale[2].name),
                            tableCell(theScale[3].name),
                          ],
                        ),
                        ],
                    ),),
                    Padding(padding: EdgeInsets.fromLTRB(46 - textSize * 0.35, 0, 46 - textSize * 0.35, 12), child: Table(
                      border: TableBorder.all(width: 1, color: Color.fromRGBO(20, 0, 160, 0.2)),
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
                            tableCell(theScale[4].name),
                            tableCell(theScale[5].name),
                            tableCell(theScale[6].name),
                          ],
                        ),
                        ],
                    ),
                   ),
                  ]
                )
              )
            )
            ],
          ),
      ),
    );
  }
}


class RandomProgScreen extends StatelessWidget{
  Widget build(BuildContext content){
    AudioPlayer audio = new AudioPlayer();
    String urlAudio(String chord){
      return "https://www.scales-chords.com/chord-sounds/snd-guitar-chord-${chord.replaceFirst("#", "s")}.mp3";
    }

    Future<void> play(String chord) async{
      await audio.play(urlAudio(chord));
      print(urlAudio(chord));
    }

    TableCell tableCell(String chordname){
      return TableCell(
              child: FlatButton(
                padding: EdgeInsets.zero,
                color: Color.fromRGBO(230, 80, 80, 0.12),
                onPressed: (){
                  play(chordname);
                },
                child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.6, 0, textSize * 0.65), 
                  child: Center(
                    child: Text("$chordname", style: TextStyle(fontSize: textSize * 0.85, color: Colors.red, fontWeight: FontWeight.w400),)
                  )
                ),
              ),
            );
    }

    List<List> progs(){
      List<List> theProgs;
      if(progmode == "M")
        theProgs = [[1, 4, 5], [1, 5, 6, 4], [2, 5, 1], [1, 6, 4, 5], [1, 4, 2, 5], [1, 4, 1, 5], [1, 3, 4, 5], [1, 2, 5]];
      else if(progmode == "m")
        theProgs = [[1, 6, 7], [1, 4, 6], [1, 4, 5], [1, 6, 3, 7], [1, 7, 6, 7], [6, 7, 1, 1], [1, 4, 5, 1]];
      return theProgs;
    }
    List<List> progressions = progs();
    Column progTable(int number){
      if(progressions[number].length == 3){
        return Column(children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(0, 26, 0, 6), child:Text("Formula: ${progressions[number][0]} - ${progressions[number][1]} - ${progressions[number][2]}", style: TextStyle(fontSize: 28, color: Color.fromRGBO(70, 70, 70, 0.8)),),),
          Divider(height: 0, color: Colors.black26,),
          Padding(
            padding: EdgeInsets.fromLTRB(56 - textSize * 0.45, 20, 56 - textSize * 0.45, 0),
            child: Table(
              border: TableBorder.all(width: 1, color: Color.fromRGBO(20, 0, 160, 0.2)),
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
                  tableCell(theScale[progressions[number][0]-1].name),
                  tableCell(theScale[progressions[number][1]-1].name),
                  tableCell(theScale[progressions[number][2]-1].name),
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
            Divider(height: 0, color: Colors.black26,),
            Padding(padding: EdgeInsets.fromLTRB(44 - textSize * 0.6, 20, 44 - textSize * 0.6, 0), 
              child:Table(
                border: TableBorder.all(width: 1, color: Color.fromRGBO(20, 0, 160, 0.2)),
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
                      tableCell(theScale[progressions[number][0]-1].name),
                      tableCell(theScale[progressions[number][1]-1].name),
                      tableCell(theScale[progressions[number][2]-1].name),
                      tableCell(theScale[progressions[number][3]-1].name),
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
      //bottomNavigationBar: Container(height: adpadding,),
      backgroundColor: Colors.white,
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