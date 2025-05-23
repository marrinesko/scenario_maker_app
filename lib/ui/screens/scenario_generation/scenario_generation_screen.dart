import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:scenario_maker_app/redux/actions.dart';
import 'package:scenario_maker_app/redux/state.dart';
import 'package:scenario_maker_app/services/dio_client.dart';
import 'package:scenario_maker_app/services/firebase_storage.dart';
import 'package:scenario_maker_app/services/helpers.dart';
import 'package:scenario_maker_app/ui/screens/scenario_generation/scenario_description_form.dart';
import 'package:scenario_maker_app/ui/screens/saved_scenarios/saved_scenarios_screen.dart';

class ScenarioGenerationScreen extends StatefulWidget {
  final String platformName;
  final String platformIcon;
  final Color platformColor;

  const ScenarioGenerationScreen({
    super.key,
    required this.platformName,
    required this.platformIcon,
    required this.platformColor,
  });

  @override
  State<ScenarioGenerationScreen> createState() =>
      _ScenarioGenerationScreenState();
}

class _ScenarioGenerationScreenState extends State<ScenarioGenerationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _themeController = TextEditingController();
  final _audienceController = TextEditingController();
  final _lengthController = TextEditingController();
  final _styleController = TextEditingController();
  final _actionController = TextEditingController();
  final _scrollController = ScrollController();
  final client = DioClient.instance;

  @override
  void dispose() {
    _themeController.dispose();
    _audienceController.dispose();
    _lengthController.dispose();
    _styleController.dispose();
    _actionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadScenario(Store<ScenarioState> store) async {
    if (_formKey.currentState!.validate()) {
      try {
        store.dispatch(LoadScenarioAction());

        final result = await getScenario(
          socialPlatform: SocialPlatform.values.firstWhere(
            (e) => e.name == widget.platformName.toLowerCase(),
            orElse: () => SocialPlatform.youtube,
          ),
          videoTheme: _themeController.text,
          targetAudience: _audienceController.text,
          videoLength: _lengthController.text,
          contentStyle: _styleController.text,
          callToAction: _actionController.text,
          client: client,
        );

        await FirebaseStorage().saveScenario(result);
        store.dispatch(LoadScenarioSuccessAction(result));

        // Отображаем SnackBar перед навигацией
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Сценарий успешно сгенерирован!'),
            backgroundColor: Colors.green,
            duration: const Duration(
              seconds: 2,
            ), // Уменьшим длительность, так как сразу переходим
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(bottom: 70, left: 16, right: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );

        // Добавляем задержку для того, чтобы SnackBar успел отобразиться,
        // затем переходим на экран сохраненных сценариев.
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            // Используем pushReplacement, чтобы нельзя было вернуться назад
            context,
            MaterialPageRoute(
              builder: (context) => const SavedScenariosScreen(),
            ),
          );
        });
      } catch (error) {
        store.dispatch(LoadScenarioFailureAction(error.toString()));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: ${error.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(bottom: 70, left: 16, right: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Генерация для ${widget.platformName}',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ScenarioDescriptionForm(
                  formKey: _formKey,
                  themeController: _themeController,
                  audienceController: _audienceController,
                  lengthController: _lengthController,
                  styleController: _styleController,
                  actionController: _actionController,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 24),
              child: StoreConnector<ScenarioState, bool>(
                converter:
                    (store) =>
                        store.state.loadingStatus == LoadingStatus.generating,
                builder: (context, isLoading) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          isLoading
                              ? null
                              : () => _loadScenario(
                                StoreProvider.of<ScenarioState>(context),
                              ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: widget.platformColor,
                      ),
                      child:
                          isLoading
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                              : const Text(
                                'Сгенерировать сценарий',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
