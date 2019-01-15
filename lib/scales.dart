import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'main.dart';

void main() => runApp(ScaleScreen());

class ScaleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Scale> scales = [
      Scale("Major", 0),
      Scale("Minor", 1),
      Scale("Blues", 2),
      Scale("Harmonic Minor", 3),
      Scale("Melodic Minor", 4),
    ];
    return ListTileTheme(
      iconColor: Colors.red,
      child:
      Scaffold(
        appBar: AppBar(
          title: Text("Choose a Scale For $clickednote", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: scales.length,
                  separatorBuilder:(BuildContext context, int index) => Divider(height: 0, color: Color.fromRGBO(0, 0, 200, 0.2),),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(18, -8 + textSize * 0.85, 0, -8 + textSize * 0.90),
                      dense: true,
                      onTap:() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ScalePrintScreen()));
                        clickedindexscale = scales[index].index;
                        clickednotescale = scales[index].name;
                      },
                      title: Text(scales[index].name ?? 'broke', style: TextStyle(fontSize: textSize)),
                      leading: Icon(FontAwesomeIcons.itunesNote),
                    );
                },
              )
              ),
            ],
        ),
        ),
      )
    );
  }
}


class ScalePrintScreen extends StatefulWidget{
  @override
  _ScalePrintScreen createState() => _ScalePrintScreen();
}

class _ScalePrintScreen extends State<ScalePrintScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> calculateScale(var mode, var key){
    	List<String> theScale = [];
      var index = key;
      if(mode == 0 || mode == 1 || mode == 3 || mode == 4){ //A A# B C C# D D# E F F# G G#
        for(int i=0; i<7; i++){   //Major Minor Melodic Harmonic
          if((i == 2 || i == 5) && (mode == 1 || mode == 3 || mode == 4))
            index--;
          else if(mode == 0 && i == 3)
            index--;
          if(mode == 4 && i == 5)   //Melodic
            index++;
          if(mode == 3 && i == 6)   //Harmonic
            index++;
          if(index > 11)
            index %= 12;
          theScale.add(notes[index].note);
          index += 2;
          }
      }
      else if(mode == 2){   //Blues
        for(int i=0; i<7; i++){     
          if(i == 1)                          
            index++;
          if(i == 3)
            index--;
          if(i == 4)
            index--;
          if(i == 5)
            index++;
          if(index > 11)
            index %= 12;
          theScale.add(notes[index].note);
          index += 2;
        }
      }
      return theScale;
      }
    List<String> myScale;
    myScale = calculateScale(clickedindexscale, clickedindex);
    
    String urlScale(String mode, String notes, String instr){
      String url;
      if(!notes.contains("#")){
        if(mode == "Major" || mode == "Blues")
          url = "$instr-${mode.toLowerCase()}-${notes[0]}-n";
        else if(mode == "Minor")
          url = "$instr-natural_minor-${notes[0]}-n";
        else if(mode == "Harmonic Minor")
          url = "$instr-harmonic_minor-${notes[0]}-n";
        else if(mode == "Melodic Minor")
          url = "$instr-melodic_minor-${notes[0]}-n";
          }
      else{
        if(mode == "Major" || mode == "Blues")
          url = "$instr-${mode.toLowerCase()}-${notes[0]}-sharp";
        else if(mode == "Minor")
          url = "$instr-natural_minor-${notes[0]}-sharp";        
        else if(mode == "Harmonic Minor")
          url = "$instr-harmonic_minor-${notes[0]}-sharp";        
        else if(mode == "Melodic Minor")
          url = "$instr-melodic_minor-${notes[0]}-sharp";        
      }
      return url;
    }
    List<String> nums = ["1", "2", "3", "4", "5", "6", "7"];
    
    void tableNums(String mode){
      if(mode == "Minor"){
        nums[2] = "b3";
        nums[5] = "b6";
        nums[6] = "b7";
      }
      if(mode == "Blues"){
        nums[1] = "b3";
        nums[2] = "4";
        nums[3] = "#4";
        nums[4] = "5";
        nums[5] = "b7";
      }
      if(mode == "Melodic Minor")
        nums[2] = "b3";
      if(mode == "Harmonic Minor"){
        nums[2] = "b3";
        nums[5] = "b6";
      }
    }

    tableNums(clickednotescale);

    Column scaletable(String mode){
      if(!(mode == "Blues")){
        return Column(children: <Widget>[            
            Padding(padding: EdgeInsets.fromLTRB(56 - textSize, 28, 56-textSize, 18), child: Table(
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
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[3]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                    ),
                  ],
                ),
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[0]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[1]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[2]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[3]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                    ),
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
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[4]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[5]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[6]}", style: TextStyle(fontSize: textSize * 1.1 , color: Colors.red),))),
                    ),
                  ],
                ),
                ],
            ),
            ),
        ],
        );
      }
      else if(mode == "Blues"){
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
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[0]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[1]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[2]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                    ),
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
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[3]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[4]}", style: TextStyle(fontSize: textSize * 1.1, color: Colors.red),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${myScale[5]}", style: TextStyle(fontSize: textSize * 1.1 , color: Colors.red),))),
                    ),
                  ],
                ),
                ],
            ),
            ),
        ]);
      }
    }

    var scaleimg = (instrument == "Guitar") ? TransitionToImage(
        AdvancedNetworkImage("https://www.scales-chords.com/music-scales/${urlScale(clickednotescale, myScale[0], instrument.toLowerCase())}.jpg", useDiskCache: true),
        loadingWidget: CircularProgressIndicator(strokeWidth: 3, backgroundColor: Colors.orangeAccent,),
        placeholder: Column(children: <Widget>[
                    Padding( 
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 6),
                      child:Text("No Internet Connection!", style: TextStyle(color: Color.fromRGBO(50, 50, 50, 0.6), fontSize: 20),),
                    ),
                    Icon(Icons.error, color: Colors.red),
                  ],
                ),
        height: 90,
        alignment: Alignment(-1, -1),
        fit: BoxFit.fitHeight,
      ) : TransitionToImage(
        AdvancedNetworkImage("https://www.scales-chords.com/music-scales/${urlScale(clickednotescale, myScale[0], instrument.toLowerCase())}.jpg", useDiskCache: true),
        loadingWidget: CircularProgressIndicator(strokeWidth: 3, backgroundColor: Colors.orangeAccent,),
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
        title: Text("$clickednote $clickednotescale Scale", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: refimg,
        child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 0), 
              child: scaleimg,
              ),
              scaletable(clickednotescale),
            //Text('$clickednotescale ${myScale[0]}  ${urlScale(clickednotescale, myScale[0], instrument.toLowerCase())}'),
          ],
          ),  
        ),
      ),
      ),
    );
  }
}