import 'package:music_scales/domain/chords/chordfingering.dart';
import 'package:music_scales/domain/chords/chords.dart';

///Calculate a chord's notes based on its [mode] and [key].
List<ChordNote> calculateChord(int mode, int key) {
  List<ChordNote> theNotes = [];
  int audioindx = 4;
  var index = key;
  late Chord chordObj;
  for (int i = 0; i < chords.length; i++) {
    if (mode == chords[i].index) chordObj = chords[i];
  }
  for (int j = 0; j < chordObj.formula.length + 1; j++) {
    if (j != 0) index += chordObj.formula[j - 1];
    if (index > 11) {
      index %= 12;
      if (audioindx == 4)
        audioindx = 5;
      else if (audioindx == 5) audioindx = 6;
    }
    chordNotes[index].audioindex = audioindx;
    theNotes.add(chordNotes[index]);
  }
  return theNotes;
}

///Set the table's header text based on the [chord].
List<String> tablenums(String chord) {
  List<String> nums = ["1", "3", "5", "7", "9", "11"];
  if (chord == "Minor")
    nums[1] = "b3";
  else if (chord == "7th")
    nums[3] = "b7";
  else if (chord == "Minor 7th") {
    nums[1] = "b3";
    nums[3] = "b7";
  } else if (chord == "m(maj7)")
    nums[1] = "b3";
  else if (chord == "Sus2")
    nums[1] = "2";
  else if (chord == "Sus4")
    nums[1] = "4";
  else if (chord == "6th")
    nums[3] = "6";
  else if (chord == "Minor 6th") {
    nums[3] = "6";
    nums[1] = "b3";
  } else if (chord == "Diminished") {
    nums[1] = "b3";
    nums[2] = "b5";
  } else if (chord == "Diminished 7th") {
    nums[1] = "b3";
    nums[2] = "b5";
    nums[3] = "b6";
  } else if (chord == "Augmented")
    nums[2] = "b6";
  else if (chord == "9th")
    nums[3] = "b7";
  else if (chord == "Minor 9th") {
    nums[1] = "b3";
    nums[3] = "b7";
  } else if (chord == "m(maj9)")
    nums[1] = "b3";
  else if (chord == "6th/9th")
    nums[3] = "b6";
  else if (chord == "m7b5") {
    nums[1] = "b3";
    nums[2] = "b5";
    nums[3] = "b7";
  } else if (chord == "m7#5") {
    nums[1] = "b3";
    nums[2] = "#5";
    nums[3] = "b7";
  } else if (chord == "7b5") {
    nums[2] = "b5";
    nums[3] = "b7";
  } else if (chord == "7#5") {
    nums[2] = "#5";
    nums[3] = "b7";
  } else if (chord == "9#5") {
    nums[2] = "#5";
    nums[3] = "b7";
  } else if (chord == "9b5") {
    nums[2] = "b5";
    nums[3] = "b7";
  } else if (chord == "11th")
    nums[3] = "b7";
  else if (chord == "Minor 11th") {
    nums[1] = "b3";
    nums[3] = "b7";
  } else if (chord == "m(maj11)")
    nums[1] = "b3";
  else if (chord == "11b5") {
    nums[2] = "b5";
    nums[3] = "b7";
  } else if (chord == "11#5") {
    nums[2] = "#5";
    nums[3] = "b7";
  } else if (chord == "Add2") {
    nums[1] = "2";
    nums[2] = "3";
    nums[3] = "5";
  } else if (chord == "Add4") {
    nums[2] = "4";
    nums[3] = "5";
  }
  return nums;
}

///Set the title text of the chord based on the [key] and [mode].
String titleText(String key, String mode) {
  if (mode == "Major")
    return "$key Chord";
  else if (mode == "Minor")
    return "${key}m Chord";
  else if (mode == "Major 7th")
    return "${key}maj7 Chord";
  else if (mode == "Sus2")
    return "${key}sus2 Chord";
  else if (mode == "Sus4")
    return "${key}sus4 Chord";
  else if (mode == "Minor 7th")
    return "${key}m7 Chord";
  else if (mode == "7th")
    return "${key}7 Chord";
  else if (mode == "Diminished")
    return "${key}dim Chord";
  else if (mode == "Augmented")
    return "${key}aug Chord";
  else if (mode == "9th")
    return "${key}9 Chord";
  else if (mode == "6th")
    return "${key}6 Chord";
  else if (mode == "Minor 6th")
    return "${key}m6 Chord";
  else if (mode == "6th/9th")
    return "${key}6/9 Chord";
  else if (mode == "m7b5")
    return "${key}m7b5 Chord";
  else if (mode == "Diminished 7th")
    return "${key}dim7 Chord";
  else if (mode == "7b5")
    return "${key}7b5 Chord";
  else if (mode == "7#5")
    return "${key}7#5 Chord";
  else if (mode == "Minor 9th")
    return "${key}m9 Chord";
  else if (mode == "m(maj9)")
    return "${key}m(maj9) Chord";
  else if (mode == "Major 9th")
    return "${key}maj9 Chord";
  else if (mode == "9#5")
    return "${key}9#5 Chord";
  else if (mode == "9b5")
    return "${key}9b5 Chord";
  else if (mode == "m7#5")
    return "${key}m7#5 Chord";
  else if (mode == "11th")
    return "${key}11 Chord";
  else if (mode == "Major 11th")
    return "${key}maj11 Chord";
  else if (mode == "Minor 11th")
    return "${key}m11 Chord";
  else if (mode == "m(maj11)")
    return "${key}m(maj11) Chord";
  else if (mode == "11b5")
    return "${key}11b5 Chord";
  else if (mode == "11#5")
    return "${key}11#5 Chord";
  else if (mode == "m(maj7)")
    return "${key}m(maj7) Chord";
  else if (mode == "Add2")
    return "${key}add2 Chord";
  else if (mode == "Add4") return "${key}add4 Chord";
  return "$key $mode Chord";
}

///Find the url of the chord image using the [mode], the [notes] of the chord,
///the [instrument], and the [image] index (there are different images for
///each chord).
String urlChord(
    String mode, List<ChordNote> notes, String instrument, int image) {
  String url;
  if (instrument == "Piano") {
    if (!notes[0].note.contains("#")) {
      if (mode == "Major")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "Minor")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "Major 7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}maj7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Minor 7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "m(maj7)")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}mmaj7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Sus2")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}sus2-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "Sus4")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}sus4-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Diminished")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}dim-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "Augmented")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}aug-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}9-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "6th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}6-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Minor 6th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m6-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "6th/9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}69-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "m7b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m7b5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Diminished 7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}dim7-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "7b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}7b5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "7#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}7s5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Minor 9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m9-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "Major 9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}maj9-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "m(maj9)")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}mmaj9-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "9#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}9s5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "9b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}9b5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "m7#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m7s5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "11th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}911-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "Major 11th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}maj911-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "Minor 11th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m911-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "m(maj11)")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}mmaj911-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "11b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}911b5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "11#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}911s5-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "Add2")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}add2-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else //if (mode == "Add4")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}add4-${notes[0].note.toLowerCase()}-n-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      return url.replaceAll("#", "s");
    } else {
      if (mode == "Major")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "Minor")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "Major 7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}maj7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Minor 7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "m(maj7)")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}mmaj7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Sus2")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}sus2-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "Sus4")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}sus4-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Diminished")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}dim-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "Augmented")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}aug-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
      else if (mode == "9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}9-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "6th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}6-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Minor 6th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m6-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "6th/9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}69-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "m7b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m7b5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Diminished 7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}dim7-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "7b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}7b5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "7#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}7s5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "Minor 9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m9-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "Major 9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}maj9-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "m(maj9)")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}mmaj9-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "9#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}9s5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "9b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}9b5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
      else if (mode == "m7#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m7s5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else if (mode == "11th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}911-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "Major 11th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}maj911-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "Minor 11th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m911-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "m(maj11)")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}mmaj911-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "11b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}911b5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "11#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}911s5-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
      else if (mode == "Add2")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}add2-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      else //if (mode == "Add4")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}add4-${notes[0].note.toLowerCase()}-l-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
      return url
          .replaceFirst("#", "s")
          .replaceFirst("#", "-sharp")
          .replaceAll("#", "s");
    }
  } else {
    if (!notes[0].note.contains("#")) {
      if (mode == "Major")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][0].replaceAll(" ", "-")}";
      else if (mode == "Minor")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][1].replaceAll(" ", "-")}";
      else if (mode == "Major 7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}maj7-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][2].replaceAll(" ", "-")}";
      else if (mode == "Minor 7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m7-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][3].replaceAll(" ", "-")}";
      else if (mode == "m(maj7)")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}mmaj7-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][22].replaceAll(" ", "-")}";
      else if (mode == "Sus2")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}sus2-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][4].replaceAll(" ", "-")}";
      else if (mode == "Sus4")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}sus4-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][5].replaceAll(" ", "-")}";
      else if (mode == "7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}7-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][6].replaceAll(" ", "-")}";
      else if (mode == "Diminished")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}dim-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][7].replaceAll(" ", "-")}";
      else if (mode == "Augmented")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}aug-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][8].replaceAll(" ", "-")}";
      else if (mode == "9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}9-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][9].replaceAll(" ", "-")}";
      else if (mode == "6th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}6-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][10].replaceAll(" ", "-")}";
      else if (mode == "Minor 6th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m6-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][11].replaceAll(" ", "-")}";
      else if (mode == "6th/9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}69-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][12].replaceAll(" ", "-")}";
      else if (mode == "m7b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m7b5-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][13].replaceAll(" ", "-")}";
      else if (mode == "Diminished 7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}dim7-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][14].replaceAll(" ", "-")}";
      else if (mode == "7b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}7b5-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][15].replaceAll(" ", "-")}";
      else if (mode == "7#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}7s5-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][16].replaceAll(" ", "-")}";
      else if (mode == "Minor 9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m9-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][17].replaceAll(" ", "-")}";
      else if (mode == "Major 9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}maj9-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][18].replaceAll(" ", "-")}";
      else if (mode == "m(maj9)")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}mmaj9-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][23].replaceAll(" ", "-")}";
      else if (mode == "9#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}9s5-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][19].replaceAll(" ", "-")}";
      else if (mode == "9b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}9b5-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][20].replaceAll(" ", "-")}";
      else if (mode == "m7#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m7s5-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][21].replaceAll(" ", "-")}";
      else if (mode == "11th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}911-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[image][notes[0].index][0].replaceAll(" ", "-")}";
      else if (mode == "Major 11th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}maj911-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[image][notes[0].index][1].replaceAll(" ", "-")}";
      else if (mode == "Minor 11th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m911-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[image][notes[0].index][2].replaceAll(" ", "-")}";
      else if (mode == "m(maj11)")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}mmaj911-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[image][notes[0].index][5].replaceAll(" ", "-")}";
      else if (mode == "11b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}911b5-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[image][notes[0].index][3].replaceAll(" ", "-")}";
      else if (mode == "11#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}911s5-${notes[0].note.toLowerCase()}-n-l-h-${shortstrings[image][notes[0].index][4].replaceAll(" ", "-")}";
      else if (mode == "Add2")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}add2-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][24].replaceAll(" ", "-")}";
      else //if (mode == "Add4")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}add4-${notes[0].note.toLowerCase()}-n-l-h-${strings[image][notes[0].index][25].replaceAll(" ", "-")}";
      return url.replaceAll("#", "s");
    } else {
      if (mode == "Major")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][0].replaceAll(" ", "-")}";
      else if (mode == "Minor")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][1].replaceAll(" ", "-")}";
      else if (mode == "Major 7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}maj7-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][2].replaceAll(" ", "-")}";
      else if (mode == "Minor 7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m7-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][3].replaceAll(" ", "-")}";
      else if (mode == "m(maj7)")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}mmaj7-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][22].replaceAll(" ", "-")}";
      else if (mode == "Sus2")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}sus2-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][4].replaceAll(" ", "-")}";
      else if (mode == "Sus4")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}sus4-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][5].replaceAll(" ", "-")}";
      else if (mode == "7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}7-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][6].replaceAll(" ", "-")}";
      else if (mode == "Diminished")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}dim-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][7].replaceAll(" ", "-")}";
      else if (mode == "Augmented")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}aug-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][8].replaceAll(" ", "-")}";
      else if (mode == "9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}9-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][9].replaceAll(" ", "-")}";
      else if (mode == "6th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}6-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][10].replaceAll(" ", "-")}";
      else if (mode == "Minor 6th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m6-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][11].replaceAll(" ", "-")}";
      else if (mode == "6th/9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}69-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][12].replaceAll(" ", "-")}";
      else if (mode == "m7b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m7b5-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][13].replaceAll(" ", "-")}";
      else if (mode == "Diminished 7th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}dim7-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][14].replaceAll(" ", "-")}";
      else if (mode == "7b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}7b5-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][15].replaceAll(" ", "-")}";
      else if (mode == "7#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}7s5-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][16].replaceAll(" ", "-")}";
      else if (mode == "Minor 9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m9-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][17].replaceAll(" ", "-")}";
      else if (mode == "Major 9th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}maj9-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][18].replaceAll(" ", "-")}";
      else if (mode == "m(maj9)")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}mmaj9-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][23].replaceAll(" ", "-")}";
      else if (mode == "9#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}9s5-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][19].replaceAll(" ", "-")}";
      else if (mode == "9b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}9b5-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][20].replaceAll(" ", "-")}";
      else if (mode == "m7#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m7s5-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][21].replaceAll(" ", "-")}";
      else if (mode == "11th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}911-${notes[0].note.toLowerCase()}-l-h-${shortstrings[image][notes[0].index][0].replaceAll(" ", "-")}";
      else if (mode == "Major 11th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}maj911-${notes[0].note.toLowerCase()}-l-h-${shortstrings[image][notes[0].index][1].replaceAll(" ", "-")}";
      else if (mode == "Minor 11th")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}m911-${notes[0].note.toLowerCase()}-l-h-${shortstrings[image][notes[0].index][2].replaceAll(" ", "-")}";
      else if (mode == "m(maj11)")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}mmaj911-${notes[0].note.toLowerCase()}-l-h-${shortstrings[image][notes[0].index][5].replaceAll(" ", "-")}";
      else if (mode == "11b5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}911b5-${notes[0].note.toLowerCase()}-l-h-${shortstrings[image][notes[0].index][3].replaceAll(" ", "-")}";
      else if (mode == "11#5")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}911s5-${notes[0].note.toLowerCase()}-l-h-${shortstrings[image][notes[0].index][4].replaceAll(" ", "-")}";
      else if (mode == "Add2")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}add2-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][24].replaceAll(" ", "-")}";
      else //if (mode == "Add4")
        url =
            "${instrument.toLowerCase()}-${notes[0].note}add4-${notes[0].note.toLowerCase()}-l-h-${strings[image][notes[0].index][25].replaceAll(" ", "-")}";
      return url
          .replaceFirst("#", "s")
          .replaceFirst("#", "-sharp")
          .replaceAll("#", "s");
    }
  }
}

///Find the url for the audio using the [mode], [notes], [instrument], [speed],
///and the [image] index (there are different images for each chord).
String urlAudio(String mode, List<ChordNote> notes, String instrument,
    String speed, int image) {
  String url;
  if (instrument == "Piano") {
    if (mode == "Major")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
    else if (mode == "Minor")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
    else if (mode == "Major 7th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}maj7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    else if (mode == "Minor 7th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    else if (mode == "Minor 7th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}mmaj7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    else if (mode == "Sus2")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}sus2-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
    else if (mode == "Sus4")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}sus4-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
    else if (mode == "7th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    else if (mode == "Diminished")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}dim-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
    else if (mode == "Augmented")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}aug-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}";
    else if (mode == "9th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}9-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
    else if (mode == "6th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}6-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    else if (mode == "Minor 6th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m6-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    else if (mode == "6th/9th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}69-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
    else if (mode == "m7b5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m7b5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    else if (mode == "Diminished 7th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}dim7-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    else if (mode == "7b5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}7b5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    else if (mode == "7#5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}7s5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    else if (mode == "Minor 9th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m9-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
    else if (mode == "Major 9th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}maj9-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
    else if (mode == "m(maj9)")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}mmaj9-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
    else if (mode == "9#5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}9s5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
    else if (mode == "9b5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}9b5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}";
    else if (mode == "m7#5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m7s5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    else if (mode == "11th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}911-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
    else if (mode == "Major 11th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}maj911-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
    else if (mode == "Minor 11th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m911-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
    else if (mode == "m(maj11)")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}mmaj911-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
    else if (mode == "11b5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}911b5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
    else if (mode == "11#5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}911s5-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}-${notes[4].note.toLowerCase()}-${notes[5].note.toLowerCase()}";
    else if (mode == "Add2")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}add2-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
    else //if (mode == "Add4")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}add4-$speed-${notes[0].note.toLowerCase()}-${notes[1].note.toLowerCase()}-${notes[2].note.toLowerCase()}-${notes[3].note.toLowerCase()}";
  } else {
    if (mode == "Major")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}-$speed-${strings[image][notes[0].index][0].replaceAll(" ", "-")}";
    else if (mode == "Minor")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m-$speed-${strings[image][notes[0].index][1].replaceAll(" ", "-")}";
    else if (mode == "Major 7th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}maj7-$speed-${strings[image][notes[0].index][2].replaceAll(" ", "-")}";
    else if (mode == "Minor 7th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m7-$speed-${strings[image][notes[0].index][3].replaceAll(" ", "-")}";
    else if (mode == "m(maj7)")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}mmaj7-$speed-${strings[image][notes[0].index][22].replaceAll(" ", "-")}";
    else if (mode == "Sus2")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}sus2-$speed-${strings[image][notes[0].index][4].replaceAll(" ", "-")}";
    else if (mode == "Sus4")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}sus4-$speed-${strings[image][notes[0].index][5].replaceAll(" ", "-")}";
    else if (mode == "7th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}7-$speed-${strings[image][notes[0].index][6].replaceAll(" ", "-")}";
    else if (mode == "Diminished")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}dim-$speed-${strings[image][notes[0].index][7].replaceAll(" ", "-")}";
    else if (mode == "Augmented")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}aug-$speed-${strings[image][notes[0].index][8].replaceAll(" ", "-")}";
    else if (mode == "9th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}9-$speed-${strings[image][notes[0].index][9].replaceAll(" ", "-")}";
    else if (mode == "6th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}6-$speed-${strings[image][notes[0].index][10].replaceAll(" ", "-")}";
    else if (mode == "Minor 6th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m6-$speed-${strings[image][notes[0].index][11].replaceAll(" ", "-")}";
    else if (mode == "6th/9th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}69-$speed-${strings[image][notes[0].index][12].replaceAll(" ", "-")}";
    else if (mode == "m7b5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m7b5-$speed-${strings[image][notes[0].index][13].replaceAll(" ", "-")}";
    else if (mode == "Diminished 7th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}dim7-$speed-${strings[image][notes[0].index][14].replaceAll(" ", "-")}";
    else if (mode == "7b5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}7b5-$speed-${strings[image][notes[0].index][15].replaceAll(" ", "-")}";
    else if (mode == "7#5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}7s5-$speed-${strings[image][notes[0].index][16].replaceAll(" ", "-")}";
    else if (mode == "Minor 9th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m9-$speed-${strings[image][notes[0].index][17].replaceAll(" ", "-")}";
    else if (mode == "Major 9th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}maj9-$speed-${strings[image][notes[0].index][18].replaceAll(" ", "-")}";
    else if (mode == "m(maj9)")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}mmaj9-$speed-${strings[image][notes[0].index][23].replaceAll(" ", "-")}";
    else if (mode == "9#5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}9s5-$speed-${strings[image][notes[0].index][19].replaceAll(" ", "-")}";
    else if (mode == "9b5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}9b5-$speed-${strings[image][notes[0].index][20].replaceAll(" ", "-")}";
    else if (mode == "m7#5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m7s5-$speed-${strings[image][notes[0].index][21].replaceAll(" ", "-")}";
    else if (mode == "11th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}911-$speed-${shortstrings[image][notes[0].index][0].replaceAll(" ", "-")}";
    else if (mode == "Major 11th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}maj911-$speed-${shortstrings[image][notes[0].index][1].replaceAll(" ", "-")}";
    else if (mode == "Minor 11th")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}m911-$speed-${shortstrings[image][notes[0].index][2].replaceAll(" ", "-")}";
    else if (mode == "m(maj11)")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}mmaj911-$speed-${shortstrings[image][notes[0].index][5].replaceAll(" ", "-")}";
    else if (mode == "11b5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}911b5-$speed-${shortstrings[image][notes[0].index][3].replaceAll(" ", "-")}";
    else if (mode == "11#5")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}911s5-$speed-${shortstrings[image][notes[0].index][4].replaceAll(" ", "-")}";
    else if (mode == "Add2")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}add2-$speed-${strings[image][notes[0].index][24].replaceAll(" ", "-")}";
    else //if (mode == "Add4")
      url =
          "${instrument.toLowerCase()}-${notes[0].note}add4-$speed-${strings[image][notes[0].index][25].replaceAll(" ", "-")}";
  }
  //print(url);
  if (!notes[0].note.contains("#"))
    return url.replaceAll("#", "s");
  else
    return url.replaceFirst("#", "s").replaceAll("#", "s");
}
