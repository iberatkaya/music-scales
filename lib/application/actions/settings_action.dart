import 'package:flutter/foundation.dart';

enum SettingsActionType {
  setInstrument,
  setFastChordAudioSpeed,
  setShowFlatsInScales,
  setSettings,
}

class SettingsAction {
  SettingsActionType settingsActionType;
  dynamic payload;
  SettingsAction({
    @required this.settingsActionType,
    @required this.payload,
  });
}
