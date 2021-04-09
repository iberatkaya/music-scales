import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:music_scales/domain/core/const.dart';

class NoteCell extends StatelessWidget {
  final String instrument;
  final String note;
  final int noteIndex;

  NoteCell({
    Key? key,
    required this.instrument,
    required this.note,
    required this.noteIndex,
  }) : super(key: key);

  final AudioCache audioc = new AudioCache();

  Future<void> playCache(String note, int index) async {
    //print("notes/${instrument.toLowerCase()}/${note.replaceAll("#", "s").toLowerCase()}$index.mp3");
    await audioc.play(
        "notes/${instrument.toLowerCase()}/${note.replaceAll("#", "s").toLowerCase()}$index.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: FlatButton(
        color: Color.fromRGBO(230, 80, 80, 0.12),
        onPressed: () {
          playCache("$note", noteIndex);
        },
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, textSize * 0.7, 0, textSize * 0.75),
            child: Center(
              child: Text(
                "$note",
                style: TextStyle(
                    fontSize: textSize,
                    color: Colors.red,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
