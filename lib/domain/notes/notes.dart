class Note {
  String note;
  int index;
  Note(this.note, this.index);

  @override
  String toString() => 'Note(note: $note, index: $index)';
}

List<Note> notes = [
  Note("A", 0),
  Note("A#", 1),
  Note("B", 2),
  Note("C", 3),
  Note("C#", 4),
  Note("D", 5),
  Note("D#", 6),
  Note("E", 7),
  Note("F", 8),
  Note("F#", 9),
  Note("G", 10),
  Note("G#", 11),
];

class SNote extends Note {
  String note;
  String bemolle;
  int index;
  int audioindex;
  bool isBemolle = false;
  SNote(this.note, this.index, this.audioindex, this.bemolle)
      : super(note, index);

  @override
  String toString() {
    return 'SNote(note: $note, bemolle: $bemolle, index: $index, audioindex: $audioindex, isBemolle: $isBemolle)';
  }
}

List<SNote> sNotes = [
  SNote("A", 0, 0, ""),
  SNote("A#", 1, 0, "Bb"),
  SNote("B", 2, 0, "Cb"),
  SNote("C", 3, 0, "B#"),
  SNote("C#", 4, 0, "Db"),
  SNote("D", 5, 0, ""),
  SNote("D#", 6, 0, "Eb"),
  SNote("E", 7, 0, "Fb"),
  SNote("F", 8, 0, "E#"),
  SNote("F#", 9, 0, "Gb"),
  SNote("G", 10, 0, ""),
  SNote("G#", 11, 0, "Ab"),
];
