import 'package:flutter/material.dart';
import 'package:scenario_maker_app/ui/screens/scenario_generation/components/scenario_description_textfield.dart';

class ScenarioDescriptionForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController themeController;
  final TextEditingController audienceController;
  final TextEditingController lengthController;
  final TextEditingController styleController;
  final TextEditingController actionController;

  const ScenarioDescriptionForm({
    super.key,
    required this.formKey,
    required this.themeController,
    required this.audienceController,
    required this.lengthController,
    required this.styleController,
    required this.actionController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScenarioDescriptionTextField(
            controller: themeController,
            labelText: 'Тема видео',
            hintText: 'Например: Путешествия, Еда',
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите тему видео';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ScenarioDescriptionTextField(
            controller: audienceController,
            labelText: 'Целевая аудитория',
            hintText: 'Например: Подростки, Профессионалы',
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите целевую аудиторию';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ScenarioDescriptionTextField(
            controller: lengthController,
            labelText: 'Длительность видео (секунды)',
            hintText: 'Например: 15, 30, 60',
            isRequired: true,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите длительность';
              }
              if (int.tryParse(value) == null) {
                return 'Введите числовое значение';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ScenarioDescriptionTextField(
            controller: styleController,
            labelText: 'Стиль контента',
            hintText: 'Например: Информативный, Юмористический',
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите стиль контента';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ScenarioDescriptionTextField(
            controller: actionController,
            labelText: 'Призыв к действию',
            hintText: 'Например: Подписаться, Комментировать',
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите призыв к действию';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
