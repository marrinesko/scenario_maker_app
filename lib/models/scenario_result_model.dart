// scenario_result_model.dart
// Модель данных для полученного результата генерации сценария

import 'package:scenario_maker_app/models/scenario_request_model.dart'; // Запрос, на основе которого сгенерировали сценарий

class ScenarioResultModel {
  final String id; // Уникальный идентификатор результата
  final String title; // Заголовок сценария (тема)
  final String body; // Основное содержание сценария
  final ScenarioRequestModel request; // Оригинальный запрос

  ScenarioResultModel({
    required this.id,
    required this.title,
    required this.body,
    required this.request,
  });

  // Преобразование результата в JSON для хранения или отправки
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'request': request.toJson(),
    };
  }

  // Создание модели результата из JSON-данных
  static ScenarioResultModel fromJson(Map<String, dynamic> json) {
    return ScenarioResultModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      request: ScenarioRequestModel.fromJson(json['request']),
    );
  }
}
