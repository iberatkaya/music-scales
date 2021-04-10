import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:music_scales/application/actions/settings_action.dart';
import 'package:music_scales/application/store/store.dart';
import 'package:music_scales/domain/core/const.dart';
import 'package:music_scales/domain/settings/settings.dart';
import 'package:music_scales/presentation/chords/chord_page.dart';
import 'package:music_scales/presentation/progression/progression_page.dart';
import 'package:music_scales/presentation/scale/scale_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../icons/my_flutter_app_icons.dart' as CustomIcons;
import 'drawer/drawer.dart';

class MyApp extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String defaultinstrument = (prefs.getString('instrument') ?? "Piano");
    bool fastChordAudioSpeed = (prefs.getBool('fastChordAudioSpeed') ?? true);
    bool showFlatsInScales = (prefs.getBool('showFlatsInScales') ?? false);
    Settings settings = Settings(
      showFlatsInScales: showFlatsInScales,
      fastChordAudioSpeed: fastChordAudioSpeed,
      instrument: defaultinstrument,
    );
    store.dispatch(SettingsAction(
        settingsActionType: SettingsActionType.setSettings, payload: settings));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Scales',
      theme: ThemeData(
        primarySwatch: myColor,
        iconTheme: IconThemeData(
          size: 25,
          opacity: 1,
        ),
      ),
      navigatorObservers: <NavigatorObserver>[MyApp.observer],
      home: Scaffold(
        appBar: AppBar(
          title: Text("Music Scales",
              style: TextStyle(
                color: Color.fromRGBO(20, 20, 20, 1),
              )),
          elevation: 1,
        ),
        drawer: MyDrawer(),
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: index,
          children: [
            ScalePage(),
            ChordPage(),
            ProgressionPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (newIndex) {
            setState(() {
              index = newIndex;
            });
          },
          currentIndex: index,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: myColor,
          selectedItemColor: Colors.white70,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.MyFlutterApp.music_notes,
                key: ValueKey("bottom_navbar_scale_page"),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.MyFlutterApp.prog,
                key: ValueKey("bottom_navbar_chord_page"),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.MyFlutterApp.international_music,
                key: ValueKey("bottom_navbar_progression_page"),
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
