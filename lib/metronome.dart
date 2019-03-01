import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'main.dart';

class MetronomeScreen extends StatefulWidget{
  @override
  _MetronomeScreen createState() => _MetronomeScreen();
}

class _MetronomeScreen extends State<MetronomeScreen> {
  AudioCache audio = new AudioCache();
  double bpm;
  String audiostr;
  int ctr;
  bool playbool;
  Timer t;
  Duration bpmdur;
  Icon myplay;
  EdgeInsets playpadding;

  @override
  void initState() {
    bpm = 120;
    ctr = 0;
    playbool = false;
    bpmdur = Duration(milliseconds: ((60 / bpm) * 1000).toInt());
    myplay = Icon(FontAwesomeIcons.play, color: Colors.black87);
    playpadding = EdgeInsets.only(left: 6);
    audiostr = "hat1";
    super.initState();
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    audio.loadAll(["hats/hat1.mp3", "hats/hat2.mp3"]);

    Future<void> play(String hat) async{
      await audio.play("hats/$hat.mp3");
      }


    t = Timer.periodic(bpmdur, (Timer t){
      print(ctr);
      if(ctr % 4 == 0){
        audiostr = "hat1";
        ctr = 0;
      }
      else
        audiostr = "hat2";
      if(playbool){
        play(audiostr);
        ctr++;
      }
      setState(() {
        t.cancel();   //Prevents multiple audio files from loading, also used to update beat counter to view
      });
    });
    
    Future<bool> stopTimer(){
      t.cancel();
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Metronome", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
        elevation: 1,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
                  child: Icon(Icons.help, size: 30,),
                  onTap: (){
                    showDialog(
                    context: context,
                    builder: (ctxt) => AlertDialog(
                      title: Text("Help", textAlign: TextAlign.center,),
                      content: Text("Select the bpm by sliding the bar or clicking the - or + buttons. Click the play button to play."),
                    )
                    );
                  },
                ),
          ),
        ]
      ),
      //bottomNavigationBar: Container(height: adpadding,),
      backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: stopTimer,
          child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 18, bottom: 8),
                  child: Column(
                    children: <Widget>[Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.music_note, size: 26, color: Colors.red[400],),
                          Text(" Beats Per Minute", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 2),),
                      Text("${bpm.toInt()}", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                Divider(height: 0, color: Colors.black26,),
                Padding(padding: EdgeInsets.only(top: 6, bottom: 12),
                  child: Column(
                    children: <Widget>[
                      Text("$ctr", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600)),
                      Text("Beat Counter", style: TextStyle(fontSize: 21, color: Colors.grey[600], fontWeight: FontWeight.w300)),
                    ]
                  ),
                ),
                Divider(height: 0, color: Colors.black26,),
                Container(
                    padding: EdgeInsets.fromLTRB(4, 18, 4, 0),
                    child: Column(
                      children: <Widget>[
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                            FlatButton(
                              padding: EdgeInsets.all(12),
                              shape: CircleBorder(),
                              color: Colors.orange[300],
                              child: Icon(Icons.remove),
                              onPressed: (){
                                setState(() {
                                  if(bpm > 10){
                                    bpm--; 
                                    bpmdur = Duration(milliseconds: ((60 / bpm) * 1000).toInt());
                                    ctr = 0;
                                    t.cancel();
                                  }
                                });
                              },
                            ),
                            Expanded(
                              child: Container(
                                child: Slider(
                                  value: bpm,
                                  divisions: 201,
                                  min: 10,
                                  max: 220,
                                  activeColor: Colors.orange,
                                  inactiveColor: Colors.orange[100],
                                  onChanged: (double newval){
                                    setState(() {
                                      bpm = newval; 
                                      bpmdur = Duration(milliseconds: ((60 / bpm) * 1000).toInt());
                                      ctr = 0;
                                      t.cancel();
                                    });
                                  },
                                  label: "${bpm.toInt()}",
                                ),
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.all(12),
                              shape: CircleBorder(),
                              child: Icon(Icons.add),
                              color: Colors.orange[300],
                              onPressed: (){
                                setState(() {
                                  if(bpm < 220){
                                    bpm++; 
                                    bpmdur = Duration(milliseconds: ((60 / bpm) * 1000).toInt());
                                    ctr = 0;
                                    t.cancel();
                                  }
                                });
                              },
                            ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 8, bottom: 8), 
                            child: FlatButton( 
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                              child: Padding(padding: playpadding, child: myplay),
                              color: Color.fromRGBO(240, 50, 50, 0.9),
                              onPressed: (){
                                playbool = !playbool;
                                setState(() {
                                  if(playbool){
                                    myplay = Icon(FontAwesomeIcons.pause);
                                    playpadding = EdgeInsets.only(left: 0);
                                    t.cancel();
                                  }
                                  else{
                                    myplay = Icon(FontAwesomeIcons.play);  
                                    playpadding = EdgeInsets.only(left: 6);
                                    t.cancel();
                                  }
                                  ctr = 0;
                                });
                              },
                            ),
                          )
                      ],
                    ),
                  )
                ],
              )
          ),
        ),
        ),
    );
  }
}