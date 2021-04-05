import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_scales/domain/notes/notes.dart';
import 'package:music_scales/domain/scales/scales.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  @override
  void initState() {
    allScalesCalculate();
    super.initState();
  }

  void allScalesCalculate() {
    for (int i = 0; i < 12; i++) {
      for (int j = 0; j < 41; j++) {
        int index = i;
        for (int k = 0; k < scales[j].formula.length + 1; k++) {
          if (k != 0) index += scales[j].formula[k - 1];
          if (index > 11) index %= 12;
          allScales[i][j].add(searchNotes[index]);
        }
      }
    }
  }

  final myController = TextEditingController();
  String searchText = "";
  List<Note> searchNotes = [...notes];

  List<Note> calculateScale(int mode, int key) {
    List<Note> theScale = [];
    int index = key;
    late Scale scaleObj;
    for (int i = 0; i < scales.length; i++) {
      if (mode == scales[i].index) scaleObj = scales[i];
    }

    for (int j = 0; j < scaleObj.formula.length + 1; j++) {
      if (j != 0) index += scaleObj.formula[j - 1];
      if (index > 11) index %= 12;
      theScale.add(searchNotes[index]);
    }
    return theScale;
  }

  List<int> noteindexs = [];
  List<int> scaleindexs = [];
  void scaleSearcher(List<String> mynotes) {
    //When adding new scales, change the j number of iteration; and from main.dart, add the new indexs to allScales and change j
    noteindexs = [];
    scaleindexs = [];
    int ctr;
    for (int i = 0; i < 12; i++) {
      //  print(searchNotes[i].note);
      for (int j = 0; j < 41; j++) {
        ctr = 0;
        for (int k = 0; k < scales[j].formula.length + 1; k++) {
          for (int l = 0; l < mynotes.length; l++) {
            if (mynotes[l] == allScales[i][j][k].note) {
              ctr++;
            }
          }
        }
        //print(ctr);
        if (ctr == mynotes.length) {
          noteindexs.add(i);
          scaleindexs.add(j);
        }
      }
    }
  }

  List<String> bToSharp(List<String> thenotes) {
    String temp;
    int tempcharcode;
    String tempfinal;
    List<String> temptoreturn = [];
    for (int i = 0; i < thenotes.length; i++) {
      tempfinal = thenotes[i];
      if (thenotes[i].length == 2) {
        if (thenotes[i][1] == "b") {
          tempcharcode = thenotes[i].codeUnitAt(0) - 1;
          if (tempcharcode == 64) tempcharcode = 71;
          temp = String.fromCharCode(tempcharcode);
          tempfinal = "$temp#";
        }
      }
      //print(tempfinal);
      temptoreturn.add(tempfinal);
    }
    return temptoreturn;
  }

  Text scaleNotesText(List<Note> mynotes) {
    if (mynotes.length == 7) {
      return Text(
        "${mynotes[0].note} ${mynotes[1].note} ${mynotes[2].note} ${mynotes[3].note} ${mynotes[4].note} ${mynotes[5].note} ${mynotes[6].note}",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
      );
    } else if (mynotes.length == 6) {
      return Text(
        "${mynotes[0].note} ${mynotes[1].note} ${mynotes[2].note} ${mynotes[3].note} ${mynotes[4].note} ${mynotes[5].note}",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
      );
    } else if (mynotes.length == 5) {
      return Text(
        "${mynotes[0].note} ${mynotes[1].note} ${mynotes[2].note} ${mynotes[3].note} ${mynotes[4].note}",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
      );
    }
    return Text("");
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //Fixes keyboard overflow issue
      appBar: AppBar(
        title: Text("Search in a Scale",
            style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
        elevation: 1,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: Icon(
                Icons.help,
                size: 30,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctxt) => AlertDialog(
                          title: Text(
                            "Help",
                            textAlign: TextAlign.center,
                          ),
                          content: Text(
                              "Write the notes in the search bar. Use '#' for sharp notes and 'b' for flat notes."), // Click the scale to view it. (Buggy)
                        ));
              },
            ),
          ),
        ],
      ),
      //bottomNavigationBar: Container(height: adpadding,),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(255, 195, 195, 0.5),
            padding: EdgeInsets.only(bottom: 17, top: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200,
                  child: TextField(
                    controller: myController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "eg. A C# E",
                        labelText: "Notes",
                        icon:
                            Icon(Icons.music_note, color: Colors.orange[600])),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    textCapitalization: TextCapitalization.words,
                    onSubmitted: (text) {
                      setState(() {
                        searchText = text;
                        scaleSearcher(bToSharp(text.trim().split(" ")));
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                )
              ],
            ),
          ),
          Divider(
            height: 0,
            color: Colors.black26,
          ),
          Container(
              child: Expanded(
            child: ListView.separated(
              itemCount: noteindexs.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 0,
                  color: Colors.black26,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                List<List<Note>> scaleNotes = [];
                for (int j = 0; j < noteindexs.length; j++) {
                  var scale = calculateScale(scales[scaleindexs[index]].index,
                      searchNotes[noteindexs[index]].index);

                  scaleNotes.add(scale);
                }
                return ListTile(
                  title: Container(
                    padding: EdgeInsets.fromLTRB(0, 6, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${searchNotes[noteindexs[index]].note} ${scales[scaleindexs[index]].name}",
                          style: TextStyle(fontSize: 26),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 6),
                        ),
                        scaleNotesText(scaleNotes[index]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ))
        ],
      )),
    );
  }

  //Dart formatter formats the variable this way
  var allScales = [
    [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ],
    [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ],
    [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ],
    [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ],
    [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ],
    [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ],
    [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ],
    [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ],
    [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ],
    [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ],
    [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ],
    [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ],
  ];
}
