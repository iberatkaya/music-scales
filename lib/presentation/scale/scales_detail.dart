import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_scales/application/store/store.dart';
import 'package:music_scales/domain/notes/notes.dart';
import 'package:music_scales/domain/scales/scales.dart';
import 'package:music_scales/presentation/scale/utils/utils.dart';

import 'package:music_scales/presentation/scale/widgets/scale_table.dart';

class ScalePrintScreen extends StatefulWidget {
  @override
  _ScalePrintScreen createState() => _ScalePrintScreen();
}

class _ScalePrintScreen extends State<ScalePrintScreen> {
  late AssetImage instrimg;
  String instrument = "Piano";
  String selectedScaleName = scales[0].name;
  int selectedScaleIndex = 0;
  String selectedNoteName = "A";
  int selectedNoteIndex = 0;
  late List<SNote> myScale;
  List<String> scaleNums = ["1", "2", "3", "4", "5", "6", "7"];

  @override
  void initState() {
    instrument = store.state.instrument;
    instrimg =
        AssetImage('assets/imgs/${store.state.instrument.toLowerCase()}.png');
    myScale = calculateScale(selectedScaleIndex, selectedNoteIndex);
    super.initState();
  }

  List<SNote> sharpToBemolle(List<SNote> thenotes) {
    List<SNote> tempscale = [];
    tempscale.add(thenotes[0]);
    for (int i = 1; i < thenotes.length; i++) {
      SNote tempnote = new SNote(thenotes[i].note, thenotes[i].index,
          thenotes[i].audioindex, thenotes[i].bemolle);
      for (int j = 0; j < i; j++) {
        if (tempscale[j].isBemolle == false) {
          if (tempscale[j].note.contains(tempnote.note[0])) {
            tempnote.isBemolle = true;
            break;
          }
        } else {
          if (tempscale[j].bemolle.contains(tempnote.note[0])) {
            tempnote.isBemolle = true;
            break;
          }
        }
      }
      tempscale.add(tempnote);
    }
    return tempscale;
  }

  List<SNote> calculateScale(int mode, int key) {
    List<SNote> theScale = [];
    int audioindx = 4;
    int index = key;
    late Scale scaleObj;
    for (int i = 0; i < scales.length; i++) {
      if (mode == scales[i].index) scaleObj = scales[i];
    }

    for (int j = 0; j < scaleObj.formula.length + 1; j++) {
      if (j != 0) index += scaleObj.formula[j - 1];
      if (index > 11) {
        index %= 12;
        audioindx = 5;
      }
      sNotes[index].audioindex = audioindx;
      theScale.add(sNotes[index]);
    }
    return sharpToBemolle(theScale);
  }

  Widget scaleimg() {
    if (instrument == "Guitar") {
      return CachedNetworkImage(
        imageUrl:
            "https://www.scales-chords.com/music-scales/${urlScale(selectedScaleName, myScale, instrument.toLowerCase())}.jpg",
        placeholder: (context, url) => Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              strokeWidth: 3,
              backgroundColor: Colors.orangeAccent,
            )),
        errorWidget: (context, url, error) => Column(
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
        height: 100,
        alignment: Alignment(-1, -1),
        fit: BoxFit.fitHeight,
      );
    }
    return CachedNetworkImage(
      imageUrl:
          "https://www.scales-chords.com/music-scales/${urlScale(selectedScaleName, myScale, instrument.toLowerCase())}.jpg",
      placeholder: (context, url) => Padding(
        padding: EdgeInsets.all(20),
        child: CircularProgressIndicator(
          strokeWidth: 3,
          backgroundColor: Colors.orangeAccent,
        ),
      ),
      errorWidget: (context, url, error) => Column(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$selectedNoteName $selectedScaleName",
          style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1)),
          overflow: TextOverflow.fade,
        ),
        elevation: 1,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                if (instrument == "Guitar")
                  instrument = "Piano";
                else if (instrument == "Piano") instrument = "Guitar";
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
                            "Click and select a scale from the menu. Press the button next to the question mark to change the instrument. Click on the red tiles to hear the individual notes with the selected instrument. While viewing the guitar scale, slide the scale to the right to see the remaining scale."),
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
                      DropdownButton<SNote>(
                        hint: Text(
                          selectedNoteName,
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                        items: sNotes.map((SNote value) {
                          return DropdownMenuItem<SNote>(
                            child: Text(
                              "${value.note}",
                              style: TextStyle(fontSize: 18),
                            ),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (newvalue) {
                          if (newvalue != null)
                            setState(() {
                              selectedNoteIndex = newvalue.index;
                              selectedNoteName = newvalue.note;
                              scaleNums = updateTableNums(selectedScaleName);
                              myScale = calculateScale(
                                  selectedScaleIndex, selectedNoteIndex);
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
                        "Scale",
                        style: TextStyle(
                            fontSize: 20, color: Color.fromRGBO(50, 50, 50, 1)),
                      ),
                      DropdownButton<Scale>(
                        hint: Text(
                          selectedScaleName,
                          style:
                              TextStyle(fontSize: 20, color: Colors.deepPurple),
                        ),
                        items: scales.map((Scale value) {
                          return DropdownMenuItem<Scale>(
                            child: Text(
                              "${value.name}",
                              style: TextStyle(fontSize: 18),
                            ),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (newvalue) {
                          if (newvalue != null)
                            setState(() {
                              selectedScaleName = newvalue.name;
                              selectedScaleIndex = newvalue.index;

                              scaleNums = updateTableNums(selectedScaleName);

                              myScale = calculateScale(
                                  selectedScaleIndex, selectedNoteIndex);
                            });
                        },
                      ),
                    ],
                  ),
                )),
              ]),
              Divider(
                height: 0,
                color: Colors.black26,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(6, 8, 6, 0),
                      child: SingleChildScrollView(
                        child: scaleimg(),
                        scrollDirection: instrument == "Guitar"
                            ? Axis.horizontal
                            : Axis.vertical,
                      ),
                    ),
                    ScaleTable(
                      instrument: instrument,
                      mode: selectedScaleName,
                      scale: myScale,
                      scaleNums: scaleNums,
                    ),
                  ]),
                ),
              ),
              //Text('$selectedScaleName ${myScale[0].note}  ${urlScale(selectedScaleName, myScale[0].note, instrument.toLowerCase())}'),
            ],
          ),
        ),
      ),
    );
  }
}
