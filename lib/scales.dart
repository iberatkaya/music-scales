import 'package:flutter/material.dart';
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
                      leading: Icon(Icons.music_note),
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
		    else if(mode == 0 && (i == 3 || i == 7))
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
    
    return Scaffold(
      appBar: AppBar(
        title: Text("The $clickednote $clickednotescale Scale", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            /*Container(
              margin: EdgeInsets.fromLTRB(5, 35, 5, 0),
              child: Text(calculateScale(clickedindexscale, clickedindex), textAlign: TextAlign.center, style: TextStyle(fontSize: 20 + textSize * 1.15, color: Colors.red),),
           ),*/
           Padding(padding: EdgeInsets.fromLTRB(56 - textSize, 28, 56-textSize, 18), child: Table(
             border: TableBorder.all(width: 2, color: Color.fromRGBO(150, 0, 40, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("1", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("2", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("3", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("4", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
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
           Padding(padding: EdgeInsets.fromLTRB(72 - textSize * 0.35, 0, 72 - textSize * 0.35, 0), child: Table(
             border: TableBorder.all(width: 2, color: Color.fromRGBO(150, 0, 40, 0.2)),
             children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("5", style: TextStyle(fontSize: textSize * 0.85, color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("6", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text("7", style: TextStyle(fontSize: textSize * 0.85,  color: Color.fromRGBO(20, 20, 20, 0.55)),))),
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
    );
  }
}