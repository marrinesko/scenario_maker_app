// state.dart
// Содержит модель состояния для сценария и возможные статусы загрузки

import 'package:scenario_maker_app/models/scenario_result_model.dart';

// Возможные статусы процесса генерации сценария
enum LoadingStatus { defaultStatus, generating, success, failure, loading }

class ScenarioState {
  final LoadingStatus loadingStatus; // Текущий статус
  final ScenarioResultModel? scenario; // Сохранённый результат, если успешно
  final String? error; // Текст ошибки, если генерация провалилась

  ScenarioState({
    this.loadingStatus = LoadingStatus.defaultStatus,
    this.scenario,
    this.error,
  });

  // Метод для копирования состояния с возможностью изменения отдельных полей
  ScenarioState copyWith({
    LoadingStatus? loadingStatus,
    ScenarioResultModel? scenario,
    String? error,
  }) {
    return ScenarioState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      scenario: scenario ?? this.scenario,
      error: error ?? this.error,
    );
  }
}
