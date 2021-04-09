import 'package:music_scales/domain/notes/notes.dart';

///Set the table number headers based on the [mode].
List<String> updateTableNums(String mode) {
  List<String> nums = ["1", "2", "3", "4", "5", "6", "7"];
  if (mode == "Minor") {
    nums[2] = "b3";
    nums[5] = "b6";
    nums[6] = "b7";
  } else if (mode == "Blues") {
    nums[1] = "b3";
    nums[2] = "4";
    nums[3] = "#4";
    nums[4] = "5";
    nums[5] = "b7";
  } else if (mode == "Melodic Minor")
    nums[2] = "b3";
  else if (mode == "Harmonic Minor") {
    nums[2] = "b3";
    nums[5] = "b6";
  } else if (mode == "Dorian") {
    nums[2] = "b3";
    nums[6] = "b7";
  } else if (mode == "Mixolydian")
    nums[6] = "b7";
  else if (mode == "Lydian")
    nums[3] = "#4";
  else if (mode == "Phrygian") {
    nums[1] = "b2";
    nums[2] = "b3";
    nums[5] = "b6";
    nums[6] = "b7";
  } else if (mode == "Aeolian") {
    nums[2] = "b3";
    nums[5] = "b6";
    nums[6] = "b7";
  } else if (mode == "Locrian") {
    nums[1] = "b2";
    nums[2] = "b3";
    nums[4] = "b5";
    nums[5] = "b6";
    nums[6] = "b7";
  } else if (mode == "Locrian 2") {
    nums[2] = "b3";
    nums[4] = "b5";
    nums[5] = "b6";
    nums[6] = "b7";
  } else if (mode == "Major Pentatonic") {
    nums[3] = "5";
    nums[4] = "6";
  } else if (mode == "Minor Pentatonic") {
    nums[1] = "b3";
    nums[2] = "4";
    nums[3] = "5";
    nums[4] = "b7";
  } else if (mode == "Augmented") {
    nums[1] = "b3";
    nums[3] = "5";
    nums[4] = "#5";
    nums[5] = "7";
  } else if (mode == "Double Harmonic") {
    nums[1] = "b2";
    nums[5] = "b6";
  } else if (mode == "Altered") {
    nums[1] = "b2";
    nums[2] = "b3";
    nums[3] = "b4";
    nums[4] = "b5";
    nums[5] = "b6";
    nums[6] = "b7";
  } else if (mode == "Altered bb7") {
    nums[1] = "b2";
    nums[2] = "b3";
    nums[3] = "b4";
    nums[4] = "b5";
    nums[5] = "b6";
    nums[6] = "bb7";
  } else if (mode == "Dorian b2") {
    nums[1] = "b2";
    nums[2] = "b3";
    nums[6] = "b7";
  } else if (mode == "Augmented Lydian") {
    nums[3] = "#4";
    nums[4] = "#5";
  } else if (mode == "Lydian b7") {
    nums[3] = "#4";
    nums[6] = "b7";
  } else if (mode == "Mixolydian b6") {
    nums[5] = "b6";
    nums[6] = "b7";
  } else if (mode == "Locrian 6") {
    nums[1] = "b2";
    nums[2] = "b3";
    nums[4] = "b5";
    nums[6] = "b7";
  } else if (mode == "Augmented Ionian")
    nums[4] = "#5";
  else if (mode == "Dorian #4") {
    nums[2] = "b3";
    nums[3] = "#4";
    nums[6] = "b7";
  } else if (mode == "Major Phrygian") {
    nums[1] = "b2";
    nums[5] = "b6";
    nums[6] = "b7";
  } else if (mode == "Lydian #9") {
    nums[1] = "#2";
    nums[3] = "#4";
  } else if (mode == "Diminished Lydian") {
    nums[2] = "b3";
    nums[3] = "#4";
  } else if (mode == "Minor Lydian") {
    nums[3] = "#4";
    nums[5] = "b6";
    nums[6] = "b7";
  } else if (mode == "Arabian") {
    nums[4] = "#4";
    nums[5] = "#5";
    nums[6] = "b7";
  } else if (mode == "Balinese") {
    nums[1] = "b2";
    nums[2] = "b3";
    nums[3] = "5";
    nums[4] = "b6";
  } else if (mode == "Byzantine") {
    nums[1] = "b2";
    nums[5] = "b6";
  } else if (mode == "Chinese") {
    nums[1] = "3";
    nums[2] = "#4";
    nums[3] = "5";
    nums[4] = "7";
  } else if (mode == "Egyptian") {
    nums[2] = "4";
    nums[3] = "5";
    nums[4] = "b7";
  } else if (mode == "Mongolian") {
    nums[3] = "5";
    nums[4] = "6";
  } else if (mode == "Hindu") {
    nums[5] = "b6";
    nums[6] = "b7";
  } else if (mode == "Neopolitan") {
    nums[1] = "b2";
    nums[2] = "b3";
    nums[5] = "b6";
  } else if (mode == "Neopolitan Major") {
    nums[1] = "b2";
    nums[2] = "b3";
  } else if (mode == "Neopolitan Minor") {
    nums[1] = "b2";
    nums[2] = "b3";
    nums[5] = "b6";
    nums[6] = "b7";
  } else if (mode == "Persian") {
    nums[1] = "b2";
    nums[4] = "b5";
    nums[5] = "b6";
  }
  return nums;
}

///Create the url for the scale based on the [mode], [notes], and [instrument].
String urlScale(String mode, List<SNote> notes, String instrument) {
  String url;
  String n_or_sharp;
  if (!notes[0].note.contains("#"))
    n_or_sharp = "n";
  else
    n_or_sharp = "sharp";
  if (mode == "Minor")
    url = "$instrument-natural_minor-${notes[0].note[0]}-$n_or_sharp";
  else if (mode.contains(" ")) {
    url =
        "$instrument-${mode.toLowerCase().replaceFirst(" ", "_").replaceFirst("#", "s")}-${notes[0].note[0]}-$n_or_sharp";
  } else
    url = "$instrument-${mode.toLowerCase()}-${notes[0].note[0]}-$n_or_sharp";
  //print(url);
  return url;
}
