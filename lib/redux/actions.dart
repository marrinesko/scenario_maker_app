// actions.dart
// Определение Redux действий для загрузки сценария

import 'package:scenario_maker_app/models/scenario_result_model.dart';

// Запрос на начало генерации сценария
class LoadScenarioAction {}

// Успешное получение сценария
class LoadScenarioSuccessAction {
  final ScenarioResultModel result; // Данные сгенерированного сценария
  LoadScenarioSuccessAction(this.result);
}

// Ошибка при генерации сценария
class LoadScenarioFailureAction {
  final String error; // Текст ошибки
  LoadScenarioFailureAction(this.error);
}
