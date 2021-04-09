import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:music_scales/domain/core/const.dart';

class NoteCell extends StatelessWidget {
  final String note;
  final int audioIndex;
  final String instrument;
  final AudioCache audio = new AudioCache();

  NoteCell({
    Key? key,
    required this.note,
    required this.audioIndex,
    required this.instrument,
  }) : super(key: key);

  Future<void> play(String note, int audioIndex) async {
    await audio.play(
        "notes/${instrument.toLowerCase()}/${note.replaceAll("#", "s").toLowerCase()}$audioIndex.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: FlatButton(
        color: Color.fromRGBO(230, 80, 80, 0.12),
        onPressed: () {
          String tempNote = note;
          if (note.length > 1) {
            if (note[1] == "b") {
              int tempint;
              tempint = note.codeUnitAt(0);
              tempint--;
              if (tempint < 65) tempint += 7;
              if (note.length == 3)
                tempNote = String.fromCharCode(tempint);
              else
                tempNote = String.fromCharCode(tempint) + "#";
            }
          }
          //print("note is $note");
          play("$tempNote", audioIndex);
        },
        child: Container(
          child: Padding(
              padding:
                  EdgeInsets.fromLTRB(0, textSize * 0.7, 0, textSize * 0.75),
              child: Text(
                "$note",
                maxLines: 1,
                style: TextStyle(
                    fontSize: textSize,
                    color: Colors.red,
                    fontWeight: FontWeight.w400),
              )),
        ),
      ),
    );
  }
}
