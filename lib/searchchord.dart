import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class SearchChordScreen extends StatefulWidget{
  @override
  _SearchChordScreen createState() => _SearchChordScreen();
}

List<Note> searchNotesC = [
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


List<Chord> searchChords = [    //A A# B C C# D D# E F F# G G# 
  Chord("Major", 0, [4, 3]),
  Chord("Minor", 1, [3, 4]),
  Chord("Sus2", 3, [2, 5]),
  Chord("Sus4", 4, [5, 2]),
  Chord("Diminished", 7, [3, 3]),
  Chord("Augmented", 8, [4, 4]),
  Chord("7th", 6, [4, 3, 3]),
  Chord("Major 7th", 2, [4, 3, 4]),
  Chord("Minor 7th", 5, [3, 4, 3]),
  Chord("m(maj7)", 27, [3, 4, 4]),
  Chord("m7b5", 13, [3, 3, 4]), 
  Chord("m7#5", 21, [3, 5, 2]),
  Chord("7b5", 15, [4, 2, 4]),
  Chord("7#5", 16, [4, 4, 2]),
  Chord("Diminished 7th", 14, [3, 3, 3]),
  Chord("Add2", 30, [2, 2, 3]),
  Chord("Add4", 31, [4, 1, 2]),
  Chord("6th", 10, [4, 3, 2]),
  Chord("Minor 6th", 11, [3, 4, 2]), 
  Chord("6th/9th", 12, [4, 3, 2, 5]),
  Chord("9th", 9, [4, 3, 3, 4]),  
  Chord("Major 9th", 18, [4, 3, 4, 3]),   //A A# B C C# D D# E F F# G G# 
  Chord("Minor 9th", 17, [3, 4, 3, 4]), 
  Chord("m(maj9)", 28, [3, 4, 4, 3]),
  Chord("9b5", 20, [4, 2, 4, 4]),
  Chord("9#5", 19, [4, 4, 2, 4]),
  Chord("11th", 22, [4, 3, 3, 4, 3]),
  Chord("Major 11th", 23, [4, 3, 4, 3, 3]),
  Chord("Minor 11th", 24, [3, 4, 3, 4, 3]),
  Chord("m(maj11)", 29, [3, 4, 4, 3, 3]),
  Chord("11b5", 25, [4, 2, 4, 4, 3]),
  Chord("11#5", 26, [4, 4, 2, 4, 3])  //Continue from 32
];

var allChords;

class _SearchChordScreen extends State<SearchChordScreen> {

  final myController = TextEditingController();
  String searchText = "";
  List<Note> calculateChord(int mode, int key){
    List<Note> theChord = [];
    int index = key;
    Chord chordObj;
    for(int i=0; i<searchChords.length; i++){
      if(mode == searchChords[i].index)
        chordObj = searchChords[i];
    }
    for(int j=0; j<chordObj.formula.length+1; j++){
      if(j != 0)
        index += chordObj.formula[j-1];
      if(index > 11)
        index %= 12;
      theChord.add(searchNotesC[index]); 
    }
    return theChord;
  }

  
  List<int> noteindexs = [];
  List<int> scaleindexs = [];
  void chordSearcher(List<String> mynotes){   //When adding new scales, change the j number of iteration; and from main.dart, add the new indexs to allScales and change j 
    noteindexs = [];
    scaleindexs = [];
    int ctr;
    for(int i=0; i<12; i++){
      //  print(searchNotesC[i].note);
      for(int j=0; j<32; j++){
        ctr = 0;
        for(int k=0; k<searchChords[j].formula.length+1; k++){
          for(int l=0; l<mynotes.length; l++){
            if(mynotes[l] == allChords[i][j][k].note){
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

  
  Text scaleNotesText(List<Note> mynotes){
    if(mynotes.length == 3){
      return Text("${mynotes[0].note} ${mynotes[1].note} ${mynotes[2].note}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),);
    }
    else if(mynotes.length == 4){
      return Text("${mynotes[0].note} ${mynotes[1].note} ${mynotes[2].note} ${mynotes[3].note}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),);
    }
    else if(mynotes.length == 5){
      return Text("${mynotes[0].note} ${mynotes[1].note} ${mynotes[2].note} ${mynotes[3].note} ${mynotes[4].note}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),);
    }
    else if(mynotes.length == 6){
      return Text("${mynotes[0].note} ${mynotes[1].note} ${mynotes[2].note} ${mynotes[3].note} ${mynotes[4].note} ${mynotes[5].note}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),);
    }
    else if(mynotes.length == 7){
      return Text("${mynotes[0].note} ${mynotes[1].note} ${mynotes[2].note} ${mynotes[3].note} ${mynotes[4].note} ${mynotes[5].note} ${mynotes[6].note}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),);
    }
  }


  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,  //Fixes keyboard overflow issue
      appBar: AppBar(
        title: Text("Search in a Chord", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
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
                      content: Text("Write the notes in the search bar. Use '#' for sharp notes and 'b' for flat notes."),    // Click the scale to view it. (Buggy)
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
                        icon: Icon(Icons.music_note, color: Colors.orange[600])
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                      textCapitalization: TextCapitalization.words,
                      onSubmitted: (text){
                        setState(() {
                          searchText = text;
                          chordSearcher(bToSharp(text.split(" ")));
                        });
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 30),)
                ],
              ),
            ),
            Divider(height: 0, color: Colors.black26,),
            Container(
              child: Expanded(
                child: ListView.separated(
                  itemCount: noteindexs.length,
                  separatorBuilder: (BuildContext context, int index){
                    return Divider(height: 0, color: Colors.black26,);
                  },
                  itemBuilder: (BuildContext context, int index){
                    List<List<Note>> scaleNotes = [];
                    for(int j=0; j<noteindexs.length; j++){
                      scaleNotes.add(calculateChord(searchChords[scaleindexs[index]].index, searchNotesC[noteindexs[index]].index));
                    }
                    return ListTile(
                      title:Container( 
                        padding: EdgeInsets.fromLTRB(0, 6, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${searchNotesC[noteindexs[index]].note} ${searchChords[scaleindexs[index]].note}", style: TextStyle(fontSize: 26),),
                            Padding(padding: EdgeInsets.only(bottom: 6),),
                            scaleNotesText(scaleNotes[index]),
                          ],
                        ),
                      ),
                      /*onTap: (){                  //Causes a bug
                        clickednote = searchNotesC[noteindexs[index]].note;
                        clickedindex = searchNotesC[noteindexs[index]].index;
                        clickednotescale = searchChords[scaleindexs[index]].name;
                        clickedindexscale = searchChords[scaleindexs[index]].index;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ScalePrintScreen()));
                      },*/
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