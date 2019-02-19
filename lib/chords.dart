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
  Chord("Sus2", 3, [2, 5]),
  Chord("Sus4", 4, [5, 2]),
  Chord("Diminished", 7, [3, 3]),
  Chord("Augmented", 8, [4, 4]),
  Chord("7th", 6, [4, 3, 3]),
  Chord("Major 7th", 2, [4, 3, 4]),
  Chord("Minor 7th", 5, [3, 4, 3]),
  Chord("m7b5", 13, [3, 3, 4]), 
  Chord("m7#5", 21, [3, 5, 2]),
  Chord("7b5", 15, [4, 2, 4]),
  Chord("7#5", 16, [4, 4, 2]),
  Chord("Diminished 7th", 14, [3, 3, 3]),
  Chord("6th", 10, [4, 3, 2]),
  Chord("Minor 6th", 11, [3, 4, 2]), 
  Chord("6th/9th", 12, [4, 3, 2, 5]),
  Chord("9th", 9, [4, 3, 3, 4]),  
  Chord("Major 9th", 18, [4, 3, 4, 3]),   //A A# B C C# D D# E F F# G G# 
  Chord("Minor 9th", 17, [3, 4, 3, 4]),
  Chord("9b5", 20, [4, 2, 4, 4]),
  Chord("9#5", 19, [4, 4, 2, 4]),
  Chord("11th", 22, [4, 3, 3, 4, 3]),
  Chord("Major 11th", 23, [4, 3, 4, 3, 3]),
  Chord("Minor 11th", 24, [3, 4, 3, 4, 3]),
  Chord("11b5", 25, [4, 2, 4, 4, 3]),
  Chord("11#5", 26, [4, 4, 2, 4, 3])
];

class CNote{
  String note;
  int index;
  int audioindex;
  CNote(this.note, this.index, this.audioindex);
}

List<CNote> notes = [
  CNote("A", 0, 0),
  CNote("A#", 1, 0),
  CNote("B", 2, 0),
  CNote("C", 3, 0),
  CNote("C#", 4, 0),
  CNote("D", 5, 0),
  CNote("D#", 6, 0),
  CNote("E", 7, 0),
  CNote("F", 8, 0),
  CNote("F#", 9, 0),
  CNote("G", 10, 0),
  CNote("G#", 11, 0),
];

class ChordPrintScreen extends StatefulWidget{
  @override
  _ChordPrintScreen createState() => _ChordPrintScreen();
}

class _ChordPrintScreen extends State<ChordPrintScreen> {
  AudioPlayer audio = new AudioPlayer();
  AudioCache audioc = new AudioCache();
  

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
    List<CNote> calculateChord(var mode, var key){
      List<CNote> theNotes = [];
      int audioindx = 4;
      var index = key;
      Chord chordObj;
      for(int i=0; i<chords.length; i++){
        if(mode == chords[i].index)
          chordObj = chords[i];
      }
      for(int j=0; j<chordObj.formula.length+1; j++){
        if(j != 0)
          index += chordObj.formula[j-1];
        if(index > 11){
          index %= 12;
          if(audioindx == 4)
            audioindx = 5;
          else if(audioindx == 5)
            audioindx = 6;
        }
        notes[index].audioindex = audioindx;
        theNotes.add(notes[index]); 
      }  
    return theNotes;
    }
    List<CNote> myNotes = calculateChord(clickedindexscale, clickedindex);
    int imgctr = 0;   //Ctr for guitar strings
    int audioctr = 0;

    Future<void> playcache(String note, int index) async{
      print("notes/${instrument.toLowerCase()}/${note.replaceAll("#", "s").toLowerCase()}$index.mp3");
      await audioc.play("notes/${instrument.toLowerCase()}/${note.replaceAll("#", "s").toLowerCase()}$index.mp3");
      }

    TableCell noteCell(String note, int index){
      return TableCell(
        child: FlatButton(
          color: Color.fromRGBO(230, 80, 80, 0.12),
          onPressed: (){
            playcache("$note", index);
          },
          child: Container(
              child:  Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.6, 0, textSize * 0.65), child: Center(child: Text("$note", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red, fontWeight: FontWeight.w400),))),
            ),
        ),
      );
    }

    List<String> nums = ["1", "3", "5", "7", "9", "11"];
    void tablenums(String chord){
      if(chord == "Minor")
        nums[1] = "b3";
      else if(chord == "7th")
        nums[3] = "b7";
      else if(chord == "Minor 7th"){
        nums[1] = "b3";
        nums[3] = "b7";
      }
      else if(chord == "Sus2")
        nums[1] = "2";
      else if(chord == "Sus4")
        nums[1] = "4";
      else if(chord == "6th")
        nums[3] = "6";
      else if(chord == "Minor 6th"){
        nums[3] = "6";
        nums[1] = "b3";
      }
      else if(chord == "Diminished"){
        nums[1] = "b3";
        nums[2] = "b5";
      }
      else if(chord == "Diminished 7th"){
        nums[1] = "b3";
        nums[2] = "b5";
        nums[3] = "b6";
      }
      else if(chord == "Augmented")
        nums[2] = "b6";
      else if(chord == "9th")
        nums[3] = "b7";
      else if(chord == "Minor 9th"){
        nums[1] = "b3";
        nums[3] = "b7";
      }
      else if(chord == "6th/9th")
        nums[3] = "b6";
      else if(chord == "m7b5"){
        nums[1] = "b3";
        nums[2] = "b5";
        nums[3] = "b7";
      }
      else if(chord == "m7#5"){
        nums[1] = "b3";
        nums[2] = "#5";
        nums[3] = "b7";
      }
      else if(chord == "7b5"){
        nums[2] = "b5";
        nums[3] = "b7";
      }
      else if(chord == "7#5"){
        nums[2] = "#5";
        nums[3] = "b7";        
      }
      else if(chord == "9#5"){
        nums[2] = "#5";
        nums[3] = "b7";        
      }
      else if(chord == "9b5"){
        nums[2] = "b5";
        nums[3] = "b7";        
      }
      else if(chord == "11th")
        nums[3] = "b7";
      else if(chord == "Minor 11th"){
        nums[1] = "b3";
        nums[3] = "b7";
      }
      else if(chord == "11b5"){
        nums[2] = "b5";
        nums[3] = "b7";        
      }
      else if(chord == "11#5"){
        nums[2] = "#5";
        nums[3] = "b7";        
      }
    }

    tablenums(clickednotescale);

    Padding mytable(int mode){
      Padding thetable;
      if(mode == 2 || mode == 5 || mode == 6 || mode == 10 || mode == 11 || mode == 13 || mode == 14 || mode == 15 || mode == 16 || mode == 21){
        thetable = Padding(padding: EdgeInsets.fromLTRB(50 - textSize * 0.6, 12, 50 - textSize * 0.6, 10), 
          child:Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[0]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.75)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[1]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[2]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[3]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  noteCell(myNotes[0].note, myNotes[0].audioindex),
                  noteCell(myNotes[1].note, myNotes[1].audioindex),
                  noteCell(myNotes[2].note, myNotes[2].audioindex),
                  noteCell(myNotes[3].note, myNotes[3].audioindex),
                ],
              ),
              ],
            ),
           );
        }
      else if(mode == 9 || mode == 12 || mode == 17 || mode == 18 || mode == 19 || mode == 20){
        thetable = Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.45, 12, 56 - textSize * 0.45, 10),
          child: Column(
            children: <Widget>[ 
            Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[0]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.75)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[1]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[2]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  noteCell(myNotes[0].note, myNotes[0].audioindex),
                  noteCell(myNotes[1].note, myNotes[1].audioindex),
                  noteCell(myNotes[2].note, myNotes[2].audioindex),
                ],
              ),
              ],
            ),
          Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.35, 12, 56 - textSize * 0.35, 0),
            child: Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[3]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[4]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  noteCell(myNotes[3].note, myNotes[3].audioindex),
                  noteCell(myNotes[4].note, myNotes[4].audioindex),
                ],
              ),
              ],
            ),
            ),
           ]
           )
           );
      }
      else if(mode == 22 || mode == 23 || mode == 24 || mode == 25 || mode == 26){
        thetable = Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.45, 12, 56 - textSize * 0.45, 10),
          child: Column(
            children: <Widget>[ 
            Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[0]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.75)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[1]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[2]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  noteCell(myNotes[0].note, myNotes[0].audioindex),
                  noteCell(myNotes[1].note, myNotes[1].audioindex),
                  noteCell(myNotes[2].note, myNotes[2].audioindex),
                ],
              ),
              ],
            ),
          Padding(padding: EdgeInsets.only(top: 12),
            child: Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[3]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[4]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[5]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  noteCell(myNotes[3].note, myNotes[3].audioindex),
                  noteCell(myNotes[4].note, myNotes[4].audioindex),
                  noteCell(myNotes[5].note, myNotes[5].audioindex),
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
        thetable = Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.45, 12, 56 - textSize * 0.45, 10),
            child: Table(
             border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[0]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.75)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[1]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[2]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  noteCell(myNotes[0].note, myNotes[0].audioindex),
                  noteCell(myNotes[1].note, myNotes[1].audioindex),
                  noteCell(myNotes[2].note, myNotes[2].audioindex),
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
      else if(mode == "6th/9th")
        return "The ${key}6/9 Chord";  
      else if(mode == "m7b5")
        return "The ${key}m7b5 Chord";  
      else if(mode == "Diminished 7th")
        return "The ${key}dim7 Chord";  
      else if(mode == "7b5")
        return "The ${key}7b5 Chord";  
      else if(mode == "7#5")
        return "The ${key}7#5 Chord";  
      else if(mode == "Minor 9th")
        return "The ${key}m9 Chord";  
      else if(mode == "Major 9th")
        return "The ${key}maj9 Chord";  
      else if(mode == "9#5")
        return "The ${key}9#5 Chord";  
      else if(mode == "9b5")
        return "The ${key}9b5 Chord";  
      else if(mode == "m7#5")
        return "The ${key}m7#5 Chord";  
      else if(mode == "11th")
        return "The ${key}11 Chord";  
      else if(mode == "Major 11th")
        return "The ${key}maj11 Chord";  
      else if(mode == "Minor 11th")
        return "The ${key}m11 Chord";  
      else if(mode == "11b5")
        return "The ${key}11b5 Chord";  
      else if(mode == "11#5")
        return "The ${key}11#5 Chord";  
      return "The $key $mode Chord";
    }

    String urlChord(String mode, List<CNote> notes, String instr, int img){
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
          else if(mode == "6th/9th")
            url = "${instr.toLowerCase()}-${notes[0].note}69-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}"; 
          else if(mode == "m7b5")
            url = "${instr.toLowerCase()}-${notes[0].note}m7b5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
          else if(mode == "Diminished 7th")
            url = "${instr.toLowerCase()}-${notes[0].note}dim7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
          else if(mode == "7b5")
            url = "${instr.toLowerCase()}-${notes[0].note}7b5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
          else if(mode == "7#5")
            url = "${instr.toLowerCase()}-${notes[0].note}7s5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
          else if(mode == "Minor 9th")
            url = "${instr.toLowerCase()}-${notes[0].note}m9-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}"; 
          else if(mode == "Major 9th")
            url = "${instr.toLowerCase()}-${notes[0].note}maj9-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}"; 
          else if(mode == "9#5")
            url = "${instr.toLowerCase()}-${notes[0].note}9s5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}"; 
          else if(mode == "9b5")
            url = "${instr.toLowerCase()}-${notes[0].note}9b5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}"; 
          else if(mode == "m7#5")
            url = "${instr.toLowerCase()}-${notes[0].note}m7s5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
          else if(mode == "11th")
            url = "${instr.toLowerCase()}-${notes[0].note}911-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}"; 
          else if(mode == "Major 11th")
            url = "${instr.toLowerCase()}-${notes[0].note}maj911-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}"; 
          else if(mode == "Minor 11th")
            url = "${instr.toLowerCase()}-${notes[0].note}m911-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}"; 
          else if(mode == "11b5")
            url = "${instr.toLowerCase()}-${notes[0].note}911b5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}"; 
          else if(mode == "11#5")
            url = "${instr.toLowerCase()}-${notes[0].note}911s5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}"; 
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
          else if(mode == "6th/9th")
            url = "${instr.toLowerCase()}-${notes[0].note}69-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
          else if(mode == "m7b5")
            url = "${instr.toLowerCase()}-${notes[0].note}m7b5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
          else if(mode == "Diminished 7th")
            url = "${instr.toLowerCase()}-${notes[0].note}dim7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
          else if(mode == "7b5")
            url = "${instr.toLowerCase()}-${notes[0].note}7b5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
          else if(mode == "7#5")
            url = "${instr.toLowerCase()}-${notes[0].note}7s5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
          else if(mode == "Minor 9th")
            url = "${instr.toLowerCase()}-${notes[0].note}m9-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
          else if(mode == "Major 9th")
            url = "${instr.toLowerCase()}-${notes[0].note}maj9-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
          else if(mode == "9#5")
            url = "${instr.toLowerCase()}-${notes[0].note}9s5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
          else if(mode == "9b5")
            url = "${instr.toLowerCase()}-${notes[0].note}9b5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
          else if(mode == "m7#5")
            url = "${instr.toLowerCase()}-${notes[0].note}m7s5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
          else if(mode == "11th")
            url = "${instr.toLowerCase()}-${notes[0].note}911-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
          else if(mode == "Major 11th")
            url = "${instr.toLowerCase()}-${notes[0].note}maj911-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
          else if(mode == "Minor 11th")
            url = "${instr.toLowerCase()}-${notes[0].note}m911-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
          else if(mode == "11b5")
            url = "${instr.toLowerCase()}-${notes[0].note}911b5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
          else if(mode == "11#5")
            url = "${instr.toLowerCase()}-${notes[0].note}911s5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
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
        else if(mode == "6th/9th")
          url = "${instr.toLowerCase()}-${notes[0].note}69-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][12].replaceAll(" ", "-")}";
        else if(mode == "m7b5")
          url = "${instr.toLowerCase()}-${notes[0].note}m7b5-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][13].replaceAll(" ", "-")}";
        else if(mode == "Diminished 7th")
          url = "${instr.toLowerCase()}-${notes[0].note}dim7-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][14].replaceAll(" ", "-")}";
        else if(mode == "7b5")
          url = "${instr.toLowerCase()}-${notes[0].note}7b5-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][15].replaceAll(" ", "-")}";
        else if(mode == "7#5")
          url = "${instr.toLowerCase()}-${notes[0].note}7s5-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][16].replaceAll(" ", "-")}";
        else if(mode == "Minor 9th")
          url = "${instr.toLowerCase()}-${notes[0].note}m9-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][17].replaceAll(" ", "-")}";
        else if(mode == "Major 9th")
          url = "${instr.toLowerCase()}-${notes[0].note}maj9-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][18].replaceAll(" ", "-")}";
        else if(mode == "9#5")
          url = "${instr.toLowerCase()}-${notes[0].note}9s5-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][19].replaceAll(" ", "-")}";
        else if(mode == "9b5")
          url = "${instr.toLowerCase()}-${notes[0].note}9b5-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][20].replaceAll(" ", "-")}";
        else if(mode == "m7#5")
          url = "${instr.toLowerCase()}-${notes[0].note}m7s5-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][21].replaceAll(" ", "-")}";
        else if(mode == "11th")
          url = "${instr.toLowerCase()}-${notes[0].note}911-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[img][notes[0].index][0].replaceAll(" ", "-")}";
        else if(mode == "Major 11th")
          url = "${instr.toLowerCase()}-${notes[0].note}maj911-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[img][notes[0].index][1].replaceAll(" ", "-")}";
        else if(mode == "Minor 11th")
          url = "${instr.toLowerCase()}-${notes[0].note}m911-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[img][notes[0].index][2].replaceAll(" ", "-")}";
        else if(mode == "11b5")
          url = "${instr.toLowerCase()}-${notes[0].note}911b5-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[img][notes[0].index][3].replaceAll(" ", "-")}";
        else if(mode == "11#5")
          url = "${instr.toLowerCase()}-${notes[0].note}911s5-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[img][notes[0].index][4].replaceAll(" ", "-")}";
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
        else if(mode == "6th/9th")
          url = "${instr.toLowerCase()}-${notes[0].note}69-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][12].replaceAll(" ", "-")}";
        else if(mode == "m7b5")
          url = "${instr.toLowerCase()}-${notes[0].note}m7b5-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][13].replaceAll(" ", "-")}";
        else if(mode == "Diminished 7th")
          url = "${instr.toLowerCase()}-${notes[0].note}dim7-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][14].replaceAll(" ", "-")}";
        else if(mode == "7b5")
          url = "${instr.toLowerCase()}-${notes[0].note}7b5-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][15].replaceAll(" ", "-")}";
        else if(mode == "7#5")
          url = "${instr.toLowerCase()}-${notes[0].note}7s5-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][16].replaceAll(" ", "-")}";
        else if(mode == "Minor 9th")
          url = "${instr.toLowerCase()}-${notes[0].note}m9-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][17].replaceAll(" ", "-")}";
        else if(mode == "Major 9th")
          url = "${instr.toLowerCase()}-${notes[0].note}maj9-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][18].replaceAll(" ", "-")}";
        else if(mode == "9#5")
          url = "${instr.toLowerCase()}-${notes[0].note}9s5-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][19].replaceAll(" ", "-")}";
        else if(mode == "9b5")
          url = "${instr.toLowerCase()}-${notes[0].note}9b5-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][20].replaceAll(" ", "-")}";
        else if(mode == "m7#5")
          url = "${instr.toLowerCase()}-${notes[0].note}m7s5-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][21].replaceAll(" ", "-")}";
        else if(mode == "11th")
          url = "${instr.toLowerCase()}-${notes[0].note}911-${notes[0].note.toLowerCase()}-l-h-${shortstrings[img][notes[0].index][0].replaceAll(" ", "-")}";
        else if(mode == "Major 11th")
          url = "${instr.toLowerCase()}-${notes[0].note}maj911-${notes[0].note.toLowerCase()}-l-h-${shortstrings[img][notes[0].index][1].replaceAll(" ", "-")}";
        else if(mode == "Minor 11th")
          url = "${instr.toLowerCase()}-${notes[0].note}m911-${notes[0].note.toLowerCase()}-l-h-${shortstrings[img][notes[0].index][2].replaceAll(" ", "-")}";
        else if(mode == "11b5")
          url = "${instr.toLowerCase()}-${notes[0].note}911b5-${notes[0].note.toLowerCase()}-l-h-${shortstrings[img][notes[0].index][3].replaceAll(" ", "-")}";
        else if(mode == "11#5")
          url = "${instr.toLowerCase()}-${notes[0].note}911s5-${notes[0].note.toLowerCase()}-l-h-${shortstrings[img][notes[0].index][4].replaceAll(" ", "-")}";
        return url.replaceFirst("#", "s").replaceFirst("#", "-sharp").replaceAll("#", "s");  
        }
      }
    }

    String urlAudio(String mode, List<CNote> notes, String instr, String speed, int img){
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
        else if(mode == "6th/9th")
          url = "${instr.toLowerCase()}-${notes[0].note}69-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}"; 
        else if(mode == "m7b5")
          url = "${instr.toLowerCase()}-${notes[0].note}m7b5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
        else if(mode == "Diminished 7th")
          url = "${instr.toLowerCase()}-${notes[0].note}dim7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
        else if(mode == "7b5")
          url = "${instr.toLowerCase()}-${notes[0].note}7b5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
        else if(mode == "7#5")
          url = "${instr.toLowerCase()}-${notes[0].note}7s5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
        else if(mode == "Minor 9th")
          url = "${instr.toLowerCase()}-${notes[0].note}m9-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}"; 
        else if(mode == "Major 9th")
          url = "${instr.toLowerCase()}-${notes[0].note}maj9-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}"; 
        else if(mode == "9#5")
          url = "${instr.toLowerCase()}-${notes[0].note}9s5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}"; 
        else if(mode == "9b5")
          url = "${instr.toLowerCase()}-${notes[0].note}9b5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}"; 
        else if(mode == "m7#5")
          url = "${instr.toLowerCase()}-${notes[0].note}m7s5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}"; 
        else if(mode == "11th")
          url = "${instr.toLowerCase()}-${notes[0].note}911-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}"; 
        else if(mode == "Major 11th")
          url = "${instr.toLowerCase()}-${notes[0].note}maj911-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}"; 
        else if(mode == "Minor 11th")
          url = "${instr.toLowerCase()}-${notes[0].note}m911-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}"; 
        else if(mode == "11b5")
          url = "${instr.toLowerCase()}-${notes[0].note}911b5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}"; 
        else if(mode == "11#5")
          url = "${instr.toLowerCase()}-${notes[0].note}911s5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}"; 
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
        else if(mode == "6th/9th")
          url = "${instr.toLowerCase()}-${notes[0].note}69-$speed-${strings[img][notes[0].index][12].replaceAll(" ", "-")}"; 
        else if(mode == "m7b5")
          url = "${instr.toLowerCase()}-${notes[0].note}m7b5-$speed-${strings[img][notes[0].index][13].replaceAll(" ", "-")}"; 
        else if(mode == "Diminished 7th")
          url = "${instr.toLowerCase()}-${notes[0].note}dim7-$speed-${strings[img][notes[0].index][14].replaceAll(" ", "-")}"; 
        else if(mode == "7b5")
          url = "${instr.toLowerCase()}-${notes[0].note}7b5-$speed-${strings[img][notes[0].index][15].replaceAll(" ", "-")}"; 
        else if(mode == "7#5")
          url = "${instr.toLowerCase()}-${notes[0].note}7s5-$speed-${strings[img][notes[0].index][16].replaceAll(" ", "-")}"; 
        else if(mode == "Minor 9th")
          url = "${instr.toLowerCase()}-${notes[0].note}m9-$speed-${strings[img][notes[0].index][17].replaceAll(" ", "-")}"; 
        else if(mode == "Major 9th")
          url = "${instr.toLowerCase()}-${notes[0].note}maj9-$speed-${strings[img][notes[0].index][18].replaceAll(" ", "-")}"; 
        else if(mode == "9#5")
          url = "${instr.toLowerCase()}-${notes[0].note}9s5-$speed-${strings[img][notes[0].index][19].replaceAll(" ", "-")}"; 
        else if(mode == "9b5")
          url = "${instr.toLowerCase()}-${notes[0].note}9b5-$speed-${strings[img][notes[0].index][20].replaceAll(" ", "-")}"; 
        else if(mode == "m7#5")
          url = "${instr.toLowerCase()}-${notes[0].note}m7s5-$speed-${strings[img][notes[0].index][21].replaceAll(" ", "-")}"; 
        else if(mode == "11th")
          url = "${instr.toLowerCase()}-${notes[0].note}911-$speed-${shortstrings[img][notes[0].index][0].replaceAll(" ", "-")}"; 
        else if(mode == "Major 11th")
          url = "${instr.toLowerCase()}-${notes[0].note}maj911-$speed-${shortstrings[img][notes[0].index][1].replaceAll(" ", "-")}"; 
        else if(mode == "Minor 11th")
          url = "${instr.toLowerCase()}-${notes[0].note}m911-$speed-${shortstrings[img][notes[0].index][2].replaceAll(" ", "-")}"; 
        else if(mode == "11b5")
          url = "${instr.toLowerCase()}-${notes[0].note}911b5-$speed-${shortstrings[img][notes[0].index][3].replaceAll(" ", "-")}"; 
        else if(mode == "11#5")
          url = "${instr.toLowerCase()}-${notes[0].note}911s5-$speed-${shortstrings[img][notes[0].index][4].replaceAll(" ", "-")}"; 
        }
    //print(url);
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
        loadingWidget: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator(strokeWidth: 3, backgroundColor: Colors.orangeAccent,)),
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
      int itemcount = 4;
      if(clickednotescale == "11th" || clickednotescale == "Major 11th" || clickednotescale == "Minor 11th" || clickednotescale == "11b5" || clickednotescale == "11#5")
        itemcount = 2;
      chordimg = Container(
        height: 135,
        padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
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
        itemCount: itemcount, 
        itemBuilder: (BuildContext context, int index){
          return _chrdimg("${urlChord(clickednotescale, myNotes, instrument, index)}");
        },
        // _chrdimg("${urlChord(clickednotescale, myNotes, instrument, imgctr)}"),
      )
      );
    }
    else{
      chordimg = Container(
        padding: EdgeInsets.fromLTRB(6, 8, 6, 0),
        child: _chrdimg("${urlChord(clickednotescale, myNotes, instrument, imgctr)}")
        );
    }

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
                  Row(children: <Widget> [
                    Container(
                      padding: EdgeInsets.only(top: 8, bottom: 2, left: 28, right: 28),
                      color: Color.fromRGBO(255, 225, 225, 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Root", style: TextStyle(fontSize: 20, color: Color.fromRGBO(50, 50, 50, 1)),),
                          DropdownButton(
                            hint: Text(clickednote, style: TextStyle(fontSize: 20, color: Colors.blue),),
                            items: notes.map((CNote value){
                              return DropdownMenuItem<CNote>(
                                child: Text("${value.note}", style: TextStyle(fontSize: 18),),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (CNote newvalue){
                              setState(() {
                                clickedindex = newvalue.index;
                                clickednote = newvalue.note;
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
                    ),
                  ]
                ),
                Divider(height: 0, color: Colors.black26,),
                chordimg,
                mytable(clickedindexscale),
                //Text("${urlAudio(clickednotescale, myNotes, "piano", "fast")}", style: TextStyle(fontSize: 24)),
                
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 6, 0, 16),
                  child: FlatButton(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    color: Color.fromRGBO(240, 50, 50, 0.9),
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