import 'package:flutter/foundation.dart';

class Settings {
  String instrument;
  bool showFlatsInScales;
  bool fastChordAudioSpeed;
  Settings({
    @required this.instrument,
    @required this.showFlatsInScales,
    @required this.fastChordAudioSpeed,
  });

  Settings copyWith({
    String instrument,
    bool showFlatsInScales,
    bool fastChordAudioSpeed,
  }) {
    return Settings(
      instrument: instrument ?? this.instrument,
      showFlatsInScales: showFlatsInScales ?? this.showFlatsInScales,
      fastChordAudioSpeed: fastChordAudioSpeed ?? this.fastChordAudioSpeed,
    );
  }

  @override
  String toString() =>
      'Settings(instrument: $instrument, showFlatsInScales: $showFlatsInScales, fastChordAudioSpeed: $fastChordAudioSpeed)';
}
