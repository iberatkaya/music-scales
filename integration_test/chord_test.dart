// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:music_scales/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> launchChordPage(WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final Finder bottomNavbarChordPage =
        find.byKey(ValueKey("bottom_navbar_chord_page"));
    expect(bottomNavbarChordPage, findsOneWidget);

    await tester.tap(bottomNavbarChordPage);
    await tester.pumpAndSettle();

    final Finder chordPage = find.byKey(ValueKey("chord_page"));
    expect(chordPage, findsOneWidget);

    final Finder chordDetailButton =
        find.byKey(ValueKey("chord_detail_button"));
    expect(chordDetailButton, findsOneWidget);

    await tester.tap(chordDetailButton);
    await tester.pumpAndSettle();
  }

  testWidgets("Chord Detail Page should launch", (WidgetTester tester) async {
    await launchChordPage(tester);
  });

  testWidgets(
      "Chord Detail Page should display images with different keys, modes, and instruments",
      (WidgetTester tester) async {
    await launchChordPage(tester);

    Finder chordImage = find.byKey(ValueKey("A_Major_Piano_image"));
    expect(chordImage, findsOneWidget);

    final Finder chordKeyDropdownButton =
        find.byKey(ValueKey("chord_key_dropdown_button"));
    expect(chordKeyDropdownButton, findsOneWidget);

    final Finder chordNameDropdownButton =
        find.byKey(ValueKey("chord_name_dropdown_button"));
    expect(chordNameDropdownButton, findsOneWidget);

    await tester.tap(chordKeyDropdownButton);
    await tester.pumpAndSettle();

    final Finder chordKeyDropdownButtonItem =
        find.byKey(ValueKey("dropdown_note_B")).last;
    expect(chordKeyDropdownButtonItem, findsOneWidget);

    await tester.tap(chordKeyDropdownButtonItem);
    await tester.pumpAndSettle();

    chordImage = find.byKey(ValueKey("B_Major_Piano_image"));
    expect(chordImage, findsOneWidget);

    await tester.tap(chordNameDropdownButton);
    await tester.pumpAndSettle();

    final Finder chordNameDropdownButtonItem =
        find.byKey(ValueKey("dropdown_chord_Minor")).last;

    await tester.tap(chordNameDropdownButtonItem);
    await tester.pumpAndSettle();

    chordImage = find.byKey(ValueKey("B_Minor_Piano_image"));
    expect(chordImage, findsOneWidget);

    final Finder instrumentButton = find.byKey(ValueKey("instrument_button"));

    await tester.tap(instrumentButton);
    await tester.pumpAndSettle();

    chordImage = find.byKey(ValueKey("B_Minor_Guitar_image"));
    expect(chordImage, findsOneWidget);
  });

  testWidgets(
      "Chord Detail Page should display images with different keys, modes, and instruments",
      (WidgetTester tester) async {
    await launchChordPage(tester);

    final Finder helpButton = find.byKey(ValueKey("help_button"));
    expect(helpButton, findsOneWidget);

    await tester.tap(helpButton);
    await tester.pumpAndSettle();

    final Finder helpDialog = find.byKey(ValueKey("help_dialog"));
    expect(helpDialog, findsOneWidget);

    await tester.tapAt(Offset(10, 10));
    await tester.pumpAndSettle();

    expect(helpDialog, findsNothing);
  });
}
