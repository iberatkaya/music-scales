import 'package:music_scales/application/reducers/settings_reducer.dart';
import 'package:music_scales/domain/settings/settings.dart';
import 'package:redux/redux.dart';

final Store<Settings> store = Store<Settings>(settingsReducer,
    initialState: Settings(
        fastChordAudioSpeed: true,
        instrument: "Piano",
        showFlatsInScales: false));
