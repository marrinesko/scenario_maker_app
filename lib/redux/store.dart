// store.dart
// Создаёт и экспортирует экземпляр Redux Store для всего приложения

import 'package:redux/redux.dart';
import 'package:scenario_maker_app/redux/reducers.dart';
import 'package:scenario_maker_app/redux/state.dart';

// Инициализация хранилища с начальным состоянием ScenarioState()
final store = Store<ScenarioState>(
  scenarioReducer,
  initialState: ScenarioState(),
);
