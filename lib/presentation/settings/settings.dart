import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:music_scales/application/actions/settings_action.dart';
import 'package:music_scales/application/store/store.dart';
import 'package:music_scales/domain/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  Future<void> _changeInstrument(String temp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('instrument', temp);
  }

  Future<void> _changeFastChordAudioSpeed(bool fastChordAudioSpeed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('fastChordAudioSpeed', fastChordAudioSpeed);
  }

  Future<void> _changeShowFlatsInScales(bool showFlatsInScales) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showFlatsInScales', showFlatsInScales);
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          elevation: 1,
        ),
        //bottomNavigationBar: Container(height: adpadding,),
        backgroundColor: Colors.white,
        body: StoreConnector<Settings, Settings>(
            converter: (settings) => settings.state,
            builder: (context, settings) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 6, 0, 8),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Default Instrument:    ",
                            style: TextStyle(fontSize: 17),
                          ),
                          DropdownButton<String>(
                            hint: Text(
                              "${settings.instrument}",
                              style: TextStyle(fontSize: 17),
                            ),
                            value: settings.instrument,
                            items:
                                <String>["Piano", "Guitar"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text("$value"),
                              );
                            }).toList(),
                            onChanged: (newValueSelected) async {
                              store.dispatch(SettingsAction(
                                  settingsActionType:
                                      SettingsActionType.setInstrument,
                                  payload: newValueSelected));
                              if (newValueSelected != null) {
                                await _changeInstrument(newValueSelected);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 0,
                      color: Color.fromRGBO(0, 0, 200, 0.2),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 6, 0, 8),
                      padding: EdgeInsets.all(6),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Chord Audio Speed:    ",
                            style: TextStyle(fontSize: 17),
                          ),
                          DropdownButton<String>(
                            hint: Text(
                              "${settings.fastChordAudioSpeed ? "Fast" : "Slow"}",
                              style: TextStyle(fontSize: 17),
                            ),
                            value:
                                settings.fastChordAudioSpeed ? "Fast" : "Slow",
                            items: <String>["Fast", "Slow"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text("$value"),
                              );
                            }).toList(),
                            onChanged: (newValueSelected) async {
                              bool isFast = newValueSelected == "Fast";
                              store.dispatch(SettingsAction(
                                  settingsActionType:
                                      SettingsActionType.setFastChordAudioSpeed,
                                  payload: isFast));
                              await _changeFastChordAudioSpeed(isFast);
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 0,
                      color: Color.fromRGBO(0, 0, 200, 0.2),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 6, 0, 8),
                      padding: EdgeInsets.all(6),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Show Flats in Scales:    ",
                            style: TextStyle(fontSize: 17),
                          ),
                          DropdownButton<String>(
                            hint: Text(
                              "${settings.showFlatsInScales ? "Yes" : "No"}",
                              style: TextStyle(fontSize: 17),
                            ),
                            value: settings.showFlatsInScales ? "Yes" : "No",
                            items: <String>["No", "Yes"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text("$value"),
                              );
                            }).toList(),
                            onChanged: (newValueSelected) {
                              bool showFlatsInScales =
                                  newValueSelected == "Yes";
                              store.dispatch(SettingsAction(
                                  settingsActionType:
                                      SettingsActionType.setShowFlatsInScales,
                                  payload: showFlatsInScales));
                              _changeShowFlatsInScales(showFlatsInScales);
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 0,
                      color: Color.fromRGBO(0, 0, 200, 0.2),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
