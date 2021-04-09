import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:music_scales/application/store/store.dart';
import 'package:music_scales/domain/chords/chords.dart';
import 'package:music_scales/presentation/chords/utils/utils.dart';
import 'package:music_scales/presentation/chords/widgets/note_table.dart';

class ChordPrintScreen extends StatefulWidget {
  @override
  _ChordPrintScreen createState() => _ChordPrintScreen();
}

class _ChordPrintScreen extends State<ChordPrintScreen> {
  AudioPlayer audio = new AudioPlayer();
  AudioCache audioc = new AudioCache();

  Icon myplay = Icon(FontAwesomeIcons.play, color: Colors.black87);
  int playctr = 1;
  EdgeInsets playpadding = EdgeInsets.only(left: 6);
  AssetImage instrimg =
      AssetImage('assets/imgs/${store.state.instrument.toLowerCase()}.png');
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
    instrument = store.state.instrument;
    scaleNums = tablenums(selectedChordName);
    myNotes = calculateChord(selectedChordIndex, selectedNoteIndex);
    super.initState();
  }

  Future<void> play() async {
    await audio.play(
        "https://www.scales-chords.com/chord-sound/${urlAudio(selectedChordName, myNotes, instrument, store.state.fastChordAudioSpeed ? "fast" : "slow", audioctr)}.mp3");
  }

  Future<void> pause() async {
    await audio.pause();
  }

  Widget chordimg = Container();

  CachedNetworkImage _chrdimg(String url) {
    String totalurl = "https://www.scales-chords.com/chord-charts/$url.jpg";
    var myChordImg = CachedNetworkImage(
      imageUrl: totalurl,
      fit: BoxFit.fill,
      placeholder: (context, url) => Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
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
    );
    return myChordImg;
  }

  void setPlayIcon() {
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
                      DropdownButton<ChordNote>(
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
                        onChanged: (newvalue) {
                          if (newvalue == null) return;
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
                        DropdownButton<Chord>(
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
                          onChanged: (newvalue) {
                            if (newvalue == null) return;

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
                    NoteTable(
                      notes: myNotes,
                      instrument: instrument,
                      mode: selectedChordIndex,
                      scaleNums: scaleNums,
                    ),
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
                            setPlayIcon();
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
                              setPlayIcon();
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
