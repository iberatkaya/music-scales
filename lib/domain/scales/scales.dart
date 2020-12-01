class Scale {
  String name;
  int index;
  List<int> formula;
  Scale(this.name, this.index, this.formula);

  @override
  String toString() => 'Scale(name: $name, index: $index, formula: $formula)';
}

List<Scale> scales = [
  //A A# B C C# D D# E F F# G G#
  Scale("Major", 0, [2, 2, 1, 2, 2, 2]),
  Scale("Minor", 1, [2, 1, 2, 2, 1, 2]),
  Scale("Major Pentatonic", 12, [2, 2, 3, 2]),
  Scale("Minor Pentatonic", 13, [3, 2, 2, 3]),
  Scale("Blues", 2, [3, 2, 1, 1, 3]),
  Scale("Harmonic Minor", 3, [2, 1, 2, 2, 1, 3]),
  Scale("Melodic Minor", 4, [2, 1, 2, 2, 2, 2]),
  Scale("Ionian", 5, [2, 2, 1, 2, 2, 2]),
  Scale("Dorian", 6, [2, 1, 2, 2, 2, 1]),
  Scale("Mixolydian", 7, [2, 2, 1, 2, 2, 1]),
  Scale("Lydian", 8, [2, 2, 2, 1, 2, 2]),
  Scale("Phrygian", 9, [1, 2, 2, 2, 1, 2]),
  Scale("Aeolian", 10, [2, 1, 2, 2, 1, 2]),
  Scale("Locrian", 11, [1, 2, 2, 1, 2, 2]),
  Scale("Augmented", 14, [3, 1, 3, 1, 3]),
  Scale("Double Harmonic", 15, [1, 3, 1, 2, 1, 3]),
  Scale("Altered", 16, [1, 2, 1, 2, 2, 2]),
  Scale("Altered bb7", 39, [1, 2, 1, 2, 2, 1]),
  Scale("Dorian b2", 17, [1, 2, 2, 2, 2, 1]),
  Scale("Augmented Lydian", 18, [2, 2, 2, 2, 1, 2]),
  Scale("Lydian b7", 19, [2, 2, 2, 1, 2, 1]),
  Scale("Mixolydian b6", 20, [2, 2, 1, 2, 1, 2]),
  Scale("Locrian 6", 21, [1, 2, 2, 1, 3, 1]),
  Scale("Locrian 2", 40, [2, 1, 2, 1, 2, 2]),
  Scale("Augmented Ionian", 22, [2, 2, 1, 3, 1, 2]),
  Scale("Dorian #4", 23, [2, 1, 3, 1, 2, 1]),
  Scale("Major Phrygian", 24, [1, 3, 1, 2, 1, 2]),
  Scale("Lydian #9", 25, [3, 1, 2, 1, 2, 2]),
  Scale("Diminished Lydian", 26, [2, 1, 3, 1, 2, 2]),
  Scale("Minor Lydian", 27, [2, 2, 2, 1, 1, 2]),
  Scale("Arabian", 28, [2, 2, 1, 1, 2, 2]),
  Scale("Balinese", 29, [1, 2, 3, 2]),
  Scale("Byzantine", 30, [1, 3, 1, 2, 1, 3]),
  Scale("Chinese", 31, [4, 2, 1, 4]),
  Scale("Egyptian", 32, [2, 3, 2, 3]),
  Scale("Mongolian", 33, [2, 2, 3, 2]),
  Scale("Hindu", 34, [2, 2, 1, 2, 1, 2]),
  Scale("Neopolitan", 35, [1, 2, 2, 2, 1, 3]),
  Scale("Neopolitan Major", 36, [1, 2, 2, 2, 2, 2]),
  Scale("Neopolitan Minor", 37, [1, 2, 2, 2, 1, 2]),
  Scale("Persian", 38, [1, 3, 1, 1, 2, 3]) //Continue from 41
];

class ScaleandKey {
  String note;
  String scale;
  int index;
  ScaleandKey(this.note, this.scale, this.index);

  @override
  String toString() => 'ScaleandKey(note: $note, scale: $scale, index: $index)';
}
