import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_scales/domain/chords/chords.dart';
import 'package:music_scales/domain/core/const.dart';

class RandomProgScreen extends StatelessWidget {
  final String progmode;
  final String musicKey;
  final int myindex;
  final List<SmallChord> theScale;
  const RandomProgScreen({
    required this.progmode,
    required this.musicKey,
    required this.myindex,
    required this.theScale,
  });

  Widget build(BuildContext content) {
    AudioPlayer audio = new AudioPlayer();
    String urlAudio(String chord) {
      return "https://www.scales-chords.com/chord-sounds/snd-guitar-chord-${chord.replaceFirst("#", "s")}.mp3";
    }

    Future<void> play(String chord) async {
      await audio.play(urlAudio(chord));
      print(urlAudio(chord));
    }

    TableCell tableCell(String chordname) {
      return TableCell(
        child: FlatButton(
          padding: EdgeInsets.zero,
          color: Color.fromRGBO(230, 80, 80, 0.12),
          onPressed: () {
            play(chordname);
          },
          child: Padding(
              padding:
                  EdgeInsets.fromLTRB(0, textSize * 0.7, 0, textSize * 0.75),
              child: Center(
                  child: Text(
                "$chordname",
                style: TextStyle(
                    fontSize: textSize * 0.85,
                    color: Colors.red,
                    fontWeight: FontWeight.w400),
              ))),
        ),
      );
    }

    List<List> progs() {
      List<List> theProgs;
      if (progmode == "Major")
        theProgs = [
          [1, 4, 5],
          [1, 5, 6, 4],
          [2, 5, 1],
          [1, 6, 4, 5],
          [1, 4, 2, 5],
          [1, 4, 1, 5],
          [1, 3, 4, 5],
          [1, 2, 5]
        ];
      else
        theProgs = [
          [1, 6, 7],
          [1, 4, 6],
          [1, 4, 5],
          [1, 6, 3, 7],
          [1, 7, 6, 7],
          [6, 7, 1, 1],
          [1, 4, 5, 1]
        ];
      return theProgs;
    }

    List<List> progressions = progs();
    Column progTable(int number) {
      if (progressions[number].length == 3) {
        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 26, 0, 6),
              child: Text(
                "Formula: ${progressions[number][0]} - ${progressions[number][1]} - ${progressions[number][2]}",
                style: TextStyle(
                    fontSize: 28, color: Color.fromRGBO(70, 70, 70, 0.8)),
              ),
            ),
            Divider(
              height: 0,
              color: Colors.black26,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  56 - textSize * 0.45, 20, 56 - textSize * 0.45, 0),
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
                              "${progressions[number][0]}",
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
                              "${progressions[number][1]}",
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
                              "${progressions[number][2]}",
                              style: TextStyle(
                                  fontSize: textSize * 0.85,
                                  color: Color.fromRGBO(20, 20, 20, 0.55)),
                            ))),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <TableCell>[
                      tableCell(theScale[progressions[number][0] - 1].name),
                      tableCell(theScale[progressions[number][1] - 1].name),
                      tableCell(theScale[progressions[number][2] - 1].name),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 26, 0, 6),
              child: Text(
                "Formula: ${progressions[number][0]} - ${progressions[number][1]} - ${progressions[number][2]} - ${progressions[number][3]}",
                style: TextStyle(
                    fontSize: 28, color: Color.fromRGBO(70, 70, 70, 0.8)),
              ),
            ),
            Divider(
              height: 0,
              color: Colors.black26,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  44 - textSize * 0.6, 20, 44 - textSize * 0.6, 0),
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
                              "${progressions[number][0]}",
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
                              "${progressions[number][1]}",
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
                              "${progressions[number][2]}",
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
                              "${progressions[number][3]}",
                              style: TextStyle(
                                  fontSize: textSize * 0.85,
                                  color: Color.fromRGBO(20, 20, 20, 0.55)),
                            ))),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <TableCell>[
                      tableCell(theScale[progressions[number][0] - 1].name),
                      tableCell(theScale[progressions[number][1] - 1].name),
                      tableCell(theScale[progressions[number][2] - 1].name),
                      tableCell(theScale[progressions[number][3] - 1].name),
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
