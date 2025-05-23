import 'package:dio/dio.dart';

const String baseUrl = 'https://api.proxyapi.ru/openai/v1/chat/completions';
const String apiKey = 'sk-vZgTVm2Ts2UrzOKg6eolg6FCmV9zUjYs';

class DioClient {
  DioClient._();

  static final DioClient instance = DioClient._();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<String> getScenario(String userMessage) async {
    try {
      final Map<String, dynamic> data = {
        'model': 'gpt-4o-mini',
        'messages': [
          {'role': 'user', 'content': userMessage},
        ],
        'max_tokens': 500,
        'temperature': 0.7,
      };
      final Response response = await _dio.post('', data: data);
      if (response.statusCode == 200) {
        return response.data['choices'][0]['message']['content'] ??
            'Ответ не получен.';
      }
      throw 'Не удалось сгенерировать ответ';
    } catch (e) {
      throw 'Error $e';
    }
  }
}
