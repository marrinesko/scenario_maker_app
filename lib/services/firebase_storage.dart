import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scenario_maker_app/models/scenario_result_model.dart';
import 'package:scenario_maker_app/services/auth.dart';

class FirebaseStorage {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveScenario(ScenarioResultModel scenarioResult) async {
    final userId = Auth().getUserId;
    if (userId != null) {
      // проверка существования пользователя
      await _db
          .collection(userId)
          .doc(scenarioResult.id)
          .set(scenarioResult.toJson());
    } else {
      // что делать, если юзер не существует
      throw Exception('Пользователь не аутентифицирован');
    }
  }

  Future<void> deleteScenario(String documentId) async {
    final userId = Auth().getUserId;

    if (userId != null) {
      await _db.collection(userId).doc(documentId).delete(); // удаление
    } else {
      throw Exception('Пользователь не аутентифицирован');
    }
  }

  Stream<List<ScenarioResultModel>> getScenariosStream() {
    final userId = Auth().getUserId;

    if (userId != null) {
      return _db
          .collection(userId)
          .snapshots()
          .map(
            //получаем результат
            (snapshot) =>
                snapshot.docs.map(
                  // преобразуем результат в документ
                  (doc) {
                    return ScenarioResultModel.fromJson(
                      // каждый сценарий превращаем в модель результата
                      doc.data(),
                    );
                  },
                ).toList(), // преобразуем полученный результат в лист
          );
    } else {
      throw Exception('User not authenticated');
    }
  }
}
