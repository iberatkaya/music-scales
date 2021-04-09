import 'package:flutter/material.dart';

import 'package:music_scales/application/store/store.dart';
import 'package:music_scales/domain/core/const.dart';
import 'package:music_scales/domain/notes/notes.dart';

import 'note_cell.dart';

class ScaleTable extends StatelessWidget {
  final List<SNote> scale;
  final List<String> scaleNums;
  final String mode;
  final String instrument;

  const ScaleTable({
    Key? key,
    required this.scale,
    required this.scaleNums,
    required this.mode,
    required this.instrument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SNote> printScale = [...scale];
    if (store.state.showFlatsInScales) {
      for (int i = 0; i < scale.length; i++) {
        SNote temp = SNote(scale[i].note, scale[i].index, scale[i].audioindex,
            scale[i].bemolle);
        if (temp.bemolle != "") temp.note = temp.bemolle;
        printScale[i] = temp;
      }
    }

    if (mode == "Blues" || mode == "Augmented") {
      return Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(18, 12, 18, 12),
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
                children: <NoteCell>[
                  ...List<NoteCell>.generate(
                    3,
                    (i) => NoteCell(
                      note: printScale[i].note,
                      audioIndex: scale[i].audioindex,
                      instrument: instrument,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
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
                children: <NoteCell>[
                  ...List<NoteCell>.generate(
                    3,
                    (i) => NoteCell(
                      note: printScale[i + 3].note,
                      audioIndex: scale[i + 3].audioindex,
                      instrument: instrument,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ]);
    } else if (mode == "Major Pentatonic" ||
        mode == "Minor Pentatonic" ||
        mode == "Balinese" ||
        mode == "Chinese" ||
        mode == "Egyptian" ||
        mode == "Mongolian") {
      return Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(18, 12, 18, 12),
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
                children: <NoteCell>[
                  ...List<NoteCell>.generate(
                    3,
                    (i) => NoteCell(
                      note: printScale[i].note,
                      audioIndex: scale[i].audioindex,
                      instrument: instrument,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(60, 0, 45, 60),
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
                children: <NoteCell>[
                  ...List<NoteCell>.generate(
                    2,
                    (i) => NoteCell(
                      note: printScale[i + 3].note,
                      audioIndex: scale[i + 3].audioindex,
                      instrument: instrument,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ]);
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18, 12, 18, 12),
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
                  children: <NoteCell>[
                    ...List<NoteCell>.generate(
                      4,
                      (i) => NoteCell(
                        note: printScale[i].note,
                        audioIndex: scale[i].audioindex,
                        instrument: instrument,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
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
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, textSize * 0.3, 0, textSize * 0.35),
                          child: Center(
                              child: Text(
                            "${scaleNums[6]}",
                            style: TextStyle(
                                fontSize: textSize * 0.85,
                                color: Color.fromRGBO(20, 20, 20, 0.55)),
                          ))),
                    ),
                  ],
                ),
                TableRow(
                  children: <NoteCell>[
                    ...List<NoteCell>.generate(
                      3,
                      (i) => NoteCell(
                        note: printScale[i + 4].note,
                        audioIndex: scale[i + 4].audioindex,
                        instrument: instrument,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
