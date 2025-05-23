// reducers.dart
// Reducer для обработки действий и изменения состояния сценария

import 'package:scenario_maker_app/redux/actions.dart';
import 'package:scenario_maker_app/redux/state.dart';

ScenarioState scenarioReducer(ScenarioState state, dynamic action) {
  if (action is LoadScenarioAction) {
    // Начали генерацию: меняем статус на "генерация", обнуляем предыдущий результат и ошибку
    return state.copyWith(
      loadingStatus: LoadingStatus.generating,
      scenario: null,
      error: null,
    );
  } else if (action is LoadScenarioSuccessAction) {
    // Сценарий успешно сгенерирован: сохраняем результат и меняем статус
    return state.copyWith(
      loadingStatus: LoadingStatus.success,
      scenario: action.result,
      error: null,
    );
  } else if (action is LoadScenarioFailureAction) {
    // Ошибка генерации: сохраняем сообщение об ошибке и меняем статус
    return state.copyWith(
      loadingStatus: LoadingStatus.failure,
      error: action.error,
      scenario: null,
    );
  }
  // Если действие не распознано, возвращаем текущее состояние без изменений
  return state;
}
