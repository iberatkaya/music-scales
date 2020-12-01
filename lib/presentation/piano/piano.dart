import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:async';

class PianoScreen extends StatelessWidget {
  final AudioCache audioc = new AudioCache();
  Future<void> playcache(String note) async {
    int index;
    if (note == "A" || note == "A#" || note == "B")
      index = 5;
    else
      index = 4;
    await audioc.play(
        "notes/piano/${note.replaceAll("#", "s").toLowerCase()}$index.mp3");
  }

  @override
  Widget build(BuildContext context) {
    Orientation ori = MediaQuery.of(context).orientation;
    double imgheight = 230;

    Column thepiano() {
      if (ori == Orientation.landscape) {
        return Column(children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      playcache("C");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/key1.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      playcache("C#");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/key2.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      playcache("D");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/key3.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      playcache("D#");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/key4.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      playcache("E");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/key5.png"),
                    ),
                  ),
                  GestureDetector(
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/seperator.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      playcache("F");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/key6.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      playcache("F#");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/key7.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      playcache("G");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/key8.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      playcache("G#");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/key9.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      playcache("A");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/key10.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      playcache("A#");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/key11.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      playcache("B");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("assets/imgs/key12.png"),
                    ),
                  ),
                ],
              ))
        ]);
      } else {
        return Column(children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    playcache("C");
                  },
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/key1.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    playcache("C#");
                  },
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/key2.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    playcache("D");
                  },
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/key3.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    playcache("D#");
                  },
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/key4.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    playcache("E");
                  },
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/key5.png"),
                  ),
                ),
                GestureDetector(
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/seperator.png"),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 6, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/seperator.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    playcache("F");
                  },
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/key6.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    playcache("F#");
                  },
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/key7.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    playcache("G");
                  },
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/key8.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    playcache("G#");
                  },
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/key9.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    playcache("A");
                  },
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/key10.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    playcache("A#");
                  },
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/key11.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    playcache("B");
                  },
                  child: Image(
                    height: imgheight,
                    image: AssetImage("assets/imgs/key12.png"),
                  ),
                ),
              ],
            ),
          )
        ]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Piano",
            style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
        elevation: 1,
        actions: <Widget>[
          GestureDetector(
            child: Padding(
                padding: EdgeInsets.only(right: 10),
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
                            "Click on a key and hear the note. View the piano in a row in landscape mode."),
                      ));
            },
          )
        ],
      ),
      //bottomNavigationBar: Container(height: adpadding,),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: thepiano(),
        ),
      ),
    );
  }
}
