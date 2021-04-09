import 'package:flutter/material.dart';
import 'package:music_scales/domain/chords/chords.dart';

import 'package:music_scales/domain/core/const.dart';

import 'note_cell.dart';

class NoteTable extends StatelessWidget {
  final int mode;
  final List<String> scaleNums;
  final List<ChordNote> notes;
  final String instrument;

  const NoteTable({
    Key? key,
    required this.mode,
    required this.scaleNums,
    required this.instrument,
    required this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      return Padding(
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
              children: <NoteCell>[
                ...List<NoteCell>.generate(
                    4,
                    (i) => NoteCell(
                        instrument: instrument,
                        note: notes[i].note,
                        noteIndex: notes[i].audioindex))
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
      return Padding(
        padding: EdgeInsets.fromLTRB(18, 12, 18, 10),
        child: Column(
          children: <Widget>[
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
                  children: <NoteCell>[
                    ...List<NoteCell>.generate(
                        3,
                        (i) => NoteCell(
                            instrument: instrument,
                            note: notes[i].note,
                            noteIndex: notes[i].audioindex))
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
                    children: <NoteCell>[
                      ...List<NoteCell>.generate(
                          2,
                          (i) => NoteCell(
                              instrument: instrument,
                              note: notes[i + 3].note,
                              noteIndex: notes[i + 3].audioindex))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (mode == 22 ||
        mode == 23 ||
        mode == 24 ||
        mode == 25 ||
        mode == 26 ||
        mode == 29) {
      return Padding(
        padding: EdgeInsets.fromLTRB(18, 12, 18, 10),
        child: Column(
          children: <Widget>[
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
                  children: <NoteCell>[
                    ...List<NoteCell>.generate(
                        3,
                        (i) => NoteCell(
                            instrument: instrument,
                            note: notes[i].note,
                            noteIndex: notes[i].audioindex))
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
                    children: <NoteCell>[
                      ...List<NoteCell>.generate(
                          3,
                          (i) => NoteCell(
                              instrument: instrument,
                              note: notes[i + 3].note,
                              noteIndex: notes[i + 3].audioindex))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
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
            children: <NoteCell>[
              ...List<NoteCell>.generate(
                  3,
                  (i) => NoteCell(
                      instrument: instrument,
                      note: notes[i].note,
                      noteIndex: notes[i].audioindex))
            ],
          ),
        ],
      ),
    );
  }
}
