import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:music_scales/presentation/settings/settings.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  Future<void> _launchPrivPol() async {
    const url = "https://kayaib17.github.io/MusicScalesPrivacyPolicy/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            //height: 110,
            color: Colors.orangeAccent,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Image(
                  fit: BoxFit.fill, image: AssetImage('assets/imgs/logo.jpg')),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
            title: Text('Settings', style: TextStyle(fontSize: 15)),
            leading: Icon(Icons.settings, size: 24, color: Colors.grey[600]),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
          Divider(
            height: 0,
            color: Colors.black26,
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
            title: Text('Rate App', style: TextStyle(fontSize: 15)),
            leading: Icon(Icons.star, size: 24, color: Colors.grey[600]),
            onTap: () {
              LaunchReview.launch(
                  androidAppId: "com.kaya.musicapp", iOSAppId: "1498463498");
            },
          ),
          Divider(
            height: 0,
            color: Colors.black26,
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
            title: Text('Share App', style: TextStyle(fontSize: 15)),
            leading: Icon(Icons.share, size: 24, color: Colors.grey[600]),
            onTap: () {
              if (Platform.isAndroid) {
                Share.share(
                    'Music Scales: https://play.google.com/store/apps/details?id=com.kaya.musicapp');
              } else {
                Share.share(
                    'Music Scales: https://apps.apple.com/us/app/music-scales/id1498463498');
              }
            },
          ),
          Divider(
            height: 0,
            color: Colors.black26,
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
            title: Text('About',
                style: TextStyle(fontSize: 15, color: Colors.black87)),
            leading:
                Icon(Icons.help_outline, size: 24, color: Colors.grey[600]),
            onTap: () {
              showAboutDialog(
                applicationIcon: Tab(
                  icon: Image.asset("assets/imgs/appicon.png"),
                ),
                applicationName: "Music Scales",
                context: context,
                children: <Widget>[
                  Text(
                      "Music Scales is an app that shows the user the notes of a scale or a chord in a selected key, and shows chord progressions for free. The simple design lets the user quickly learn the chords, scales, and progressions on a piano and on a guitar."),
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 16, 14, 0),
                      child: FlatButton(
                          color: Color.fromRGBO(250, 240, 240, 0.6),
                          child: Text("Privacy Policy",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 11)),
                          onPressed: () {
                            _launchPrivPol();
                          })),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
