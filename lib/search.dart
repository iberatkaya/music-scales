import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'scales.dart';

class SearchScreen extends StatefulWidget{
  @override
  _SearchScreen createState() => _SearchScreen();
}

List<Note> searchNotes = [
  Note("A", 0),
  Note("A#", 1),
  Note("B", 2),
  Note("C", 3),
  Note("C#", 4),
  Note("D", 5),
  Note("D#", 6),
  Note("E", 7),
  Note("F", 8),
  Note("F#", 9),
  Note("G", 10),
  Note("G#", 11),
];

List<Scale> searchScales = [    //A A# B C C# D D# E F F# G G#
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
  Scale("Mixolydian b6", 20, [2, 2, 1, 2, 1, 2]),
  Scale("Locrian 6", 21, [1, 2, 2, 1, 3, 1]),
  Scale("Augmented Ionian", 22, [2, 2, 1, 3, 1, 2]),
  Scale("Dorian #4", 23, [2, 1, 3, 1, 2, 1]),
  Scale("Major Phrygian", 24, [1, 3, 1, 2, 1, 2]), 
  Scale("Lydian #9", 25, [3, 1, 2, 1, 2, 2]), 
  Scale("Diminished Lydian", 26, [2, 1, 3, 1, 2, 2]),
  Scale("Minor Lydian", 27, [2, 2, 2, 1, 1, 2]),
  Scale("Arabian", 28, [2, 2, 1, 1, 2, 2]),
  Scale("Balinese", 29, [1, 2, 3, 2]),
  Scale("Byzantine", 30, [1, 3, 1, 2, 1, 3]),
  Scale("Chinese", 31, [4, 2, 1, 4]),
  Scale("Egyptian", 32, [2, 3, 2, 3]),
  Scale("Mongolian", 33, [2, 2, 3, 2]),
  Scale("Hindu", 34, [2, 2, 1, 2, 1, 2])
];

class ScaleandKey{
  String note;
  String scale;
  int index;
  ScaleandKey(this.note, this.scale, this.index);
}

var allScales;

class _SearchScreen extends State<SearchScreen> {

  final myController = TextEditingController();
  String searchText = "";



  List<int> noteindexs = [];
  List<int> scaleindexs = [];
  void scaleSearcher(List<String> mynotes){
    noteindexs = [];
    scaleindexs = [];
    int ctr;
    for(int i=0; i<12; i++){
      //  print(searchNotes[i].note);
      for(int j=0; j<35; j++){
        ctr = 0;
        for(int k=0; k<searchScales[j].formula.length+1; k++){
          for(int l=0; l<mynotes.length; l++){
            if(mynotes[l] == allScales[i][j][k].note){
              ctr++;
            }
          }
        }
        //print(ctr);
        if(ctr == mynotes.length){
          noteindexs.add(i);
          scaleindexs.add(j);
        }
      }
    }
  }

  List<String> bToSharp(List<String> thenotes){
    String temp;
    int tempcharcode;
    String tempfinal;
    List<String> temptoreturn = [];
    for(int i=0; i<thenotes.length; i++){
      tempfinal = thenotes[i];
      if(thenotes[i].length == 2){
        if(thenotes[i][1] == "b"){
          tempcharcode = thenotes[i].codeUnitAt(0) - 1;
          if(tempcharcode == 64)
            tempcharcode = 71;
          temp = String.fromCharCode(tempcharcode);
          tempfinal = "$temp#";
        }
      }
      print(tempfinal);
      temptoreturn.add(tempfinal);
    }
    return temptoreturn;
  }


  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search in a Scale", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
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
                      content: Text("Write the notes in the search bar. Use '#' for sharp notes and 'b' for flat notes. Click the scale to view it."),
                    )
                    );
                  },
                ),
          ),
        ],
      ),
      //bottomNavigationBar: Container(height: adpadding,),
      backgroundColor: Colors.white,
      body: Center(child: Column(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(255, 195, 195, 0.5),
              padding: EdgeInsets.only(bottom: 20, top: 2),
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
                        icon: Icon(Icons.music_note, color: Colors.orange[600])
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                      textCapitalization: TextCapitalization.words,
                      onSubmitted: (text){
                        setState(() {
                          searchText = text;
                          scaleSearcher(bToSharp(text.split(" ")));
                        });
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 30),)
                ],
              ),
            ),
            Divider(height: 0, color: Colors.black,),
            Container(
              child: Expanded(
                child: ListView.separated(
                  itemCount: noteindexs.length,
                  separatorBuilder: (BuildContext context, int index){
                    return Divider(height: 0, color: Colors.black26,);
                  },
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      title:Container( 
                        child: Text("${searchNotes[noteindexs[index]].note} ${searchScales[scaleindexs[index]].name}", style: TextStyle(fontSize: 23),),
                        padding: EdgeInsets.fromLTRB(4, 20, 0, 22),
                      ),
                      onTap: (){
                        clickednote = searchNotes[noteindexs[index]].note;
                        clickedindex = searchNotes[noteindexs[index]].index;
                        clickednotescale = searchScales[scaleindexs[index]].name;
                        clickedindexscale = searchScales[scaleindexs[index]].index;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ScalePrintScreen()));
                      },
                    );
                  },
                ),
              )
            )
            ],
          )
      ),
      
    );
  }
}