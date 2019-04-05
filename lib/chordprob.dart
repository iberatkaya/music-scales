import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

String apimode;
int chordnum = 1;
int paramlength;
String globalurl;
String globalappbarprog = "";

class Post {
  final String chord_ID;
  final String chord_HTML;
  final double probability;
  final String child_path;

  Post({this.chord_ID, this.chord_HTML, this.probability, this.child_path});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      chord_ID: json['chord_ID'],
      chord_HTML: json['chord_HTML'],
      probability: json['probability'],
      child_path: json['child_path'],
    );
  }
}



class ChordProbScreen extends StatefulWidget{
  @override
  _ChordProbScreen createState() =>_ChordProbScreen();
}

class _ChordProbScreen extends State<ChordProbScreen>{


  Future<List<Post>> fetchPost(String mode, List<dynamic> chords) async {
    String url = "";
    for(int i=0; i<paramlength; i++){
      print(chords[i]);
      if(i == paramlength-1)
        url += chords[i];
      else
        url += chords[i] + ",";
    }
    globalurl = url;
    print("url is " + url);
    print("url is https://api.hooktheory.com/v1/trends/${mode}?cp=${url}");
    final response = await http.get(
      'https://api.hooktheory.com/v1/trends/${mode}?cp=${url}',
      headers: {"Authorization": "Bearer 6eed7f57c99b5ea87b4ec3941a3585d5"},
    );
    final responseJson = json.decode(response.body);

    List<Post> mypost = [];
    for(int i=0; i<9; i++) 
      mypost.add(Post.fromJson(responseJson[i]));
    return mypost;
  }

  var buttonitems = [["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"]];
  var param;
  var buttonhint;
  @override
  void initState(){
    chordnum = 1;
    param = ["1", "2", "3"];
    paramlength = 1;
    buttonhint = ["1", "2", "3"];
    super.initState();
  }

  String htmltostr(String html){
    String str = "";
    String temp = "";
    for(int i=0; i<html.length; i++){
      if(html[i] == "<"){
        while(html[i] != ">")
          i++;  
      }
      else if(html[i] == "&"){
        while(html[i] != ";"){
          temp += html[i];
          i++;
        }
        if(temp == "&#9837")
          str += "b";
        print(temp);
        temp = "";
        print(temp);
      }
      else{
        str += html[i];
      }
    }
    return str;
  }

  Column mytable(List<Post> mypost){
    return Column(
        children: <Widget>[
          Padding(
          padding: EdgeInsets.fromLTRB(22, 10, 22, 6),
          child: Table(
            border: TableBorder.all(width: 1, color: Color.fromRGBO(20, 0, 160, 0.2)),
            children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text(htmltostr(mypost[0].chord_HTML), style: TextStyle(fontSize: textSize * 0.85, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text(htmltostr(mypost[1].chord_HTML), style: TextStyle(fontSize: textSize * 0.85, color: Colors.red),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text(htmltostr(mypost[2].chord_HTML), style: TextStyle(fontSize: textSize * 0.85, color: Colors.red),))),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${(mypost[0].probability * 100).toStringAsFixed(1)}%", style: TextStyle(fontSize: textSize * 0.85),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${(mypost[1].probability * 100).toStringAsFixed(1)}%", style: TextStyle(fontSize: textSize * 0.85),))),
                  ),
                  TableCell(
                    child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${(mypost[2].probability * 100).toStringAsFixed(1)}%", style: TextStyle(fontSize: textSize * 0.85),))),
                  ),
                ],
              ),
            ],      
          ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(22, 6, 22, 6), 
            child: Table(
              border: TableBorder.all(width: 1, color: Color.fromRGBO(20, 0, 160, 0.2)),
              children: <TableRow>[
                TableRow(
                  children: <TableCell>[
                   TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text(htmltostr(mypost[3].chord_HTML), style: TextStyle(fontSize: textSize * 0.85, color: Colors.red),))),
                    ),           
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text(htmltostr(mypost[4].chord_HTML), style: TextStyle(fontSize: textSize * 0.85, color: Colors.red),))),
                    ), 
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.3, 0, textSize * 0.35), child: Center(child: Text(htmltostr(mypost[5].chord_HTML), style: TextStyle(fontSize: textSize * 0.85, color: Colors.red),))),
                    ), 
                   ]
                ),
                TableRow(
                  children: <TableCell>[
                   TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${(mypost[3].probability * 100).toStringAsFixed(1)}%", style: TextStyle(fontSize: textSize * 0.85),))),
                    ),           
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${(mypost[4].probability * 100).toStringAsFixed(1)}%", style: TextStyle(fontSize: textSize * 0.85),))),
                    ),
                    TableCell(
                      child: Padding(padding: EdgeInsets.fromLTRB(0, textSize * 0.5, 0, textSize * 0.55), child: Center(child: Text("${(mypost[5].probability * 100).toStringAsFixed(1)}%", style: TextStyle(fontSize: textSize * 0.85),))),
                    )
                   ]
                ),
                ],
              ),
            ),
        ]
      );
  }

  Row chordlists(int number){
    if(number == 1){
      return Row(
        children: <Widget>[ 
          DropdownButton<String>(
            hint: Text("${buttonhint[0]}", style: TextStyle(fontSize: 24),),
            items: buttonitems[1].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text("$value", style: TextStyle(fontSize: 20),),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              setState(() {
                buttonitems = [["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"]];
                buttonhint[0] = newValueSelected;
                param[0] = newValueSelected; 
              });
            },
          ),
        ]
      );
    }
    else if(number == 2){
      return Row(
        children: <Widget>[ 
          DropdownButton<String>(
            hint: Text("${buttonhint[0]}", style: TextStyle(fontSize: 24),),
            items: buttonitems[0].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text("$value", style: TextStyle(fontSize: 20),),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              setState(() {
                buttonitems = [["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"]];
                buttonhint[0] = newValueSelected;
                param[0] = newValueSelected; 
              });
            },
          ),
          Text(" "),
          Container(width: 1, height: 30, color: Colors.grey,),
          Text(" "),
          DropdownButton<String>(
            hint: Text("${buttonhint[1]}", style: TextStyle(fontSize: 24),),
            items: buttonitems[1].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text("$value", style: TextStyle(fontSize: 20),),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              setState(() {
                buttonitems = [["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"]];
                buttonhint[1] = newValueSelected;
                param[1] = newValueSelected; 
              });
            },
          ),
        ]
      );
    }
    else if(number == 3){
      return Row(
        children: <Widget>[ 
          DropdownButton<String>(
            hint: Text("${buttonhint[0]}", style: TextStyle(fontSize: 24),),
            items: buttonitems[0].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text("$value", style: TextStyle(fontSize: 20),),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              setState(() {
                buttonitems = [["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"]];
                buttonhint[0] = newValueSelected;
                param[0] = newValueSelected; 
              });
            },
          ),
          Text(" "),
          Container(width: 1, height: 30, color: Colors.grey,),
          Text(" "),
          DropdownButton<String>(
            hint: Text("${buttonhint[1]}", style: TextStyle(fontSize: 24),),
            items: buttonitems[1].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text("$value", style: TextStyle(fontSize: 20),),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              setState(() {
                buttonitems = [["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"]];
                buttonhint[1] = newValueSelected;
                param[1] = newValueSelected; 
              });
            },
          ),
          Text(" "),
          Container(width: 1, height: 30, color: Colors.grey,),
          Text(" "),
          DropdownButton<String>(
            hint: Text("${buttonhint[2]}", style: TextStyle(fontSize: 24),),
            items: buttonitems[2].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text("$value", style: TextStyle(fontSize: 20),),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              setState(() {
                buttonitems = [["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"]];
                buttonhint[2] = newValueSelected;
                param[2] = newValueSelected; 
              });
            },
          ),
        ]
      );
    }
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text("Next Chord Possibility", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1), fontSize: 19)),
          elevation: 1,
          actions: <Widget>[
            GestureDetector(
              child: Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.help, size: 30,)),
              onTap: (){
                showDialog(
                context: context,
                builder: (ctxt) => AlertDialog(
                  title: Text("Help", textAlign: TextAlign.center,),
                  content: Text("Select the number of chords, and the chords. View the next chord possibility.\n\nData provided by: www.hooktheory.com"),
                )
              );
            },
          )
          ],
        ),
        bottomNavigationBar: Container(color: Color.fromRGBO(250, 250, 250, 1), padding: EdgeInsets.only(right: 6, bottom: 2, top: 2), child: Text("Provided by hooktheory.com", style: TextStyle(color: Colors.grey,fontSize: 9), textAlign: TextAlign.right,),),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: (){
            setState(() {
             fetchPost("nodes", param); 
            });
          },  
          child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 8),
              color: Color.fromRGBO(255, 225, 225, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Number Of Chords:  ", style: TextStyle(fontSize: 24)),
                  DropdownButton<int>(
                        hint: Text("$chordnum", style: TextStyle(fontSize: 24),),
                        items: <int>[1, 2, 3].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text("$value", style: TextStyle(fontSize: 20),),
                          );
                        }).toList(),
                        onChanged: (int newValueSelected) {
                          setState(() {
                            param[0] = "1";
                            param[1] = "2";
                            param[2] = "3";
                            buttonhint = ["1", "2", "3"];
                            paramlength = newValueSelected;
                            chordnum = newValueSelected; 
                          });
                        },
                      ),
                  ],
                ),
              ),
              Divider(height: 0, color: Colors.black26,),
              Container(
                color: Color.fromRGBO(225, 250, 250, 1),
                padding: EdgeInsets.only(top: 10, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Chords:  ", style: TextStyle(fontSize: 24)),
                    chordlists(chordnum),
                  ],
                ),
              ),
              Divider(height: 0, color: Colors.black26,),
              FutureBuilder<List<Post>>(
                future: fetchPost("nodes", param),
                builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot){
                  switch (snapshot.connectionState) {
                  case ConnectionState.waiting: 
                      return Padding(padding: EdgeInsets.fromLTRB(6, 16, 6, 6), child: Center(child: CircularProgressIndicator(strokeWidth: 3, backgroundColor: Colors.orangeAccent,)));
                  default:
                    if (snapshot.hasError)
                      return Center(child: Column(children: <Widget> [ Padding(padding: EdgeInsets.only(top: 16, bottom: 4), child: Text('No data available', style: TextStyle(fontSize: 20,))), Icon(Icons.error, color: Colors.red),]));
                    else
                      return mytable(snapshot.data);
                }
              },
              )
              ]
          )
        ),
        ),
    );
  }
}


