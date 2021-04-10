// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:music_scales/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Scale Page should launch", (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final Finder scalesPage = find.byKey(ValueKey("scale_page"));
    expect(scalesPage, findsOneWidget);
  });

  testWidgets("Chord Page should launch", (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final Finder bottomNavbarChordPage =
        find.byKey(ValueKey("bottom_navbar_chord_page"));
    expect(bottomNavbarChordPage, findsOneWidget);

    await tester.tap(bottomNavbarChordPage);
    await tester.pumpAndSettle();

    final Finder chordPage = find.byKey(ValueKey("chord_page"));
    expect(chordPage, findsOneWidget);
  });

  testWidgets("Progression Page should launch", (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final Finder bottomNavbarProgressionPage =
        find.byKey(ValueKey("bottom_navbar_progression_page"));
    expect(bottomNavbarProgressionPage, findsOneWidget);

    await tester.tap(bottomNavbarProgressionPage);
    await tester.pumpAndSettle();

    final Finder progressionPage = find.byKey(ValueKey("progression_page"));
    expect(progressionPage, findsOneWidget);
  });
}
