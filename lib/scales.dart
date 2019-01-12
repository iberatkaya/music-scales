import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'main.dart';

void main() => runApp(ScaleScreen());

class ScaleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Scale> scales = [
      Scale("Major", 0),
      Scale("Minor", 1),
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
  //             Text("$clickedindex $clickednote"),
              Flexible(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(10.0),
                  itemCount: scales.length,
                  separatorBuilder:(BuildContext context, int index) => Divider(height: 4, color: Color.fromRGBO(0, 0, 200, 0.2),),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(4, -12 + textSize * 0.85, 0, -12 + textSize * 0.90),
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



class ScalePrintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> calculateScale(var mode, var key){
    	List<String> theScale = [];
      var index = key;
	    for(int i=0; i<7; i++){
	    	if((i == 2 || i == 5) && mode == 1)
		    	index--;
		    else if(mode == 0 && i == 3)
			    index--;
		    if(index > 11)
			    index %= 12;
	    	theScale.add(notes[index].note);
        index += 2;
	    	}
      return theScale;
      }
    List<String> myScale;
    myScale = calculateScale(clickedindexscale, clickedindex);
    
    String urlScale(String mode, String notes, String instr){
      String url;
      if(!notes.contains("#")){
        if(mode == "Major")
          url = "$instr-${mode.toLowerCase()}-${notes[0]}-n";
        else if(mode == "Minor")
          url = "$instr-natural_minor-${notes[0]}-n";
          }
      else{
        if(mode == "Major")
          url = "$instr-${mode.toLowerCase()}-${notes[0]}-sharp";
        else if(mode == "Minor")
          url = "$instr-natural_minor-${notes[0]}-sharp";        
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
    }

    tableNums(clickednotescale);
    return Scaffold(
      appBar: AppBar(
        title: Text("The $clickednote $clickednotescale Scale", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
              padding: EdgeInsets.fromLTRB(22, 20, 22, 0), 
              child: CachedNetworkImage(
                imageUrl:'https://www.scales-chords.com/music-scales/${urlScale(clickednotescale, myScale[0], "piano")}.jpg',
                placeholder: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.orangeAccent,
                ),
                errorWidget: Column(children: <Widget>[
                    Padding( 
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 6),
                      child:Text("No Internet Connection!", style: TextStyle(color: Color.fromRGBO(50, 50, 50, 0.6), fontSize: 20),),
                    ),
                    Icon(Icons.error, color: Colors.red),
                  ],
                ),
                ),
              ),
            //Text('$clickednotescale ${myScale[0]}  ${urlScale(clickednotescale, myScale[0], "piano")}'),
            Padding(padding: EdgeInsets.fromLTRB(56 - textSize, 28, 56-textSize, 18), child: Table(
              border: TableBorder.all(width: 1.5, color: Color.fromRGBO(20, 0, 160, 0.2)),
              children: <TableRow>[
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("${nums[0]}", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
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
        ),
        ),
      ),
    );
  }
}