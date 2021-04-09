// @dart=2.9

import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_scales/presentation/core/my_app.dart';

import 'infrastructure/ads/ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAdMob.instance.initialize(appId: appid);
  runApp(MyApp());
}
