// scenario_request_model.dart
// Модель данных для запроса генерации сценария

import 'package:scenario_maker_app/services/helpers.dart'; // Здесь определён enum SocialPlatform

class ScenarioRequestModel {
  final SocialPlatform
  platform; // Социальная платформа (TikTok, Instagram и т.д.)
  final String videoTheme; // Тема видео
  final String targetAudience; // Целевая аудитория
  final int videoLengthInSeconds; // Длина видео в секундах
  final String contentStyle; // Стиль подачи контента
  final String callToAction; // Призыв к действию в конце видео

  ScenarioRequestModel({
    required this.platform,
    required this.videoTheme,
    required this.targetAudience,
    required this.videoLengthInSeconds,
    required this.contentStyle,
    required this.callToAction,
  });

  // Преобразование в JSON для отправки на сервер
  Map<String, dynamic> toJson() {
    return {
      'platform': platform.toString(),
      'videoTheme': videoTheme,
      'targetAudience': targetAudience,
      'videoLengthInSeconds': videoLengthInSeconds,
      'contentStyle': contentStyle,
      'callToAction': callToAction,
    };
  }

  // Создание модели из JSON-данных, полученных с сервера
  static ScenarioRequestModel fromJson(Map<String, dynamic> json) {
    return ScenarioRequestModel(
      platform: SocialPlatform.values.firstWhere(
        (e) => e.toString() == json['platform'],
      ),
      videoTheme: json['videoTheme'],
      targetAudience: json['targetAudience'],
      videoLengthInSeconds: json['videoLengthInSeconds'],
      contentStyle: json['contentStyle'],
      callToAction: json['callToAction'],
    );
  }
}
