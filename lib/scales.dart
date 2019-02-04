import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'package:audioplayers/audio_cache.dart';
import 'main.dart';
import 'dart:async';

List<Scale> scales = [    //A A# B C C# D D# E F F# G G#
  Scale("Major", 0, [2, 2, 1, 2, 2, 2]),
  Scale("Minor", 1, [2, 1, 2, 2, 1, 2]),
  Scale("Major Pentatonic", 12, [2, 2, 3, 2]),
  Scale("Minor Pentatonic", 13, [3, 2, 2, 3]),
  Scale("Blues", 2, [3, 2, 1, 1, 3]),
  Scale("Harmonic Minor", 3, [2, 1, 2, 2, 1, 3]),
  Scale("Melodic Minor", 4, [2, 1, 2, 2, 2, 2]),
  Scale("Ionian", 5, [2, 2, 1, 2, 2, 2]),
  Scale("Dorian", 6, [2, 1, 2, 2, 2, 1]),
  Scale("Mixolydian", 7, [2, 2, 1, 2, 2, 1]),
  Scale("Lydian", 8, [2, 2, 2, 1, 2, 2]),
  Scale("Phrygian", 9, [1, 2, 2, 2, 1, 2]), 
  Scale("Aeolian", 10, [2, 1, 2, 2, 1, 2]),
  Scale("Locrian", 11, [1, 2, 2, 1, 2, 2]),
  Scale("Augmented", 14, [3, 1, 3, 1, 3]),
  Scale("Double Harmonic", 15, [1, 3, 1, 2, 1, 3]),
  Scale("Altered", 16, [1, 2, 1, 2, 2, 2]),
  Scale("Dorian b2", 17, [1, 2, 2, 2, 2, 1]),
  Scale("Augmented Lydian", 18, [2, 2, 2, 2, 1, 2]),
  Scale("Lydian b7", 19, [2, 2, 2, 1, 2, 1]),
  Scale("Mixolydian b6", 20, [2, 2, 1, 2, 1, 2])
];

class ScalePrintScreen extends StatefulWidget{
  @override
  _ScalePrintScreen createState() => _ScalePrintScreen();
}

class _ScalePrintScreen extends State<ScalePrintScreen> {
  AudioCache audio = new AudioCache();
  var instrimg;
  @override
    void initState() {
      instrimg = AssetImage('lib/assets/imgs/${instrument.toLowerCase()}.png');
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    List<Note> calculateScale(int mode, int key){
    	List<Note> theScale = [];
      int index = key;
      Scale scaleObj;
      for(int i=0; i<scales.length; i++){
        if(mode == scales[i].index)
          scaleObj = scales[i];
      }
      for(int j=0; j<scaleObj.formula.length+1; j++){
        if(j != 0)
          index += scaleObj.formula[j-1];
        if(index > 11)
          index %= 12;
        theScale.add(notes[index]); 
      }
      return theScale;
    }
    List<Note> myScale;
    myScale = calculateScale(clickedindexscale, clickedindex);
    //print(myScale.length);
    String urlScale(String mode, List<Note> notes, String instr){
      String url;
      String n_or_sharp;
      if(!notes[0].note.contains("#"))
        n_or_sharp = "n";
      else 
        n_or_sharp = "sharp";
     if(mode == "Minor")
        url = "$instr-natural_minor-${notes[0].note[0]}-$n_or_sharp";
      else if(mode == "Harmonic Minor")
        url = "$instr-harmonic_minor-${notes[0].note[0]}-$n_or_sharp";
      else if(mode == "Melodic Minor")
        url = "$instr-melodic_minor-${notes[0].note[0]}-$n_or_sharp";
      else if(mode == "Major Pentatonic")
        url = "$instr-major_pentatonic-${notes[0].note[0]}-$n_or_sharp";
      else if(mode == "Minor Pentatonic")
        url = "$instr-minor_pentatonic-${notes[0].note[0]}-$n_or_sharp";
      else if(mode == "Double Harmonic")
        url = "$instr-double_harmonic-${notes[0].note[0]}-$n_or_sharp";
      else if(mode == "Dorian b2")
        url = "$instr-dorian_b2-${notes[0].note[0]}-$n_or_sharp";
      else if(mode == "Augmented Lydian")
        url = "$instr-augmented_lydian-${notes[0].note[0]}-$n_or_sharp";
      else if(mode == "Lydian b7")
        url = "$instr-lydian_b7-${notes[0].note[0]}-$n_or_sharp";
      else if(mode == "Mixolydian b6")
        url = "$instr-mixolydian_b6-${notes[0].note[0]}-$n_or_sharp";
      else
        url = "$instr-${mode.toLowerCase()}-${notes[0].note[0]}-$n_or_sharp"; 
      return url;
    }
    List<String> nums = ["1", "2", "3", "4", "5", "6", "7"];
    
    void tableNums(String mode){
      if(mode == "Minor"){
        nums[2] = "b3";
        nums[5] = "b6";
        nums[6] = "b7";
      }
      else if(mode == "Blues"){
        nums[1] = "b3";
        nums[2] = "4";
        nums[3] = "#4";
        nums[4] = "5";
        nums[5] = "b7";
      }
      else if(mode == "Melodic Minor")
        nums[2] = "b3";
      else if(mode == "Harmonic Minor"){
        nums[2] = "b3";
        nums[5] = "b6";
      }
      else if(mode == "Dorian"){
        nums[2] = "b3";
        nums[6] = "b7";
      }
      else if(mode == "Mixolydian")
        nums[6] = "b7";
      else if(mode == "Lydian")
        nums[3] = "#4";
      else if(mode == "Phrygian"){
        nums[1] = "b2";
        nums[2] = "b3";
        nums[5] = "b6";
        nums[6] = "b7";
      }
      else if(mode == "Aeolian"){
        nums[2] = "b3";
        nums[5] = "b6";
        nums[6] = "b7";
      }
      else if(mode == "Locrian"){
        nums[1] = "b2";
        nums[2] = "b3";
        nums[4] = "b5";
        nums[5] = "b6";
        nums[6] = "b7";
      }
      else if(mode == "Major Pentatonic"){
        nums[3] = "5";
        nums[4] = "6";  
      }
      else if(mode == "Minor Pentatonic"){
        nums[1] = "b3";
        nums[2] = "4";
        nums[3] = "5";
        nums[4] = "b7";
      }
      else if(mode == "Augmented"){
        nums[1] = "b3";
        nums[3] = "5";
        nums[4] = "#5";
        nums[5] = "7";
      }
      else if(mode == "Double Harmonic"){
        nums[1] = "b2";
        nums[5] = "b6";
      }
      else if(mode == "Altered"){
        nums[1] = "b2";
        nums[2] = "b3";
        nums[3] = "b4";
        nums[4] = "b5";
        nums[5] = "b6";
        nums[6] = "b7";
      }
      else if(mode == "Dorian b2"){
        nums[1] = "b2";
        nums[2] = "b3";
        nums[6] = "b7";
      }
      else if(mode == "Augmented Lydian"){
        nums[3] = "#4";
        nums[4] = "#5";
      }
      else if(mode == "Lydian b7"){
        nums[3] = "#4";
        nums[6] = "b7";
      }
      else if(mode == "Mixolydian b6"){
        nums[5] = "b6";
        nums[6] = "b7";
      }
    }

    tableNums(clickednotescale);


    Future<void> play(String note) async{
      if(instrument == "Piano")
        await audio.play("notes/${instrument.toLowerCase()}/${note.replaceAll("#", "s")}.mp3", volume: 0.6);
      else
        await audio.play("notes/${instrument.toLowerCase()}/${note.replaceAll("#", "s")}.mp3");
      }

    TableCell noteCell(String note){
      return TableCell(
        child: GestureDetector(
          onTap: (){
            play("$note");
          },
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(200, 80, 80, 0.15)),
              child:  Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.6, 0, textSize * 0.65), child: Center(child: Text("$note", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
            ),
        ),
      );
    }

    Column scaletable(String mode){
      if(mode == "Blues" || mode == "Augmented"){
        return Column(children: <Widget>[            
            Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.35, 28, 56 - textSize * 0.35, 18), child: Table(
              border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
              children: <TableRow>[
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[0]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.75)),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[1]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[2]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                  ],
                ),
                TableRow(
                  children: <TableCell>[
                   noteCell(myScale[0].note),
                   noteCell(myScale[1].note),
                   noteCell(myScale[2].note),
                  ],
                ),
                ],
            ),),
            Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.35, 0, 56 - textSize * 0.35, 10), child: Table(
              border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
              children: <TableRow>[
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[3]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[4]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[5]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                  ],
                ),
                TableRow(
                  children: <TableCell>[
                   noteCell(myScale[3].note),
                   noteCell(myScale[4].note),
                   noteCell(myScale[5].note),
                  ],
                ),
                ],
            ),
            ),
        ]);
      }
      else if(mode == "Major Pentatonic" || mode == "Minor Pentatonic"){
        return Column(children: <Widget>[            
            Padding(padding: EdgeInsets.fromLTRB(56 - textSize * 0.35, 28, 56 - textSize * 0.35, 18), child: Table(
              border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
              children: <TableRow>[
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[0]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.75)),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[1]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[2]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                  ],
                ),
                TableRow(
                  children: <TableCell>[
                   noteCell(myScale[0].note),
                   noteCell(myScale[1].note),
                   noteCell(myScale[2].note),
                  ],
                ),
                ],
            ),),
            Padding(padding: EdgeInsets.fromLTRB(92 - textSize * 0.35, 0, 92 - textSize * 0.35, 10), child: Table(
              border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
              children: <TableRow>[
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[3]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[4]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                  ],
                ),
                TableRow(
                  children: <TableCell>[
                   noteCell(myScale[3].note),
                   noteCell(myScale[4].note),
                  ],
                ),
                ],
            ),
            ),
        ]);
      }
      else{
        return Column(children: <Widget>[            
            Padding(padding: EdgeInsets.fromLTRB(56 - textSize, 28, 56-textSize, 18), child: Table(
              border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
              children: <TableRow>[
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center( child: Text("${nums[0]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.75)),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[1]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[2]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[3]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                  ],
                ),
                TableRow(
                  children: <TableCell>[
                    noteCell(myScale[0].note),
                    noteCell(myScale[1].note),
                    noteCell(myScale[2].note),
                    noteCell(myScale[3].note),
                    ],
                ),
                ],
            ),),
            Padding(padding: EdgeInsets.fromLTRB(72 - textSize * 0.35, 0, 72 - textSize * 0.35, 10), child: Table(
              border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
              children: <TableRow>[
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[4]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[5]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[6]}", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                  ],
                ),
                TableRow(
                  children: <TableCell>[
                    noteCell(myScale[4].note),
                    noteCell(myScale[5].note),
                    noteCell(myScale[6].note),
                  ],
                ),
                ],
            ),
            ),
        ],
        );
      }
    }

    Axis scrollaxis;
    if(instrument == "Guitar")
      scrollaxis = Axis.horizontal;
    else 
      scrollaxis = Axis.vertical;

    var scaleimg = (instrument == "Guitar") ? TransitionToImage(
        AdvancedNetworkImage("https://www.scales-chords.com/music-scales/${urlScale(clickednotescale, myScale, instrument.toLowerCase())}.jpg", useDiskCache: true),
        loadingWidget: Padding(padding: EdgeInsets.all(6), child: CircularProgressIndicator(strokeWidth: 3, backgroundColor: Colors.orangeAccent,)),
        placeholder: Column(children: <Widget>[
                    Padding( 
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 6),
                      child:Text("No Internet Connection!", style: TextStyle(color: Color.fromRGBO(50, 50, 50, 0.6), fontSize: 20),),
                    ),
                    Icon(Icons.error, color: Colors.red),
                  ],
                ),
        height: 100,
        alignment: Alignment(-1, -1),
        fit: BoxFit.fitHeight,
      ) : TransitionToImage(
        AdvancedNetworkImage("https://www.scales-chords.com/music-scales/${urlScale(clickednotescale, myScale, instrument.toLowerCase())}.jpg", useDiskCache: true),
        loadingWidget: Padding(padding: EdgeInsets.all(6), child: CircularProgressIndicator(strokeWidth: 3, backgroundColor: Colors.orangeAccent,)),
        placeholder: Column(children: <Widget>[
                    Padding( 
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 6),
                      child:Text("No Internet Connection!", style: TextStyle(color: Color.fromRGBO(50, 50, 50, 0.6), fontSize: 20),),
                    ),
                    Icon(Icons.error, color: Colors.red),
                  ],
                ),
      );

    Future<void> refimg() async{
      await Future.delayed(new Duration(seconds: 2));
      setState(() {
        scaleimg.reloadImage();                      
        });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("$clickednote $clickednotescale", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
        elevation: 1,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              setState(() {
                  if(instrument == "Guitar")
                    instrument = "Piano";
                  else if(instrument == "Piano")
                    instrument = "Guitar";
                  instrimg = AssetImage('lib/assets/imgs/${instrument.toLowerCase()}.png');
                });
            },
            child: Padding(padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: Image(
                color: Colors.black,
                image: instrimg,
                ),
              ),
            ),
            GestureDetector(
              child: Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.help, size: 30,)),
              onTap: (){
                showDialog(
                context: context,
                builder: (ctxt) => AlertDialog(
                  title: Text("Help", textAlign: TextAlign.center,),
                  content: Text("Click and select a scale from the menu. Press the button next to the question mark to change the instrument. Click on the red tiles to hear the individual notes with the selected instrument. While viewing the guitar scale, slide the scale to the right to see the remaining scale."),
                )
                );
              },
            )
          ],
      ),
      //bottomNavigationBar: Container(height: adpadding,),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: refimg,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Scale:   ", style: TextStyle(fontSize: 26, fontStyle: FontStyle.italic),),
                        DropdownButton(
                          hint: Text(clickednotescale, style: TextStyle(fontSize: 24, color: Colors.deepPurple),),
                          items: scales.map((Scale value){
                            return DropdownMenuItem<Scale>(
                              child: Text("${value.name}", style: TextStyle(fontSize: 18),),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (Scale newvalue){
                            setState(() {
                            clickednotescale = newvalue.name;
                            clickedindexscale = newvalue.index; 
                            });
                          },
                        ),
                      ],
                      ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(2, 6, 2, 0), child: Divider(height: 0, color: Colors.black54,)),
                  Padding(
                  padding: EdgeInsets.fromLTRB(6, 16, 6, 0), 
                  child: SingleChildScrollView(
                    child: scaleimg,
                    scrollDirection: scrollaxis,
                    ),
                  ),
                  scaletable(clickednotescale),
                //Text('$clickednotescale ${myScale[0].note}  ${urlScale(clickednotescale, myScale[0].note, instrument.toLowerCase())}'),
              ],
              ),  
            ),
          ),
        ),
      ),
    );
  }
}