import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:music_scales/application/store/store.dart';
import 'package:music_scales/domain/chords/chordfingering.dart';
import 'package:music_scales/domain/chords/chords.dart';
import 'package:music_scales/domain/core/const.dart';
import 'dart:async';

class ChordPrintScreen extends StatefulWidget {
  @override
  _ChordPrintScreen createState() => _ChordPrintScreen();
}

class _ChordPrintScreen extends State<ChordPrintScreen> {
  AudioPlayer audio = new AudioPlayer();
  AudioCache audioc = new AudioCache();

  Icon myplay;
  int playctr;
  EdgeInsets playpadding;
  AssetImage instrimg;
  String instrument = "Piano";

  String selectedChordName = chords[0].note;
  int selectedChordIndex = 0;
  String selectedNoteName = "A";
  int selectedNoteIndex = 0;

  List<ChordNote> myNotes = [];
  int imgctr = 0; //Ctr for guitar strings
  int audioctr = 0;
  List<String> scaleNums = ["1", "3", "5", "7", "9", "11"];

  @override
  void initState() {
    myplay = Icon(FontAwesomeIcons.play, color: Colors.black87);
    playctr = 1;
    playpadding = EdgeInsets.only(left: 6);
    instrument = store.state.instrument;
    instrimg =
        AssetImage('assets/imgs/${store.state.instrument.toLowerCase()}.png');
    scaleNums = tablenums(selectedChordName);
    myNotes = calculateChord(selectedChordIndex, selectedNoteIndex);
    super.initState();
  }

  List<ChordNote> calculateChord(var mode, var key) {
    List<ChordNote> theNotes = [];
    int audioindx = 4;
    var index = key;
    Chord chordObj;
    for (int i = 0; i < chords.length; i++) {
      if (mode == chords[i].index) chordObj = chords[i];
    }
    for (int j = 0; j < chordObj.formula.length + 1; j++) {
      if (j != 0) index += chordObj.formula[j - 1];
      if (index > 11) {
        index %= 12;
        if (audioindx == 4)
          audioindx = 5;
        else if (audioindx == 5) audioindx = 6;
      }
      chordNotes[index].audioindex = audioindx;
      theNotes.add(chordNotes[index]);
    }
    return theNotes;
  }

  Future<void> playcache(String note, int index) async {
    //print("notes/${instrument.toLowerCase()}/${note.replaceAll("#", "s").toLowerCase()}$index.mp3");
    await audioc.play(
        "notes/${instrument.toLowerCase()}/${note.replaceAll("#", "s").toLowerCase()}$index.mp3");
  }

  TableCell noteCell(String note, int index) {
    return TableCell(
      child: FlatButton(
        color: Color.fromRGBO(230, 80, 80, 0.12),
        onPressed: () {
          playcache("$note", index);
        },
        child: Container(
          child: Padding(
              padding:
                  EdgeInsets.fromLTRB(0, textSize * 0.7, 0, textSize * 0.75),
              child: Center(
                  child: Text(
                "$note",
                style: TextStyle(
                    fontSize: textSize,
                    color: Colors.red,
                    fontWeight: FontWeight.w400),
              ))),
        ),
      ),
    );
  }

  List<String> tablenums(String chord) {
    List<String> nums = ["1", "3", "5", "7", "9", "11"];
    if (chord == "Minor")
      nums[1] = "b3";
    else if (chord == "7th")
      nums[3] = "b7";
    else if (chord == "Minor 7th") {
      nums[1] = "b3";
      nums[3] = "b7";
    } else if (chord == "m(maj7)")
      nums[1] = "b3";
    else if (chord == "Sus2")
      nums[1] = "2";
    else if (chord == "Sus4")
      nums[1] = "4";
    else if (chord == "6th")
      nums[3] = "6";
    else if (chord == "Minor 6th") {
      nums[3] = "6";
      nums[1] = "b3";
    } else if (chord == "Diminished") {
      nums[1] = "b3";
      nums[2] = "b5";
    } else if (chord == "Diminished 7th") {
      nums[1] = "b3";
      nums[2] = "b5";
      nums[3] = "b6";
    } else if (chord == "Augmented")
      nums[2] = "b6";
    else if (chord == "9th")
      nums[3] = "b7";
    else if (chord == "Minor 9th") {
      nums[1] = "b3";
      nums[3] = "b7";
    } else if (chord == "m(maj9)")
      nums[1] = "b3";
    else if (chord == "6th/9th")
      nums[3] = "b6";
    else if (chord == "m7b5") {
      nums[1] = "b3";
      nums[2] = "b5";
      nums[3] = "b7";
    } else if (chord == "m7#5") {
      nums[1] = "b3";
      nums[2] = "#5";
      nums[3] = "b7";
    } else if (chord == "7b5") {
      nums[2] = "b5";
      nums[3] = "b7";
    } else if (chord == "7#5") {
      nums[2] = "#5";
      nums[3] = "b7";
    } else if (chord == "9#5") {
      nums[2] = "#5";
      nums[3] = "b7";
    } else if (chord == "9b5") {
      nums[2] = "b5";
      nums[3] = "b7";
    } else if (chord == "11th")
      nums[3] = "b7";
    else if (chord == "Minor 11th") {
      nums[1] = "b3";
      nums[3] = "b7";
    } else if (chord == "m(maj11)")
      nums[1] = "b3";
    else if (chord == "11b5") {
      nums[2] = "b5";
      nums[3] = "b7";
    } else if (chord == "11#5") {
      nums[2] = "#5";
      nums[3] = "b7";
    } else if (chord == "Add2") {
      nums[1] = "2";
      nums[2] = "3";
      nums[3] = "5";
    } else if (chord == "Add4") {
      nums[2] = "4";
      nums[3] = "5";
    }
    return nums;
  }

  Padding mytable(int mode) {
    Padding thetable;
    if (mode == 2 ||
        mode == 5 ||
        mode == 6 ||
        mode == 10 ||
        mode == 11 ||
        mode == 13 ||
        mode == 14 ||
        mode == 15 ||
        mode == 16 ||
        mode == 21 ||
        mode == 27 ||
        mode == 30 ||
        mode == 31) {
      thetable = Padding(
        padding: EdgeInsets.fromLTRB(18, 12, 18, 10),
        child: Table(
          border:
              TableBorder.all(width: 1, color: Color.fromRGBO(20, 0, 160, 0.2)),
          children: <TableRow>[
            TableRow(
              children: <TableCell>[
                TableCell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, textSize * 0.3, 0, textSize * 0.35),
                      child: Center(
                          child: Text(
                        "${scaleNums[0]}",
                        style: TextStyle(
                            fontSize: textSize * 0.85,
                            color: Color.fromRGBO(20, 20, 20, 0.75)),
                      ))),
                ),
                TableCell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, textSize * 0.3, 0, textSize * 0.35),
                      child: Center(
                          child: Text(
                        "${scaleNums[1]}",
                        style: TextStyle(
                            fontSize: textSize * 0.85,
                            color: Color.fromRGBO(20, 20, 20, 0.55)),
                      ))),
                ),
                TableCell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, textSize * 0.3, 0, textSize * 0.35),
                      child: Center(
                          child: Text(
                        "${scaleNums[2]}",
                        style: TextStyle(
                            fontSize: textSize * 0.85,
                            color: Color.fromRGBO(20, 20, 20, 0.55)),
                      ))),
                ),
                TableCell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, textSize * 0.3, 0, textSize * 0.35),
                      child: Center(
                          child: Text(
                        "${scaleNums[3]}",
                        style: TextStyle(
                            fontSize: textSize * 0.85,
                            color: Color.fromRGBO(20, 20, 20, 0.55)),
                      ))),
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
    } else if (mode == 9 ||
        mode == 12 ||
        mode == 17 ||
        mode == 18 ||
        mode == 19 ||
        mode == 20 ||
        mode == 28) {
      thetable = Padding(
          padding: EdgeInsets.fromLTRB(18, 12, 18, 10),
          child: Column(children: <Widget>[
            Table(
              border: TableBorder.all(
                  width: 1, color: Color.fromRGBO(20, 0, 160, 0.2)),
              children: <TableRow>[
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, textSize * 0.3, 0, textSize * 0.35),
                          child: Center(
                              child: Text(
                            "${scaleNums[0]}",
                            style: TextStyle(
                                fontSize: textSize * 0.85,
                                color: Color.fromRGBO(20, 20, 20, 0.75)),
                          ))),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, textSize * 0.3, 0, textSize * 0.35),
                          child: Center(
                              child: Text(
                            "${scaleNums[1]}",
                            style: TextStyle(
                                fontSize: textSize * 0.85,
                                color: Color.fromRGBO(20, 20, 20, 0.55)),
                          ))),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, textSize * 0.3, 0, textSize * 0.35),
                          child: Center(
                              child: Text(
                            "${scaleNums[2]}",
                            style: TextStyle(
                                fontSize: textSize * 0.85,
                                color: Color.fromRGBO(20, 20, 20, 0.55)),
                          ))),
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
            Padding(
              padding: EdgeInsets.fromLTRB(40, 12, 40, 0),
              child: Table(
                border: TableBorder.all(
                    width: 1, color: Color.fromRGBO(20, 0, 160, 0.2)),
                children: <TableRow>[
                  TableRow(
                    children: <TableCell>[
                      TableCell(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, textSize * 0.3, 0, textSize * 0.35),
                            child: Center(
                                child: Text(
                              "${scaleNums[3]}",
                              style: TextStyle(
                                  fontSize: textSize * 0.85,
                                  color: Color.fromRGBO(20, 20, 20, 0.55)),
                            ))),
                      ),
                      TableCell(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, textSize * 0.3, 0, textSize * 0.35),
                            child: Center(
                                child: Text(
                              "${scaleNums[4]}",
                              style: TextStyle(
                                  fontSize: textSize * 0.85,
                                  color: Color.fromRGBO(20, 20, 20, 0.55)),
                            ))),
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
          ]));
    } else if (mode == 22 ||
        mode == 23 ||
        mode == 24 ||
        mode == 25 ||
        mode == 26 ||
        mode == 29) {
      thetable = Padding(
          padding: EdgeInsets.fromLTRB(18, 12, 18, 10),
          child: Column(children: <Widget>[
            Table(
              border: TableBorder.all(
                  width: 1, color: Color.fromRGBO(20, 0, 160, 0.2)),
              children: <TableRow>[
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, textSize * 0.3, 0, textSize * 0.35),
                          child: Center(
                              child: Text(
                            "${scaleNums[0]}",
                            style: TextStyle(
                                fontSize: textSize * 0.85,
                                color: Color.fromRGBO(20, 20, 20, 0.75)),
                          ))),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, textSize * 0.3, 0, textSize * 0.35),
                          child: Center(
                              child: Text(
                            "${scaleNums[1]}",
                            style: TextStyle(
                                fontSize: textSize * 0.85,
                                color: Color.fromRGBO(20, 20, 20, 0.55)),
                          ))),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, textSize * 0.3, 0, textSize * 0.35),
                          child: Center(
                              child: Text(
                            "${scaleNums[2]}",
                            style: TextStyle(
                                fontSize: textSize * 0.85,
                                color: Color.fromRGBO(20, 20, 20, 0.55)),
                          ))),
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
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Table(
                border: TableBorder.all(
                    width: 1, color: Color.fromRGBO(20, 0, 160, 0.2)),
                children: <TableRow>[
                  TableRow(
                    children: <TableCell>[
                      TableCell(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, textSize * 0.3, 0, textSize * 0.35),
                            child: Center(
                                child: Text(
                              "${scaleNums[3]}",
                              style: TextStyle(
                                  fontSize: textSize * 0.85,
                                  color: Color.fromRGBO(20, 20, 20, 0.55)),
                            ))),
                      ),
                      TableCell(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, textSize * 0.3, 0, textSize * 0.35),
                            child: Center(
                                child: Text(
                              "${scaleNums[4]}",
                              style: TextStyle(
                                  fontSize: textSize * 0.85,
                                  color: Color.fromRGBO(20, 20, 20, 0.55)),
                            ))),
                      ),
                      TableCell(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, textSize * 0.3, 0, textSize * 0.35),
                            child: Center(
                                child: Text(
                              "${scaleNums[5]}",
                              style: TextStyle(
                                  fontSize: textSize * 0.85,
                                  color: Color.fromRGBO(20, 20, 20, 0.55)),
                            ))),
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
          ]));
    } else {
      thetable = Padding(
        padding: EdgeInsets.fromLTRB(
            56 - textSize * 0.45, 12, 56 - textSize * 0.45, 10),
        child: Table(
          border:
              TableBorder.all(width: 1, color: Color.fromRGBO(20, 0, 160, 0.2)),
          children: <TableRow>[
            TableRow(
              children: <TableCell>[
                TableCell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, textSize * 0.3, 0, textSize * 0.35),
                      child: Center(
                          child: Text(
                        "${scaleNums[0]}",
                        style: TextStyle(
                            fontSize: textSize * 0.85,
                            color: Color.fromRGBO(20, 20, 20, 0.75)),
                      ))),
                ),
                TableCell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, textSize * 0.3, 0, textSize * 0.35),
                      child: Center(
                          child: Text(
                        "${scaleNums[1]}",
                        style: TextStyle(
                            fontSize: textSize * 0.85,
                            color: Color.fromRGBO(20, 20, 20, 0.55)),
                      ))),
                ),
                TableCell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, textSize * 0.3, 0, textSize * 0.35),
                      child: Center(
                          child: Text(
                        "${scaleNums[2]}",
                        style: TextStyle(
                            fontSize: textSize * 0.85,
                            color: Color.fromRGBO(20, 20, 20, 0.55)),
                      ))),
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

  String titleText(String key, String mode) {
    if (mode == "Major")
      return "$key Chord";
    else if (mode == "Minor")
      return "${key}m Chord";
    else if (mode == "Major 7th")
      return "${key}maj7 Chord";
    else if (mode == "Sus2")
      return "${key}sus2 Chord";
    else if (mode == "Sus4")
      return "${key}sus4 Chord";
    else if (mode == "Minor 7th")
      return "${key}m7 Chord";
    else if (mode == "7th")
      return "${key}7 Chord";
    else if (mode == "Diminished")
      return "${key}dim Chord";
    else if (mode == "Augmented")
      return "${key}aug Chord";
    else if (mode == "9th")
      return "${key}9 Chord";
    else if (mode == "6th")
      return "${key}6 Chord";
    else if (mode == "Minor 6th")
      return "${key}m6 Chord";
    else if (mode == "6th/9th")
      return "${key}6/9 Chord";
    else if (mode == "m7b5")
      return "${key}m7b5 Chord";
    else if (mode == "Diminished 7th")
      return "${key}dim7 Chord";
    else if (mode == "7b5")
      return "${key}7b5 Chord";
    else if (mode == "7#5")
      return "${key}7#5 Chord";
    else if (mode == "Minor 9th")
      return "${key}m9 Chord";
    else if (mode == "m(maj9)")
      return "${key}m(maj9) Chord";
    else if (mode == "Major 9th")
      return "${key}maj9 Chord";
    else if (mode == "9#5")
      return "${key}9#5 Chord";
    else if (mode == "9b5")
      return "${key}9b5 Chord";
    else if (mode == "m7#5")
      return "${key}m7#5 Chord";
    else if (mode == "11th")
      return "${key}11 Chord";
    else if (mode == "Major 11th")
      return "${key}maj11 Chord";
    else if (mode == "Minor 11th")
      return "${key}m11 Chord";
    else if (mode == "m(maj11)")
      return "${key}m(maj11) Chord";
    else if (mode == "11b5")
      return "${key}11b5 Chord";
    else if (mode == "11#5")
      return "${key}11#5 Chord";
    else if (mode == "m(maj7)")
      return "${key}m(maj7) Chord";
    else if (mode == "Add2")
      return "${key}add2 Chord";
    else if (mode == "Add4") return "${key}add4 Chord";
    return "$key $mode Chord";
  }

  String urlChord(String mode, List<ChordNote> notes, String instr, int img) {
    String url;
    if (instr == "Piano") {
      if (!notes[0].note.contains("#")) {
        if (mode == "Major")
          url =
              "${instr.toLowerCase()}-${notes[0].note}-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if (mode == "Minor")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if (mode == "Major 7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}maj7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Minor 7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "m(maj7)")
          url =
              "${instr.toLowerCase()}-${notes[0].note}mmaj7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Sus2")
          url =
              "${instr.toLowerCase()}-${notes[0].note}sus2-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if (mode == "Sus4")
          url =
              "${instr.toLowerCase()}-${notes[0].note}sus4-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if (mode == "7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Diminished")
          url =
              "${instr.toLowerCase()}-${notes[0].note}dim-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if (mode == "Augmented")
          url =
              "${instr.toLowerCase()}-${notes[0].note}aug-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if (mode == "9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}9-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "6th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}6-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Minor 6th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m6-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "6th/9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}69-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "m7b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m7b5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Diminished 7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}dim7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "7b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}7b5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "7#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}7s5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Minor 9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m9-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "Major 9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}maj9-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "m(maj9)")
          url =
              "${instr.toLowerCase()}-${notes[0].note}mmaj9-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "9#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}9s5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "9b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}9b5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "m7#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m7s5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "11th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}911-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
        else if (mode == "Major 11th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}maj911-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
        else if (mode == "Minor 11th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m911-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
        else if (mode == "m(maj11)")
          url =
              "${instr.toLowerCase()}-${notes[0].note}mmaj911-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
        else if (mode == "11b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}911b5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
        else if (mode == "11#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}911s5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
        else if (mode == "Add2")
          url =
              "${instr.toLowerCase()}-${notes[0].note}add2-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Add4")
          url =
              "${instr.toLowerCase()}-${notes[0].note}add4-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        return url.replaceAll("#", "s");
      } else {
        if (mode == "Major")
          url =
              "${instr.toLowerCase()}-${notes[0].note}-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if (mode == "Minor")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if (mode == "Major 7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}maj7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Minor 7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "m(maj7)")
          url =
              "${instr.toLowerCase()}-${notes[0].note}mmaj7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Sus2")
          url =
              "${instr.toLowerCase()}-${notes[0].note}sus2-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if (mode == "Sus4")
          url =
              "${instr.toLowerCase()}-${notes[0].note}sus4-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if (mode == "7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Diminished")
          url =
              "${instr.toLowerCase()}-${notes[0].note}dim-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if (mode == "Augmented")
          url =
              "${instr.toLowerCase()}-${notes[0].note}aug-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
        else if (mode == "9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}9-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "6th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}6-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Minor 6th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m6-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "6th/9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}69-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "m7b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m7b5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Diminished 7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}dim7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "7b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}7b5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "7#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}7s5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Minor 9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m9-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "Major 9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}maj9-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "m(maj9)")
          url =
              "${instr.toLowerCase()}-${notes[0].note}mmaj9-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "9#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}9s5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "9b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}9b5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
        else if (mode == "m7#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m7s5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "11th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}911-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
        else if (mode == "Major 11th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}maj911-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
        else if (mode == "Minor 11th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m911-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
        else if (mode == "m(maj11)")
          url =
              "${instr.toLowerCase()}-${notes[0].note}mmaj911-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
        else if (mode == "11b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}911b5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
        else if (mode == "11#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}911s5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
        else if (mode == "Add2")
          url =
              "${instr.toLowerCase()}-${notes[0].note}add2-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        else if (mode == "Add4")
          url =
              "${instr.toLowerCase()}-${notes[0].note}add4-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
        return url
            .replaceFirst("#", "s")
            .replaceFirst("#", "-sharp")
            .replaceAll("#", "s");
      }
    } else if (instr == "Guitar") {
      if (!notes[0].note.contains("#")) {
        if (mode == "Major")
          url =
              "${instr.toLowerCase()}-${notes[0].note}-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][0].replaceAll(" ", "-")}";
        else if (mode == "Minor")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][1].replaceAll(" ", "-")}";
        else if (mode == "Major 7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}maj7-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][2].replaceAll(" ", "-")}";
        else if (mode == "Minor 7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m7-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][3].replaceAll(" ", "-")}";
        else if (mode == "m(maj7)")
          url =
              "${instr.toLowerCase()}-${notes[0].note}mmaj7-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][22].replaceAll(" ", "-")}";
        else if (mode == "Sus2")
          url =
              "${instr.toLowerCase()}-${notes[0].note}sus2-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][4].replaceAll(" ", "-")}";
        else if (mode == "Sus4")
          url =
              "${instr.toLowerCase()}-${notes[0].note}sus4-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][5].replaceAll(" ", "-")}";
        else if (mode == "7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}7-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][6].replaceAll(" ", "-")}";
        else if (mode == "Diminished")
          url =
              "${instr.toLowerCase()}-${notes[0].note}dim-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][7].replaceAll(" ", "-")}";
        else if (mode == "Augmented")
          url =
              "${instr.toLowerCase()}-${notes[0].note}aug-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][8].replaceAll(" ", "-")}";
        else if (mode == "9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}9-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][9].replaceAll(" ", "-")}";
        else if (mode == "6th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}6-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][10].replaceAll(" ", "-")}";
        else if (mode == "Minor 6th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m6-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][11].replaceAll(" ", "-")}";
        else if (mode == "6th/9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}69-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][12].replaceAll(" ", "-")}";
        else if (mode == "m7b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m7b5-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][13].replaceAll(" ", "-")}";
        else if (mode == "Diminished 7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}dim7-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][14].replaceAll(" ", "-")}";
        else if (mode == "7b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}7b5-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][15].replaceAll(" ", "-")}";
        else if (mode == "7#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}7s5-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][16].replaceAll(" ", "-")}";
        else if (mode == "Minor 9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m9-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][17].replaceAll(" ", "-")}";
        else if (mode == "Major 9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}maj9-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][18].replaceAll(" ", "-")}";
        else if (mode == "m(maj9)")
          url =
              "${instr.toLowerCase()}-${notes[0].note}mmaj9-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][23].replaceAll(" ", "-")}";
        else if (mode == "9#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}9s5-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][19].replaceAll(" ", "-")}";
        else if (mode == "9b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}9b5-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][20].replaceAll(" ", "-")}";
        else if (mode == "m7#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m7s5-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][21].replaceAll(" ", "-")}";
        else if (mode == "11th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}911-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[img][notes[0].index][0].replaceAll(" ", "-")}";
        else if (mode == "Major 11th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}maj911-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[img][notes[0].index][1].replaceAll(" ", "-")}";
        else if (mode == "Minor 11th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m911-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[img][notes[0].index][2].replaceAll(" ", "-")}";
        else if (mode == "m(maj11)")
          url =
              "${instr.toLowerCase()}-${notes[0].note}mmaj911-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[img][notes[0].index][5].replaceAll(" ", "-")}";
        else if (mode == "11b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}911b5-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[img][notes[0].index][3].replaceAll(" ", "-")}";
        else if (mode == "11#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}911s5-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[img][notes[0].index][4].replaceAll(" ", "-")}";
        else if (mode == "Add2")
          url =
              "${instr.toLowerCase()}-${notes[0].note}add2-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][24].replaceAll(" ", "-")}";
        else if (mode == "Add4")
          url =
              "${instr.toLowerCase()}-${notes[0].note}add4-${notes[0].note.toLowerCase()}-n-l-h-${strings[img][notes[0].index][25].replaceAll(" ", "-")}";
        return url.replaceAll("#", "s");
      } else {
        if (mode == "Major")
          url =
              "${instr.toLowerCase()}-${notes[0].note}-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][0].replaceAll(" ", "-")}";
        else if (mode == "Minor")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][1].replaceAll(" ", "-")}";
        else if (mode == "Major 7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}maj7-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][2].replaceAll(" ", "-")}";
        else if (mode == "Minor 7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m7-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][3].replaceAll(" ", "-")}";
        else if (mode == "m(maj7)")
          url =
              "${instr.toLowerCase()}-${notes[0].note}mmaj7-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][22].replaceAll(" ", "-")}";
        else if (mode == "Sus2")
          url =
              "${instr.toLowerCase()}-${notes[0].note}sus2-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][4].replaceAll(" ", "-")}";
        else if (mode == "Sus4")
          url =
              "${instr.toLowerCase()}-${notes[0].note}sus4-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][5].replaceAll(" ", "-")}";
        else if (mode == "7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}7-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][6].replaceAll(" ", "-")}";
        else if (mode == "Diminished")
          url =
              "${instr.toLowerCase()}-${notes[0].note}dim-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][7].replaceAll(" ", "-")}";
        else if (mode == "Augmented")
          url =
              "${instr.toLowerCase()}-${notes[0].note}aug-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][8].replaceAll(" ", "-")}";
        else if (mode == "9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}9-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][9].replaceAll(" ", "-")}";
        else if (mode == "6th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}6-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][10].replaceAll(" ", "-")}";
        else if (mode == "Minor 6th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m6-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][11].replaceAll(" ", "-")}";
        else if (mode == "6th/9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}69-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][12].replaceAll(" ", "-")}";
        else if (mode == "m7b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m7b5-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][13].replaceAll(" ", "-")}";
        else if (mode == "Diminished 7th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}dim7-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][14].replaceAll(" ", "-")}";
        else if (mode == "7b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}7b5-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][15].replaceAll(" ", "-")}";
        else if (mode == "7#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}7s5-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][16].replaceAll(" ", "-")}";
        else if (mode == "Minor 9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m9-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][17].replaceAll(" ", "-")}";
        else if (mode == "Major 9th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}maj9-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][18].replaceAll(" ", "-")}";
        else if (mode == "m(maj9)")
          url =
              "${instr.toLowerCase()}-${notes[0].note}mmaj9-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][23].replaceAll(" ", "-")}";
        else if (mode == "9#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}9s5-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][19].replaceAll(" ", "-")}";
        else if (mode == "9b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}9b5-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][20].replaceAll(" ", "-")}";
        else if (mode == "m7#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m7s5-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][21].replaceAll(" ", "-")}";
        else if (mode == "11th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}911-${notes[0].note.toLowerCase()}-l-h-${shortstrings[img][notes[0].index][0].replaceAll(" ", "-")}";
        else if (mode == "Major 11th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}maj911-${notes[0].note.toLowerCase()}-l-h-${shortstrings[img][notes[0].index][1].replaceAll(" ", "-")}";
        else if (mode == "Minor 11th")
          url =
              "${instr.toLowerCase()}-${notes[0].note}m911-${notes[0].note.toLowerCase()}-l-h-${shortstrings[img][notes[0].index][2].replaceAll(" ", "-")}";
        else if (mode == "m(maj11)")
          url =
              "${instr.toLowerCase()}-${notes[0].note}mmaj911-${notes[0].note.toLowerCase()}-l-h-${shortstrings[img][notes[0].index][5].replaceAll(" ", "-")}";
        else if (mode == "11b5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}911b5-${notes[0].note.toLowerCase()}-l-h-${shortstrings[img][notes[0].index][3].replaceAll(" ", "-")}";
        else if (mode == "11#5")
          url =
              "${instr.toLowerCase()}-${notes[0].note}911s5-${notes[0].note.toLowerCase()}-l-h-${shortstrings[img][notes[0].index][4].replaceAll(" ", "-")}";
        else if (mode == "Add2")
          url =
              "${instr.toLowerCase()}-${notes[0].note}add2-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][24].replaceAll(" ", "-")}";
        else if (mode == "Add4")
          url =
              "${instr.toLowerCase()}-${notes[0].note}add4-${notes[0].note.toLowerCase()}-l-h-${strings[img][notes[0].index][25].replaceAll(" ", "-")}";
        return url
            .replaceFirst("#", "s")
            .replaceFirst("#", "-sharp")
            .replaceAll("#", "s");
      }
    }
  }

  String urlAudio(
      String mode, List<ChordNote> notes, String instr, String speed, int img) {
    String url;
    if (instr == "Piano") {
      if (mode == "Major")
        url =
            "${instr.toLowerCase()}-${notes[0].note}-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "Minor")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "Major 7th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}maj7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Minor 7th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Minor 7th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}mmaj7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Sus2")
        url =
            "${instr.toLowerCase()}-${notes[0].note}sus2-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "Sus4")
        url =
            "${instr.toLowerCase()}-${notes[0].note}sus4-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "7th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Diminished")
        url =
            "${instr.toLowerCase()}-${notes[0].note}dim-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "Augmented")
        url =
            "${instr.toLowerCase()}-${notes[0].note}aug-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "9th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}9-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "6th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}6-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Minor 6th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m6-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "6th/9th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}69-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "m7b5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m7b5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Diminished 7th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}dim7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "7b5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}7b5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "7#5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}7s5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Minor 9th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m9-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "Major 9th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}maj9-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "m(maj9)")
        url =
            "${instr.toLowerCase()}-${notes[0].note}mmaj9-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "9#5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}9s5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "9b5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}9b5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "m7#5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m7s5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "11th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}911-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "Major 11th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}maj911-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "Minor 11th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m911-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "m(maj11)")
        url =
            "${instr.toLowerCase()}-${notes[0].note}mmaj911-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "11b5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}911b5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "11#5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}911s5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "Add2")
        url =
            "${instr.toLowerCase()}-${notes[0].note}add2-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Add4")
        url =
            "${instr.toLowerCase()}-${notes[0].note}add4-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    } else if (instr == "Guitar") {
      if (mode == "Major")
        url =
            "${instr.toLowerCase()}-${notes[0].note}-$speed-${strings[img][notes[0].index][0].replaceAll(" ", "-")}";
      else if (mode == "Minor")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m-$speed-${strings[img][notes[0].index][1].replaceAll(" ", "-")}";
      else if (mode == "Major 7th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}maj7-$speed-${strings[img][notes[0].index][2].replaceAll(" ", "-")}";
      else if (mode == "Minor 7th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m7-$speed-${strings[img][notes[0].index][3].replaceAll(" ", "-")}";
      else if (mode == "m(maj7)")
        url =
            "${instr.toLowerCase()}-${notes[0].note}mmaj7-$speed-${strings[img][notes[0].index][22].replaceAll(" ", "-")}";
      else if (mode == "Sus2")
        url =
            "${instr.toLowerCase()}-${notes[0].note}sus2-$speed-${strings[img][notes[0].index][4].replaceAll(" ", "-")}";
      else if (mode == "Sus4")
        url =
            "${instr.toLowerCase()}-${notes[0].note}sus4-$speed-${strings[img][notes[0].index][5].replaceAll(" ", "-")}";
      else if (mode == "7th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}7-$speed-${strings[img][notes[0].index][6].replaceAll(" ", "-")}";
      else if (mode == "Diminished")
        url =
            "${instr.toLowerCase()}-${notes[0].note}dim-$speed-${strings[img][notes[0].index][7].replaceAll(" ", "-")}";
      else if (mode == "Augmented")
        url =
            "${instr.toLowerCase()}-${notes[0].note}aug-$speed-${strings[img][notes[0].index][8].replaceAll(" ", "-")}";
      else if (mode == "9th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}9-$speed-${strings[img][notes[0].index][9].replaceAll(" ", "-")}";
      else if (mode == "6th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}6-$speed-${strings[img][notes[0].index][10].replaceAll(" ", "-")}";
      else if (mode == "Minor 6th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m6-$speed-${strings[img][notes[0].index][11].replaceAll(" ", "-")}";
      else if (mode == "6th/9th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}69-$speed-${strings[img][notes[0].index][12].replaceAll(" ", "-")}";
      else if (mode == "m7b5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m7b5-$speed-${strings[img][notes[0].index][13].replaceAll(" ", "-")}";
      else if (mode == "Diminished 7th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}dim7-$speed-${strings[img][notes[0].index][14].replaceAll(" ", "-")}";
      else if (mode == "7b5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}7b5-$speed-${strings[img][notes[0].index][15].replaceAll(" ", "-")}";
      else if (mode == "7#5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}7s5-$speed-${strings[img][notes[0].index][16].replaceAll(" ", "-")}";
      else if (mode == "Minor 9th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m9-$speed-${strings[img][notes[0].index][17].replaceAll(" ", "-")}";
      else if (mode == "Major 9th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}maj9-$speed-${strings[img][notes[0].index][18].replaceAll(" ", "-")}";
      else if (mode == "m(maj9)")
        url =
            "${instr.toLowerCase()}-${notes[0].note}mmaj9-$speed-${strings[img][notes[0].index][23].replaceAll(" ", "-")}";
      else if (mode == "9#5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}9s5-$speed-${strings[img][notes[0].index][19].replaceAll(" ", "-")}";
      else if (mode == "9b5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}9b5-$speed-${strings[img][notes[0].index][20].replaceAll(" ", "-")}";
      else if (mode == "m7#5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m7s5-$speed-${strings[img][notes[0].index][21].replaceAll(" ", "-")}";
      else if (mode == "11th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}911-$speed-${shortstrings[img][notes[0].index][0].replaceAll(" ", "-")}";
      else if (mode == "Major 11th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}maj911-$speed-${shortstrings[img][notes[0].index][1].replaceAll(" ", "-")}";
      else if (mode == "Minor 11th")
        url =
            "${instr.toLowerCase()}-${notes[0].note}m911-$speed-${shortstrings[img][notes[0].index][2].replaceAll(" ", "-")}";
      else if (mode == "m(maj11)")
        url =
            "${instr.toLowerCase()}-${notes[0].note}mmaj911-$speed-${shortstrings[img][notes[0].index][5].replaceAll(" ", "-")}";
      else if (mode == "11b5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}911b5-$speed-${shortstrings[img][notes[0].index][3].replaceAll(" ", "-")}";
      else if (mode == "11#5")
        url =
            "${instr.toLowerCase()}-${notes[0].note}911s5-$speed-${shortstrings[img][notes[0].index][4].replaceAll(" ", "-")}";
      else if (mode == "Add2")
        url =
            "${instr.toLowerCase()}-${notes[0].note}add2-$speed-${strings[img][notes[0].index][24].replaceAll(" ", "-")}";
      else if (mode == "Add4")
        url =
            "${instr.toLowerCase()}-${notes[0].note}add4-$speed-${strings[img][notes[0].index][25].replaceAll(" ", "-")}";
    }
    //print(url);
    if (!notes[0].note.contains("#"))
      return url.replaceAll("#", "s");
    else
      return url.replaceFirst("#", "s").replaceAll("#", "s");
  }

  Future<void> play() async {
    await audio.play(
        "https://www.scales-chords.com/chord-sound/${urlAudio(selectedChordName, myNotes, instrument, store.state.fastChordAudioSpeed ? "fast" : "slow", audioctr)}.mp3");
  }

  Future<void> pause() async {
    await audio.pause();
  }

  var chordimg;
  TransitionToImage _chrdimg(String url) {
    String totalurl = "https://www.scales-chords.com/chord-charts/$url.jpg";
    chordimg = TransitionToImage(
      image: AdvancedNetworkImage(totalurl, useDiskCache: true),
      fit: BoxFit.fill,
      loadingWidget: Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            backgroundColor: Colors.orangeAccent,
          )),
      placeholder: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 6),
            child: Text(
              "No Internet Connection!",
              style: TextStyle(
                  color: Color.fromRGBO(50, 50, 50, 0.6), fontSize: 20),
            ),
          ),
          Icon(
            Icons.refresh,
            color: Colors.red,
            size: 52,
          ),
        ],
      ),
      enableRefresh: true,
    );
    return chordimg;
  }

  void playicon() {
    setState(() {
      if (playctr == 1) {
        myplay = Icon(FontAwesomeIcons.pause, color: Colors.black87);
      } else {
        myplay = Icon(FontAwesomeIcons.play, color: Colors.black87);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (instrument == "Guitar") {
      int itemcount = 4;
      chordimg = Container(
          height: 135,
          padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
          child: Swiper(
            onIndexChanged: (index) {
              audioctr = index;
            },
            control: SwiperControl(
                size: 28,
                padding: EdgeInsets.only(bottom: 16),
                color: Colors.amberAccent,
                iconNext: Icons.navigate_next,
                iconPrevious: Icons.navigate_before),
            itemCount: itemcount,
            itemBuilder: (BuildContext context, int index) {
              return _chrdimg(
                  "${urlChord(selectedChordName, myNotes, instrument, index)}");
            },
            // _chrdimg("${urlChord(selectedChordName, myNotes, instrument, imgctr)}"),
          ));
    } else {
      chordimg = Container(
          padding: EdgeInsets.fromLTRB(6, 8, 6, 0),
          child: _chrdimg(
              "${urlChord(selectedChordName, myNotes, instrument, imgctr)}"));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("${titleText(selectedNoteName, selectedChordName)}",
            style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
        elevation: 1,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                if (instrument == "Guitar") {
                  instrument = "Piano";
                  imgctr = 0;
                } else if (instrument == "Piano") instrument = "Guitar";
                instrimg =
                    AssetImage('assets/imgs/${instrument.toLowerCase()}.png');
              });
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 6, 8),
              child: Image(
                color: Colors.black,
                image: instrimg,
              ),
            ),
          ),
          GestureDetector(
            child: Padding(
                padding: EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.help,
                  size: 30,
                )),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctxt) => AlertDialog(
                        title: Text(
                          "Help",
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                            "Click and select a chord from the menu. Press the button next to the question mark to change the instrument. Click the red button to hear the audio of the chord, and the red tiles to hear the individual notes with the selected instrument. While viewing the guitar chord, slide the chord to the view alternative shapes of the chord."),
                      ));
            },
          )
        ],
      ),
      //bottomNavigationBar: Container(height: adpadding,),
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 2, left: 28, right: 28),
                  color: Color.fromRGBO(255, 225, 225, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Root",
                        style: TextStyle(
                            fontSize: 20, color: Color.fromRGBO(50, 50, 50, 1)),
                      ),
                      DropdownButton(
                        hint: Text(
                          selectedNoteName,
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                        items: chordNotes.map((ChordNote value) {
                          return DropdownMenuItem<ChordNote>(
                            child: Text(
                              "${value.note}",
                              style: TextStyle(fontSize: 18),
                            ),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (ChordNote newvalue) {
                          setState(() {
                            selectedNoteIndex = newvalue.index;
                            selectedNoteName = newvalue.note;

                            scaleNums = tablenums(selectedChordName);
                            myNotes = calculateChord(
                                selectedChordIndex, selectedNoteIndex);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color.fromRGBO(225, 250, 250, 1),
                    padding: EdgeInsets.only(top: 10, bottom: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Chord",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(50, 50, 50, 1)),
                        ),
                        DropdownButton(
                          hint: Text(
                            selectedChordName,
                            style: TextStyle(
                                fontSize: 20, color: Colors.deepPurple),
                          ),
                          items: chords.map((Chord value) {
                            return DropdownMenuItem<Chord>(
                              child: Text(
                                "${value.note}",
                                style: TextStyle(fontSize: 18),
                              ),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (Chord newvalue) {
                            setState(() {
                              selectedChordName = newvalue.note;
                              selectedChordIndex = newvalue.index;
                              imgctr = 0;
                              scaleNums = tablenums(selectedChordName);

                              myNotes = calculateChord(
                                  selectedChordIndex, selectedNoteIndex);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              Divider(
                height: 0,
                color: Colors.black26,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    chordimg,
                    mytable(selectedChordIndex),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 6, 0, 16),
                        child: FlatButton(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          color: Color.fromRGBO(240, 50, 50, 0.9),
                          child: Padding(
                            padding: playpadding,
                            child: myplay,
                          ),
                          onPressed: () {
                            playicon();
                            if (playctr == 1) {
                              play();
                              setState(() {
                                playpadding = EdgeInsets.only(left: 0);
                                playctr = 0;
                              });
                            } else {
                              pause();
                              setState(() {
                                playpadding = EdgeInsets.only(left: 6);
                                playctr = 1;
                              });
                            }
                            audio.onPlayerCompletion.listen((event) {
                              playicon();
                              setState(() {
                                playpadding = EdgeInsets.only(left: 6);
                                playctr = 1;
                              });
                            });
                          },
                        )),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
