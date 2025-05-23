import 'dart:convert';

import 'package:scenario_maker_app/constants.dart';
import 'package:scenario_maker_app/models/scenario_request_model.dart';
import 'package:scenario_maker_app/models/scenario_result_model.dart';
import 'package:scenario_maker_app/services/dio_client.dart';

bool isEmailValid(String email) {
  return RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  ).hasMatch(email);
}

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email не может быть пустым';
  }
  if (!isEmailValid(email)) {
    return 'Введите корректный Email';
  }
  return null;
}

enum SocialPlatform { youtube, vk, tiktok, dzen, instagram }

Future<ScenarioResultModel> getScenario({
  required SocialPlatform socialPlatform,
  required String videoTheme,
  required String targetAudience,
  required String videoLength,
  required String contentStyle,
  required String callToAction,
  required DioClient client,
}) async {
  final scenarioPrompt = kScenarioPrompt
      .replaceAll('{platform}', socialPlatform.name)
      .replaceAll('{videoTheme}', videoTheme)
      .replaceAll('{targetAudience}', targetAudience)
      .replaceAll('{videoLength}', videoLength)
      .replaceAll('{contentStyle}', contentStyle)
      .replaceAll('{callToAction}', callToAction);
  String result = await client.getScenario(scenarioPrompt);
  result = result.substring(7, result.length - 3);

  final jsonResult = json.decode(result);
  jsonResult['id'] = DateTime.now().millisecondsSinceEpoch.toString();
  jsonResult['request'] =
      ScenarioRequestModel(
        platform: socialPlatform,
        videoTheme: videoTheme,
        targetAudience: targetAudience,
        videoLengthInSeconds: int.parse(videoLength),
        contentStyle: contentStyle,
        callToAction: callToAction,
      ).toJson();
  return ScenarioResultModel.fromJson(jsonResult);
}
