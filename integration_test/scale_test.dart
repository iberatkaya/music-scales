// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:music_scales/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> launchScalePage(WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final Finder scalesPageButton = find.byKey(ValueKey("scale_page_button"));
    expect(scalesPageButton, findsOneWidget);

    await tester.tap(scalesPageButton);
    await tester.pumpAndSettle();

    final Finder scaleDetailPage = find.byKey(ValueKey("scale_detail_page"));
    expect(scaleDetailPage, findsOneWidget);
  }

  Future<void> launchProgressionPage(WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final Finder progressionDetailPage =
        find.byKey(ValueKey("progression_page_button"));
    expect(progressionDetailPage, findsOneWidget);

    await tester.tap(progressionDetailPage);
    await tester.pumpAndSettle();
  }

  testWidgets("Scale Detail Page should launch", (WidgetTester tester) async {
    await launchScalePage(tester);
  });

  testWidgets(
      "Scale Detail Page should display images with different keys, modes, and instruments",
      (WidgetTester tester) async {
    await launchScalePage(tester);

    Finder scaleImage = find.byKey(ValueKey("A_Major_Piano_image"));
    expect(scaleImage, findsOneWidget);

    final Finder scaleKeyDropdownButton =
        find.byKey(ValueKey("scale_key_dropdown_button"));
    expect(scaleKeyDropdownButton, findsOneWidget);

    final Finder scaleNameDropdownButton =
        find.byKey(ValueKey("scale_name_dropdown_button"));
    expect(scaleNameDropdownButton, findsOneWidget);

    await tester.tap(scaleKeyDropdownButton);
    await tester.pumpAndSettle();

    final Finder scaleKeyDropdownButtonItem =
        find.byKey(ValueKey("dropdown_note_B")).last;
    expect(scaleKeyDropdownButtonItem, findsOneWidget);

    await tester.tap(scaleKeyDropdownButtonItem);
    await tester.pumpAndSettle();

    scaleImage = find.byKey(ValueKey("B_Major_Piano_image"));
    expect(scaleImage, findsOneWidget);

    await tester.tap(scaleNameDropdownButton);
    await tester.pumpAndSettle();

    final Finder scaleNameDropdownButtonItem =
        find.byKey(ValueKey("dropdown_scale_Minor")).last;

    await tester.tap(scaleNameDropdownButtonItem);
    await tester.pumpAndSettle();

    scaleImage = find.byKey(ValueKey("B_Minor_Piano_image"));
    expect(scaleImage, findsOneWidget);

    final Finder instrumentButton = find.byKey(ValueKey("instrument_button"));

    await tester.tap(instrumentButton);
    await tester.pumpAndSettle();

    scaleImage = find.byKey(ValueKey("B_Minor_Guitar_image"));
    expect(scaleImage, findsOneWidget);
  });

  testWidgets("Scale Detail Page should display helper dialog",
      (WidgetTester tester) async {
    await launchScalePage(tester);

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

  testWidgets(
      "Progression Detail Page should display progressions with different keys and modes",
      (WidgetTester tester) async {
    await launchProgressionPage(tester);

    final Finder progressionKeyDropdownButton =
        find.byKey(ValueKey("progression_key_dropdown_button"));
    expect(progressionKeyDropdownButton, findsOneWidget);

    await tester.tap(progressionKeyDropdownButton);
    await tester.pumpAndSettle();

    final Finder progressionKeyB =
        find.byKey(ValueKey("progression_key_B")).last;
    expect(progressionKeyB, findsOneWidget);

    await tester.tap(progressionKeyB);
    await tester.pumpAndSettle();

    final Finder progressionChordDropdownButton =
        find.byKey(ValueKey("progression_chord_dropdown_button"));
    expect(progressionChordDropdownButton, findsOneWidget);

    await tester.tap(progressionChordDropdownButton);
    await tester.pumpAndSettle();

    final Finder progressionChordMinor =
        find.byKey(ValueKey("progression_chord_Minor")).last;
    expect(progressionChordMinor, findsOneWidget);

    await tester.tap(progressionChordMinor);
    await tester.pumpAndSettle();

    final Finder cSharpDimChord = find.text("C#dim");
    expect(cSharpDimChord, findsOneWidget);
  });
}
