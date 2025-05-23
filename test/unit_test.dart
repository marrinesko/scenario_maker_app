import 'package:flutter_test/flutter_test.dart';
import 'package:scenario_maker_app/services/helpers.dart';

void main() {
  group('validateEmail', () {
    test('возвращает ошибку, если адрес электронной почты равен нулю', () {
      expect(validateEmail(null), 'Email не может быть пустым');
    });
    test('возвращает ошибку, если адрес электронной почты пустой', () {
      expect(validateEmail(''), 'Email не может быть пустым');
    });
    test(
      'возвращает ошибку, если адрес электронной почты не содержит символ "@"',
      () {
        expect(validateEmail('wilddick.com'), 'Введите корректный Email');
      },
    );
  });
}
