import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'main.dart';
import 'dart:async';

class PianoScreen extends StatelessWidget {
  
  final AudioCache audioc = new AudioCache();
  Future<void> playcache(String note) async{
    await audioc.play("notes/piano/${note.replaceAll("#", "s")}.mp3", volume: 0.6);
  }

  @override
  Widget build(BuildContext context) {
    Orientation ori = MediaQuery.of(context).orientation;
    double imgheight = 230;
    audioc.loadAll(["notes/piano/A.mp3", "notes/piano/As.mp3", "notes/piano/B.mp3", "notes/piano/C.mp3", "notes/piano/Cs.mp3", "notes/piano/D.mp3", "notes/piano/Ds.mp3", "notes/piano/E.mp3", "notes/piano/F.mp3", "notes/piano/Fs.mp3", "notes/piano/G.mp3", "notes/piano/Gs.mp3"]);

    Column thepiano(){
      if(ori == Orientation.landscape){
        return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      playcache("C");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("lib/assets/imgs/key1.png"),
                    ),
                  ),
                  GestureDetector( 
                    onTap: (){
                      playcache("C#");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("lib/assets/imgs/key2.png"),
                    ),
                  ),
                  GestureDetector( 
                    onTap: (){
                      playcache("D");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("lib/assets/imgs/key3.png"),
                    ),
                  ),
                  GestureDetector( 
                    onTap: (){
                      playcache("D#");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("lib/assets/imgs/key4.png"),
                    ),
                  ),
                  GestureDetector( 
                    onTap: (){
                      playcache("E");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("lib/assets/imgs/key5.png"),
                    ),
                  ),
                  GestureDetector( 
                    child: Image(
                      height: imgheight,
                      image: AssetImage("lib/assets/imgs/seperator.png"),
                    ),
                  ),
                  GestureDetector( 
                      onTap: (){
                        playcache("F");
                      },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key6.png"),
                      ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("F#");
                      },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key7.png"),
                      ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("G");
                      },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key8.png"),
                      ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("G#");
                      },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key9.png"),
                      ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("A");
                      },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key10.png"),
                      ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("A#");
                      },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key11.png"),
                    ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("B");
                     },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key12.png"),
                      ),
                    ),
                  ],
                )
        )]);
                
      }
      else{
        return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  GestureDetector( 
                    onTap: (){
                      playcache("C");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("lib/assets/imgs/key1.png"),
                    ),
                  ),
                  GestureDetector( 
                    onTap: (){
                      playcache("C#");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("lib/assets/imgs/key2.png"),
                    ),
                  ),
                  GestureDetector( 
                    onTap: (){
                      playcache("D");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("lib/assets/imgs/key3.png"),
                    ),
                  ),
                  GestureDetector( 
                    onTap: (){
                      playcache("D#");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("lib/assets/imgs/key4.png"),
                    ),
                  ),
                  GestureDetector( 
                    onTap: (){
                      playcache("E");
                    },
                    child: Image(
                      height: imgheight,
                      image: AssetImage("lib/assets/imgs/key5.png"),
                    ),
                  ),
                  GestureDetector( 
                    child: Image(
                      height: imgheight,
                      image: AssetImage("lib/assets/imgs/seperator.png"),
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
                        image: AssetImage("lib/assets/imgs/seperator.png"),
                      ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("F");
                      },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key6.png"),
                      ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("F#");
                      },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key7.png"),
                      ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("G");
                      },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key8.png"),
                      ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("G#");
                      },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key9.png"),
                      ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("A");
                      },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key10.png"),
                      ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("A#");
                      },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key11.png"),
                    ),
                    ),
                    GestureDetector( 
                      onTap: (){
                        playcache("B");
                     },
                      child: Image(
                        height: imgheight,
                        image: AssetImage("lib/assets/imgs/key12.png"),
                      ),
                    ),
                ],
                ),
              )
            ]
            );
           }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Piano", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
          actions: <Widget>[
            GestureDetector(
              child: Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.help, size: 30,)),
              onTap: (){
                showDialog(
                context: context,
                builder: (ctxt) => AlertDialog(
                  title: Text("Help", textAlign: TextAlign.center,),
                  content: Text("Click on a key and hear the note. View the piano in a row in landscape mode."),
                )
              );
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