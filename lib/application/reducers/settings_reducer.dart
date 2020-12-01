import 'package:music_scales/application/actions/settings_action.dart';
import 'package:music_scales/domain/settings/settings.dart';

Settings settingsReducer(Settings state, dynamic action) {
  if (action.settingsActionType == SettingsActionType.setInstrument) {
    return state.copyWith(instrument: action.payload);
  }
  if (action.settingsActionType == SettingsActionType.setFastChordAudioSpeed) {
    return state.copyWith(fastChordAudioSpeed: action.payload);
  }
  if (action.settingsActionType == SettingsActionType.setShowFlatsInScales) {
    return state.copyWith(showFlatsInScales: action.payload);
  }
  if (action.settingsActionType == SettingsActionType.setSettings) {
    return action.payload;
  }

  return state;
}
