class Chord {
  String note;
  int index;
  List<int> formula;
  Chord(this.note, this.index, this.formula);

  @override
  String toString() => 'Chord(note: $note, index: $index, formula: $formula)';
}

class SmallChord {
  String name;
  String mode;
  int index;
  SmallChord(this.name, this.mode, this.index);

  @override
  String toString() => 'SmallChord(name: $name, mode: $mode, index: $index)';
}

List<Chord> chords = [
  //A A# B C C# D D# E F F# G G#
  Chord("Major", 0, [4, 3]),
  Chord("Minor", 1, [3, 4]),
  Chord("Sus2", 3, [2, 5]),
  Chord("Sus4", 4, [5, 2]),
  Chord("Diminished", 7, [3, 3]),
  Chord("Augmented", 8, [4, 4]),
  Chord("7th", 6, [4, 3, 3]),
  Chord("Major 7th", 2, [4, 3, 4]),
  Chord("Minor 7th", 5, [3, 4, 3]),
  Chord("m(maj7)", 27, [3, 4, 4]),
  Chord("m7b5", 13, [3, 3, 4]),
  Chord("m7#5", 21, [3, 5, 2]),
  Chord("7b5", 15, [4, 2, 4]),
  Chord("7#5", 16, [4, 4, 2]),
  Chord("Diminished 7th", 14, [3, 3, 3]),
  Chord("Add2", 30, [2, 2, 3]),
  Chord("Add4", 31, [4, 1, 2]),
  Chord("6th", 10, [4, 3, 2]),
  Chord("Minor 6th", 11, [3, 4, 2]),
  Chord("6th/9th", 12, [4, 3, 2, 5]),
  Chord("9th", 9, [4, 3, 3, 4]),
  Chord("Major 9th", 18, [4, 3, 4, 3]), //A A# B C C# D D# E F F# G G#
  Chord("Minor 9th", 17, [3, 4, 3, 4]),
  Chord("m(maj9)", 28, [3, 4, 4, 3]),
  Chord("9b5", 20, [4, 2, 4, 4]),
  Chord("9#5", 19, [4, 4, 2, 4]),
  Chord("11th", 22, [4, 3, 3, 4, 3]),
  Chord("Major 11th", 23, [4, 3, 4, 3, 3]),
  Chord("Minor 11th", 24, [3, 4, 3, 4, 3]),
  Chord("m(maj11)", 29, [3, 4, 4, 3, 3]),
  Chord("11b5", 25, [4, 2, 4, 4, 3]),
  Chord("11#5", 26, [4, 4, 2, 4, 3]) //Continue from 32
];

class ChordNote {
  String note;
  int index;
  int audioindex;
  ChordNote(this.note, this.index, this.audioindex);
}

List<ChordNote> chordNotes = [
  ChordNote("A", 0, 0),
  ChordNote("A#", 1, 0),
  ChordNote("B", 2, 0),
  ChordNote("C", 3, 0),
  ChordNote("C#", 4, 0),
  ChordNote("D", 5, 0),
  ChordNote("D#", 6, 0),
  ChordNote("E", 7, 0),
  ChordNote("F", 8, 0),
  ChordNote("F#", 9, 0),
  ChordNote("G", 10, 0),
  ChordNote("G#", 11, 0),
];

List<SmallChord> majorChords = [
  SmallChord("A", "M", 0),
  SmallChord("A#", "M", 1),
  SmallChord("B", "M", 2),
  SmallChord("C", "M", 3),
  SmallChord("C#", "M", 4),
  SmallChord("D", "M", 5),
  SmallChord("D#", "M", 6),
  SmallChord("E", "M", 7),
  SmallChord("F", "M", 8),
  SmallChord("F#", "M", 9),
  SmallChord("G", "M", 10),
  SmallChord("G#", "M", 11),
];
List<SmallChord> minorChords = [
  SmallChord("Am", "m", 0),
  SmallChord("A#m", "m", 1),
  SmallChord("Bm", "m", 2),
  SmallChord("Cm", "m", 3),
  SmallChord("C#m", "m", 4),
  SmallChord("Dm", "m", 5),
  SmallChord("D#m", "m", 6),
  SmallChord("Em", "m", 7),
  SmallChord("Fm", "m", 8),
  SmallChord("F#m", "m", 9),
  SmallChord("Gm", "m", 10),
  SmallChord("G#m", "m", 11),
];
List<SmallChord> dimChords = [
  SmallChord("Adim", "dim", 0),
  SmallChord("A#dim", "dim", 1),
  SmallChord("Bdim", "dim", 2),
  SmallChord("Cdim", "dim", 3),
  SmallChord("C#dim", "dim", 4),
  SmallChord("Ddim", "dim", 5),
  SmallChord("D#dim", "dim", 6),
  SmallChord("Edim", "dim", 7),
  SmallChord("Fdim", "dim", 8),
  SmallChord("F#dim", "dim", 9),
  SmallChord("Gdim", "dim", 10),
  SmallChord("G#dim", "dim", 11),
];

List<Chord> searchChords = [
  //A A# B C C# D D# E F F# G G#
  Chord("Major", 0, [4, 3]),
  Chord("Minor", 1, [3, 4]),
  Chord("Sus2", 3, [2, 5]),
  Chord("Sus4", 4, [5, 2]),
  Chord("Diminished", 7, [3, 3]),
  Chord("Augmented", 8, [4, 4]),
  Chord("7th", 6, [4, 3, 3]),
  Chord("Major 7th", 2, [4, 3, 4]),
  Chord("Minor 7th", 5, [3, 4, 3]),
  Chord("m(maj7)", 27, [3, 4, 4]),
  Chord("m7b5", 13, [3, 3, 4]),
  Chord("m7#5", 21, [3, 5, 2]),
  Chord("7b5", 15, [4, 2, 4]),
  Chord("7#5", 16, [4, 4, 2]),
  Chord("Diminished 7th", 14, [3, 3, 3]),
  Chord("Add2", 30, [2, 2, 3]),
  Chord("Add4", 31, [4, 1, 2]),
  Chord("6th", 10, [4, 3, 2]),
  Chord("Minor 6th", 11, [3, 4, 2]),
  Chord("6th/9th", 12, [4, 3, 2, 5]),
  Chord("9th", 9, [4, 3, 3, 4]),
  Chord("Major 9th", 18, [4, 3, 4, 3]), //A A# B C C# D D# E F F# G G#
  Chord("Minor 9th", 17, [3, 4, 3, 4]),
  Chord("m(maj9)", 28, [3, 4, 4, 3]),
  Chord("9b5", 20, [4, 2, 4, 4]),
  Chord("9#5", 19, [4, 4, 2, 4]),
  Chord("11th", 22, [4, 3, 3, 4, 3]),
  Chord("Major 11th", 23, [4, 3, 4, 3, 3]),
  Chord("Minor 11th", 24, [3, 4, 3, 4, 3]),
  Chord("m(maj11)", 29, [3, 4, 4, 3, 3]),
  Chord("11b5", 25, [4, 2, 4, 4, 3]),
  Chord("11#5", 26, [4, 4, 2, 4, 3]) //Continue from 32
];
