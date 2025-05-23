import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scenario_maker_app/ui/screens/scenario_generation/components/generate_scenario_title.dart';

void main() {
  testWidgets(
    'GenerateScenarioTitle отображает заголовок, описание, SVG-иконку и стрелку',
    (WidgetTester tester) async {
      const tileKey = Key('generate_tile');
      const title = 'Test Title';
      const description = 'Test Description';
      const assetPath = 'assets/icons/test.svg';
      const backgroundColor = Colors.green;
      const iconBgColor = Colors.yellow;
      const borderColor = Colors.red;
      const iconColor = Colors.blue;
      const textColor = Colors.purple;

      // Строим виджет в контексте MaterialApp + Scaffold
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GenerateScenarioTitle(
              key: tileKey,
              title: title,
              description: description,
              assetPath: assetPath,
              backgroundColor: backgroundColor,
              iconBackgroundColor: iconBgColor,
              borderColor: borderColor,
              iconColor: iconColor,
              textColor: textColor,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Находит сам контейнер по ключу
      expect(find.byKey(tileKey), findsOneWidget);
      // Проверяем текст
      expect(find.text(title), findsOneWidget);
      expect(find.text(description), findsOneWidget);
      // Проверяем стрелку в конце
      expect(find.byIcon(Icons.arrow_forward_ios_rounded), findsOneWidget);
      // Проверяем, что отрисовалась SVG-иконка
      expect(find.byType(SvgPicture), findsOneWidget);

      // Проверяем цвета в AnimatedContainer
      final animatedContainer = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.byKey(tileKey),
          matching: find.byType(AnimatedContainer),
        ),
      );
      final decoration = animatedContainer.decoration as BoxDecoration;
      expect(decoration.color, backgroundColor);
      // Граница — это Border, проверяем верхнюю сторону
      final border = (decoration.border as Border).top;
      expect(border.color, borderColor);
    },
  );

  testWidgets('GenerateScenarioTitle вызывает onTap при нажатии', (
    WidgetTester tester,
  ) async {
    bool tapped = false;
    const tileKey = Key('tappable_tile');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GenerateScenarioTitle(
            key: tileKey,
            title: 'Tap Test',
            description: 'Tap Description',
            assetPath: 'assets/icons/test.svg',
            backgroundColor: Colors.white,
            iconBackgroundColor: Colors.grey,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    // Тапаем по всему виджету
    await tester.tap(find.byKey(tileKey));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });
}
