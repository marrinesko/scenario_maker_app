
# ScenarioMakerApp

Мобильное приложение на Flutter для генерации сценариев коротких видео. Поддерживает аутентификацию через Firebase, генерацию текстов с помощью OpenAI API и сохранение сценариев в облаке.

---

## 📱 Поддерживаемые платформы

- **Android**
  - Минимальная версия: Android 5.0 (API 21)
  - Рекомендуемая версия Flutter: `>=3.10.0 <4.0.0`
  - iOS не поддерживается (в данной версии проекта)

---

## 🔌 Используемые библиотеки и их назначение

| Библиотека             | Назначение                                                                 |
|------------------------|----------------------------------------------------------------------------|
| `firebase_core`        | Инициализация Firebase                                                     |
| `firebase_auth`        | Аутентификация пользователей                                               |
| `cloud_firestore`      | Облачное хранение сгенерированных сценариев                                |
| `dio`                  | HTTP-запросы к внешнему API (например, OpenAI) через прокси                |
| `redux`, `flutter_redux`| Управление состоянием через Redux                                         |
| `shared_preferences`   | Кэширование данных на устройстве                                           |
| `share_plus`           | Возможность поделиться сценарием через сторонние приложения                |
| `flutter_svg`          | Отображение SVG-иконок в UI                                                |

---

## 🛠 Инструкция по сборке и публикации (Android)

### 1. Установка зависимостей

```bash
flutter pub get
```

### 2. Подготовка Android-подписи (один раз)

1. Создайте keystore (если ещё нет):

```bash
keytool -genkey -v \
  -keystore ~/keystores/scenario.jks \
  -alias scenario_maker_app \
  -keyalg RSA -keysize 2048 -validity 10000
```

2. Создайте файл `android/key.properties`:

```
storePassword=ваш_пароль
keyPassword=ваш_ключевой_пароль
keyAlias=scenario_maker_app
storeFile=/полный/путь/к/файлу/scenario.jks
```

3. Убедитесь, что `android/app/build.gradle.kts` содержит правильную конфигурацию `signingConfigs`.

### 3. Сборка релизной версии

```bash
flutter clean
flutter pub get
flutter build appbundle --release
```

Файл `.aab` появится в:

```
build/app/outputs/bundle/release/app-release.aab
```

### 4. Публикация в Google Play

1. Перейдите в [Google Play Console](https://play.google.com/console)
2. Создайте новое приложение (или обновите существующее)
3. Загрузите `.aab` в **Production release**
4. Укажите описание, номер версии и скриншоты
5. Пройдите проверки (контент, возраст, политика конфиденциальности и т. д.)
6. Отправьте на модерацию

---

## 📌 Примечание

- Все действия с Firebase предполагают, что файл `google-services.json` уже добавлен в `android/app`.
- Для сборки на macOS под iOS потребуется Xcode и устройство/симулятор.

---

## 🔗 Полезные ссылки

- [Документация Flutter](https://docs.flutter.dev)
- [Firebase для Flutter](https://firebase.google.com/docs/flutter/setup)
- [Публикация приложения](https://docs.flutter.dev/deployment/android)
