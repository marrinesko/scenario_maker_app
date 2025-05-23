import 'dart:convert';
import 'package:scenario_maker_app/models/scenario_result_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScenarioStorage {
  static const String _kScenarioKey = 'scenario';
  Future<void> saveScenario(ScenarioResultModel scenario) async {
    final prefs = await SharedPreferences.getInstance();
    final scenarioJson = json.encode(scenario.toJson());
    await prefs.setString(_kScenarioKey, scenarioJson);
  }

  Future<ScenarioResultModel?> loadScenario() async {
    final prefs = await SharedPreferences.getInstance();
    final scenarioJson = prefs.getString(_kScenarioKey);
    if (scenarioJson == null) return null;
    return ScenarioResultModel.fromJson(json.decode(scenarioJson));
  }
}
