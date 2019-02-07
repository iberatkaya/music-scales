import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'chordfingering.dart';
import 'main.dart';
import 'dart:async';

List<Chord> chords = [    //A A# B C C# D D# E F F# G G# 
  Chord("Major", 0, [4, 3]),
  Chord("Minor", 1, [3, 4]),
  Chord("7th", 6, [4, 3, 3]),
  Chord("Major 7th", 2, [4, 3, 4]),
  Chord("Minor 7th", 5, [3, 4, 3]),
  Chord("Sus2", 3, [2, 5]),
  Chord("Sus4", 4, [5, 2]),
  Chord("Minor 6th", 11, [3, 4, 2]), 
  Chord("Diminished", 7, [3, 3]),
  Chord("Augmented", 8, [4, 4]),
  Chord("9th", 9, [4, 3, 3, 4]),  
  Chord("6th", 10, [4, 3, 2])
  //Next is 12
];


class ChordPrintScreen extends StatefulWidget{
  @override
  _ChordPrintScreen createState() => _ChordPrintScreen();
}

class _ChordPrintScreen extends State<ChordPrintScreen> {
  AudioPlayer audio = new AudioPlayer();
  AudioCache audioc = new AudioCache();
  List<Note> calculateChord(var mode, var key){
    List<Note> theNotes = [];
    var index = key;
    Chord chordObj;
    for(int i=0; i<chords.length; i++){
      if(mode == chords[i].index)
        chordObj = chords[i];
    }
    for(int j=0; j<chordObj.formula.length+1; j++){
      if(j != 0)
        index += chordObj.formula[j-1];
      if(index > 11)
        index %= 12;
      theNotes.add(notes[index]); 
    }  
  return theNotes;
  }

  Icon myplay;
  int playctr;
  EdgeInsets playpadding;
  var instrimg;
  @override
    void initState() {
      myplay = Icon(FontAwesomeIcons.play, color: Colors.black87);
      playctr = 1;
      playpadding = EdgeInsets.only(left: 6);
      instrimg = AssetImage('lib/assets/imgs/${instrument.toLowerCase()}.png');
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    List<Note> myNotes = calculateChord(clickedindexscale, clickedindex);
    int imgctr = 0;   //Ctr for guitar strings
    int audioctr = 0;

    Future<void> playcache(String note) async{
      if(instrument == "Piano")
        await audioc.play("notes/${instrument.toLowerCase()}/${note.replaceAll("#", "s")}.mp3", volume: 0.6);
      else
        await audioc.play("notes/${instrument.toLowerCase()}/${note.replaceAll("#", "s")}.mp3");
      }

    TableCell noteCell(String note){
      return TableCell(
        child: GestureDetector(
          onTap: (){
            playcache("$note");
          },
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(230, 80, 80, 0.12)),
              child:  Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.6, 0, textSize * 0.65), child: Center(child: Text("$note", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
            ),
        ),
      );
    }

    Padding mytable(int mode){
      Padding thetable;
      String the3rd = "3";
      String the7th = "7";
      if(mode == 3)
        the3rd = "2";
      if(mode == 4)
        the3rd = "4";
      if(mode == 10 || mode == 11)
        the7th = "6";
      if(mode == 2 || mode == 5 || mode == 6 || mode == 10 || mode == 11){
        thetable = Padding(padding: EdgeInsets.fromLTRB(50 - textSize * 0.6, 28, 50 - textSize * 0.6, 10), 
          child:Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("1", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.75)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("3", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("5", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("$the7th", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  noteCell(myNotes[0].note),
                  noteCell(myNotes[1].note),
                  noteCell(myNotes[2].note),
                  noteCell(myNotes[3].note),
                ],
              ),
              ],
            ),
           );
        }
      else if(mode == 9){
        thetable = Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.45, 28, 56 - textSize * 0.45, 10),
          child: Column(
            children: <Widget>[ 
            Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("1", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.75)),))),
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
                  noteCell(myNotes[0].note),
                  noteCell(myNotes[1].note),
                  noteCell(myNotes[2].note),
                ],
              ),
              ],
            ),
          Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.35, 16, 56 - textSize * 0.35, 10),
            child: Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("7", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("9", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  noteCell(myNotes[3].note),
                  noteCell(myNotes[4].note),
                ],
              ),
              ],
            ),
            ),
           ]
           )
           );
      }
      else{ 
        thetable = Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.45, 28, 56 - textSize * 0.45, 10),
            child: Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("1", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.75)),))),
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
                  noteCell(myNotes[0].note),
                  noteCell(myNotes[1].note),
                  noteCell(myNotes[2].note),
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
      else if(mode == "Minor 7th")
        return "The ${key}m7 Chord"; 
      else if(mode == "7th")
        return "The ${key}7 Chord";  
      else if(mode == "Diminished")
        return "The ${key}dim Chord"; 
      else if(mode == "Augmented")
        return "The ${key}aug Chord"; 
      else if(mode == "9th")
        return "The ${key}9 Chord";  
      else if(mode == "6th")
        return "The ${key}6 Chord";  
      else if(mode == "Minor 6th")
        return "The ${key}m6 Chord";  
      return "The $key $mode Chord";
    }

    String urlChord(String mode, List<Note> notes, String instr, int img){
      String url;
      if(instr == "Piano"){
        if(!notes[0].note.contains("#")){
          if(mode == "Major")
            url = "${instr.toLowerCase()}-${notes[0].note}-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
          else if(mode == "Minor")
            url = "${instr.toLowerCase()}-${notes[0].note}m-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
          else if(mode == "Major 7th")
            url = "${instr.toLowerCase()}-${notes[0].note}maj7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
          else if(mode == "Minor 7th")
            url = "${instr.toLowerCase()}-${notes[0].note}m7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
          else if(mode == "Sus2")
            url = "${instr.toLowerCase()}-${notes[0].note}sus2-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
          else if(mode == "Sus4")
            url = "${instr.toLowerCase()}-${notes[0].note}sus4-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}"; 
          else if(mode == "7th")
            url = "${instr.toLowerCase()}-${notes[0].note}7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
          else if(mode == "Diminished")
            url = "${instr.toLowerCase()}-${notes[0].note}dim-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
          else if(mode == "Augmented")
            url = "${instr.toLowerCase()}-${notes[0].note}aug-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}"; 
          else if(mode == "9th")
            url = "${instr.toLowerCase()}-${notes[0].note}9-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}"; 
          else if(mode == "6th")
            url = "${instr.toLowerCase()}-${notes[0].note}6-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
          else if(mode == "Minor 6th")
            url = "${instr.toLowerCase()}-${notes[0].note}m6-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
          return url.replaceAll("#", "s");
        }
      else{
          if(mode == "Major")
            url = "${instr.toLowerCase()}-${notes[0].note}-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
          else if(mode == "Minor")
            url = "${instr.toLowerCase()}-${notes[0].note}m-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
          else if(mode == "Major 7th")
            url = "${instr.toLowerCase()}-${notes[0].note}maj7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
          else if(mode == "Minor 7th")
            url = "${instr.toLowerCase()}-${notes[0].note}m7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
          else if(mode == "Sus2")
            url = "${instr.toLowerCase()}-${notes[0].note}sus2-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
          else if(mode == "Sus4")
            url = "${instr.toLowerCase()}-${notes[0].note}sus4-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}"; 
          else if(mode == "7th")
            url = "${instr.toLowerCase()}-${notes[0].note}7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
          else if(mode == "Diminished")
            url = "${instr.toLowerCase()}-${notes[0].note}dim-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
          else if(mode == "Augmented")
            url = "${instr.toLowerCase()}-${notes[0].note}aug-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}"; 
          else if(mode == "9th")
            url = "${instr.toLowerCase()}-${notes[0].note}9-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
          else if(mode == "6th")
            url = "${instr.toLowerCase()}-${notes[0].note}6-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
          else if(mode == "Minor 6th")
            url = "${instr.toLowerCase()}-${notes[0].note}m6-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
          return url.replaceFirst("#", "s").replaceFirst("#", "-sharp").replaceAll("#", "s");  
        }
      }
    else if(instr == "Guitar"){     
      if(!notes[0].note.contains("#")){
        if(mode == "Major")
          url = "${instr.toLowerCase()}-${notes[0].note}-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][0].replaceAll(" ", "-")}";
        else if(mode == "Minor")
          url = "${instr.toLowerCase()}-${notes[0].note}m-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][1].replaceAll(" ", "-")}";
        else if(mode == "Major 7th")
          url = "${instr.toLowerCase()}-${notes[0].note}maj7-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][2].replaceAll(" ", "-")}";
        else if(mode == "Minor 7th")
          url = "${instr.toLowerCase()}-${notes[0].note}m7-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][3].replaceAll(" ", "-")}";
        else if(mode == "Sus2")
          url = "${instr.toLowerCase()}-${notes[0].note}sus2-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][4].replaceAll(" ", "-")}";
        else if(mode == "Sus4")
          url = "${instr.toLowerCase()}-${notes[0].note}sus4-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][5].replaceAll(" ", "-")}";
        else if(mode == "7th")
          url = "${instr.toLowerCase()}-${notes[0].note}7-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][6].replaceAll(" ", "-")}";
        else if(mode == "Diminished")
          url = "${instr.toLowerCase()}-${notes[0].note}dim-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][7].replaceAll(" ", "-")}";
        else if(mode == "Augmented")
          url = "${instr.toLowerCase()}-${notes[0].note}aug-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][8].replaceAll(" ", "-")}";
        else if(mode == "9th")
          url = "${instr.toLowerCase()}-${notes[0].note}9-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][9].replaceAll(" ", "-")}";
        else if(mode == "6th")
          url = "${instr.toLowerCase()}-${notes[0].note}6-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][10].replaceAll(" ", "-")}";
        else if(mode == "Minor 6th")
          url = "${instr.toLowerCase()}-${notes[0].note}m6-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][11].replaceAll(" ", "-")}";
        return url.replaceAll("#", "s");
        }
      else{
        if(mode == "Major")
          url = "${instr.toLowerCase()}-${notes[0].note}-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][0].replaceAll(" ", "-")}";
        else if(mode == "Minor")
          url = "${instr.toLowerCase()}-${notes[0].note}m-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][1].replaceAll(" ", "-")}";
        else if(mode == "Major 7th")
          url = "${instr.toLowerCase()}-${notes[0].note}maj7-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][2].replaceAll(" ", "-")}";
        else if(mode == "Minor 7th")
          url = "${instr.toLowerCase()}-${notes[0].note}m7-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][3].replaceAll(" ", "-")}";
        else if(mode == "Sus2")
          url = "${instr.toLowerCase()}-${notes[0].note}sus2-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][4].replaceAll(" ", "-")}";
        else if(mode == "Sus4")
          url = "${instr.toLowerCase()}-${notes[0].note}sus4-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][5].replaceAll(" ", "-")}";
        else if(mode == "7th")
          url = "${instr.toLowerCase()}-${notes[0].note}7-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][6].replaceAll(" ", "-")}";
        else if(mode == "Diminished")
          url = "${instr.toLowerCase()}-${notes[0].note}dim-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][7].replaceAll(" ", "-")}";  
        else if(mode == "Augmented")
          url = "${instr.toLowerCase()}-${notes[0].note}aug-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][8].replaceAll(" ", "-")}";
        else if(mode == "9th")
          url = "${instr.toLowerCase()}-${notes[0].note}9-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][9].replaceAll(" ", "-")}";
        else if(mode == "6th")
          url = "${instr.toLowerCase()}-${notes[0].note}6-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][10].replaceAll(" ", "-")}";
        else if(mode == "Minor 6th")
          url = "${instr.toLowerCase()}-${notes[0].note}m6-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][11].replaceAll(" ", "-")}";
        return url.replaceFirst("#", "s").replaceFirst("#", "-sharp").replaceAll("#", "s");  
        }
      }
    }

    String urlAudio(String mode, List<Note> notes, String instr, String speed, int img){
      String url;
      if(instr == "Piano"){
        if(mode == "Major")
          url = "${instr.toLowerCase()}-${notes[0].note}-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if(mode == "Minor")
          url = "${instr.toLowerCase()}-${notes[0].note}m-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if(mode == "Major 7th")
          url = "${instr.toLowerCase()}-${notes[0].note}maj7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if(mode == "Minor 7th")
          url = "${instr.toLowerCase()}-${notes[0].note}m7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
        else if(mode == "Sus2")
          url = "${instr.toLowerCase()}-${notes[0].note}sus2-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if(mode == "Sus4")
          url = "${instr.toLowerCase()}-${notes[0].note}sus4-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}"; 
        else if(mode == "7th")
          url = "${instr.toLowerCase()}-${notes[0].note}7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
        else if(mode == "Diminished")
          url = "${instr.toLowerCase()}-${notes[0].note}dim-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}"; 
        else if(mode == "Augmented")
          url = "${instr.toLowerCase()}-${notes[0].note}aug-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}"; 
        else if(mode == "9th")
          url = "${instr.toLowerCase()}-${notes[0].note}9-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}"; 
        else if(mode == "6th")
          url = "${instr.toLowerCase()}-${notes[0].note}6-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
        else if(mode == "Minor 6th")
          url = "${instr.toLowerCase()}-${notes[0].note}m6-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
        }
    else if(instr == "Guitar"){
      if(mode == "Major")
          url = "${instr.toLowerCase()}-${notes[0].note}-$speed-${strings[img][notes[0].index][0].replaceAll(" ", "-")}";
        else if(mode == "Minor")
          url = "${instr.toLowerCase()}-${notes[0].note}m-$speed-${strings[img][notes[0].index][1].replaceAll(" ", "-")}";
        else if(mode == "Major 7th")
          url = "${instr.toLowerCase()}-${notes[0].note}maj7-$speed-${strings[img][notes[0].index][2].replaceAll(" ", "-")}";
        else if(mode == "Minor 7th")
          url = "${instr.toLowerCase()}-${notes[0].note}m7-$speed-${strings[img][notes[0].index][3].replaceAll(" ", "-")}"; 
        else if(mode == "Sus2")
          url = "${instr.toLowerCase()}-${notes[0].note}sus2-$speed-${strings[img][notes[0].index][4].replaceAll(" ", "-")}";
        else if(mode == "Sus4")
          url = "${instr.toLowerCase()}-${notes[0].note}sus4-$speed-${strings[img][notes[0].index][5].replaceAll(" ", "-")}"; 
        else if(mode == "7th")
          url = "${instr.toLowerCase()}-${notes[0].note}7-$speed-${strings[img][notes[0].index][6].replaceAll(" ", "-")}"; 
        else if(mode == "Diminished")
          url = "${instr.toLowerCase()}-${notes[0].note}dim-$speed-${strings[img][notes[0].index][7].replaceAll(" ", "-")}"; 
        else if(mode == "Augmented")
          url = "${instr.toLowerCase()}-${notes[0].note}aug-$speed-${strings[img][notes[0].index][8].replaceAll(" ", "-")}"; 
        else if(mode == "9th")
          url = "${instr.toLowerCase()}-${notes[0].note}9-$speed-${strings[img][notes[0].index][9].replaceAll(" ", "-")}"; 
        else if(mode == "6th")
          url = "${instr.toLowerCase()}-${notes[0].note}6-$speed-${strings[img][notes[0].index][10].replaceAll(" ", "-")}"; 
        else if(mode == "Minor 6th")
          url = "${instr.toLowerCase()}-${notes[0].note}m6-$speed-${strings[img][notes[0].index][11].replaceAll(" ", "-")}"; 
        }
    if(!notes[0].note.contains("#"))
      return url.replaceAll("#", "s");
    else
      return url.replaceFirst("#", "s").replaceAll("#", "s");  
    }

    Future<void> play() async{
      await audio.play("https://www.scales-chords.com/chord-sound/${urlAudio(clickednotescale, myNotes, instrument, speed.toLowerCase(), audioctr)}.mp3");
      //print(urlAudio(clickednotescale, myNotes, instrument, speed.toLowerCase(), audioctr));
    }

    Future<void> pause() async {
      await audio.pause();
    }
    

    var chordimg;
    TransitionToImage _chrdimg(String url){
      //print("https://www.scales-chords.com/chord-charts/$url.jpg");
      String totalurl;
      totalurl = "https://www.scales-chords.com/chord-charts/$url.jpg";
      chordimg =  TransitionToImage(
        AdvancedNetworkImage(totalurl, useDiskCache: true),
        fit: BoxFit.fill,
        loadingWidget: Padding(padding: EdgeInsets.all(6), child: CircularProgressIndicator(strokeWidth: 3, backgroundColor: Colors.orangeAccent,)),
        placeholder: Column(children: <Widget>[
                    Padding( 
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 6),
                      child:Text("No Internet Connection!", style: TextStyle(color: Color.fromRGBO(50, 50, 50, 0.6), fontSize: 20),),
                    ),
                    Icon(Icons.error, color: Colors.red),
                  ],
                ),
      );
      return chordimg;
      }

    if(instrument == "Guitar"){
      chordimg = Container(
        height: 135,
        padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
        child: Swiper(
          onIndexChanged: (index){
            audioctr = index;
          },
          control: SwiperControl(
            size: 28,
            padding: EdgeInsets.only(bottom: 16),
            color: Colors.amberAccent,
            iconNext: Icons.navigate_next,
            iconPrevious: Icons.navigate_before
          ),
        itemCount: 4, 
        itemBuilder: (BuildContext context, int index){
          return _chrdimg("${urlChord(clickednotescale, myNotes, instrument, index)}");
        },
        // _chrdimg("${urlChord(clickednotescale, myNotes, instrument, imgctr)}"),
      )
      );
    }
    else
      chordimg = Container(
        padding: EdgeInsets.fromLTRB(6, 16, 6, 0),
        child: _chrdimg("${urlChord(clickednotescale, myNotes, instrument, imgctr)}")
        );

    Future<void> refimg() async{
      await Future.delayed(new Duration(seconds: 2));
      setState(() {
        chordimg.reloadImage();                      
        });
    }
    
    void playicon(){
      setState(() {
        if(playctr == 1){
          myplay = Icon(FontAwesomeIcons.pause, color: Colors.black87);  
          }
        else{
          myplay = Icon(FontAwesomeIcons.play, color: Colors.black87);  
          }});
      }

    audioc.loadAll(["notes/guitar/A.mp3", "notes/guitar/As.mp3", "notes/guitar/B.mp3", "notes/guitar/C.mp3", "notes/guitar/Cs.mp3", "notes/guitar/D.mp3", "notes/guitar/Ds.mp3", "notes/guitar/E.mp3", "notes/guitar/F.mp3", "notes/guitar/Fs.mp3", "notes/guitar/G.mp3", "notes/guitar/Gs.mp3", "notes/piano/A.mp3", "notes/piano/As.mp3", "notes/piano/B.mp3", "notes/piano/C.mp3", "notes/piano/Cs.mp3", "notes/piano/D.mp3", "notes/piano/Ds.mp3", "notes/piano/E.mp3", "notes/piano/F.mp3", "notes/piano/Fs.mp3", "notes/piano/G.mp3", "notes/piano/Gs.mp3"]);
    return Scaffold(
      appBar: AppBar(
        title: Text("${titleText(clickednote, clickednotescale)}", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
        elevation: 1,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              setState(() {
                  if(instrument == "Guitar")
                    instrument = "Piano";
                  else if(instrument == "Piano")
                    instrument = "Guitar";
                  instrimg = AssetImage('lib/assets/imgs/${instrument.toLowerCase()}.png');
                });
            },
            child: Padding(padding: EdgeInsets.fromLTRB(0, 8, 8, 8), 
              child: Image(
                color: Colors.black,
                image: instrimg,
                ),
              ),
            ),
          GestureDetector(
            child: Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.help, size: 30,)),
            onTap: (){
              showDialog(
              context: context,
              builder: (ctxt) => AlertDialog(
                title: Text("Help", textAlign: TextAlign.center,),
                content: Text("Click and select a chord from the menu. Press the button next to the question mark to change the instrument. Click the red button to hear the audio of the chord, and the red tiles to hear the individual notes with the selected instrument. While viewing the guitar chord, slide the chord to the view alternative shapes of the chord."),
              )
              );
            },
          )
          ],  
      ),
      //bottomNavigationBar: Container(height: adpadding,),
      backgroundColor: Colors.white,
      body:  RefreshIndicator(
        onRefresh: refimg,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Chord:   ", style: TextStyle(fontSize: 26, fontStyle: FontStyle.italic),),
                        DropdownButton(
                          hint: Text(clickednotescale, style: TextStyle(fontSize: 24, color: Colors.deepPurple),),
                          items: chords.map((Chord value){
                            return DropdownMenuItem<Chord>(
                              child: Text("${value.note}", style: TextStyle(fontSize: 18),),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (Chord newvalue){
                            setState(() {
                            clickednotescale = newvalue.note;
                            clickedindexscale = newvalue.index; 
                            });
                          },
                        ),
                      ],
                      ),
                  ),
                Padding(padding: EdgeInsets.fromLTRB(2, 6, 2, 0), child: Divider(height: 0, color: Colors.black54,)),
                chordimg,
                mytable(clickedindexscale),
                //Text("${urlAudio(clickednotescale, myNotes, "piano", "fast")}", style: TextStyle(fontSize: 24)),
                
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 14, 0 ,20),
                  child: RawMaterialButton(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    fillColor: Color.fromRGBO(250, 50, 50, 0.9),
                    child:Padding(padding: playpadding, child: myplay,),
                    onPressed: (){
                      playicon();
                      if(playctr == 1){
                        play();
                        setState(() {
                          playpadding = EdgeInsets.only(left: 0);
                          playctr = 0;                            
                        });
                      }
                      else{
                        pause();
                        setState(() {
                          playpadding = EdgeInsets.only(left: 6);
                          playctr = 1;
                        });
                      } 
                      audio.completionHandler = (){
                        playicon();
                        setState(() {
                          playpadding = EdgeInsets.only(left: 6);
                          playctr = 1;
                          });
                      };
                    },
                  )
                ),
          ],
          ),
          ),
        ),
        ),
      ),
    );
  }
}