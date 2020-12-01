import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:music_scales/presentation/home/home_page.dart';

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Scales', //Notes
      theme: ThemeData(
        primarySwatch: MaterialColor(0xffffaf00, {
          50: Color(0xffffaf00),
          100: Color(0xffffaf00),
          200: Color(0xffffaf00),
          300: Color(0xffffaf00),
          400: Color(0xffffaf00),
          500: Color(0xffffaf00),
          600: Color(0xffffaf00),
          700: Color(0xffffaf00),
          800: Color(0xffffaf00),
          900: Color(0xffffaf00),
        }),
        iconTheme: IconThemeData(
          size: 25,
          opacity: 1,
        ),
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: MyHomePage(
        title: "Home Page",
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}
