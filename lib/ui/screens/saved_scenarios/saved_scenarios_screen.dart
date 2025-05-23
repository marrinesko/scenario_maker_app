import 'package:flutter/material.dart';
import 'package:scenario_maker_app/models/scenario_result_model.dart';
import 'package:scenario_maker_app/services/auth.dart';
import 'package:scenario_maker_app/services/firebase_storage.dart';
import 'package:scenario_maker_app/ui/screens/saved_scenarios/components/scenario_item.dart';
import 'package:scenario_maker_app/ui/screens/saved_scenarios/components/stub.dart';
import 'package:share_plus/share_plus.dart';

class SavedScenariosScreen extends StatefulWidget {
  const SavedScenariosScreen({super.key});

  @override
  State<SavedScenariosScreen> createState() => _SavedScenariosScreenState();
}

class _SavedScenariosScreenState extends State<SavedScenariosScreen>
    with AutomaticKeepAliveClientMixin<SavedScenariosScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Сохраненные сценарии'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Auth().signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<ScenarioResultModel>>(
        stream: FirebaseStorage().getScenariosStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Stub(
              text: 'Ошибка ${snapshot.error}',
              icon: Icons.warning,
              iconColor: Colors.red[800],
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final scenarios = snapshot.data!;
            if (scenarios.isEmpty) {
              return Stub(
                text: 'Нет сохраненных сценариев\nСгенерируйте новый сценарий',
                icon: Icons.dangerous,
                iconColor: Colors.yellow[800],
              );
            }
            return ListView.builder(
              itemCount: scenarios.length, // сколько сценариев получили
              itemBuilder: (context, index) {
                final scenario = scenarios[index];
                return ScenarioItem(
                  scenario: scenario,
                  onDelete: () => FirebaseStorage().deleteScenario(scenario.id),
                  onShare: () => Share.share(scenario.body),
                );
              },
            );
          } else {
            return Stub(
              text: 'Нет доступных данных',
              icon: Icons.dangerous,
              iconColor: Colors.red[800],
            );
          }
        },
      ),
    );
  }
}
