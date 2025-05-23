// main.dart
// Точка входа приложения Flutter и настройка Redux и Firebase

import 'package:firebase_auth/firebase_auth.dart'; // Для аутентификации пользователей
import 'package:firebase_core/firebase_core.dart'; // Для инициализации Firebase
import 'package:flutter/material.dart'; // Базовые виджеты Flutter
import 'package:flutter_redux/flutter_redux.dart'; // Провайдер Redux для Flutter
import 'package:scenario_maker_app/redux/store.dart'; // Наш хранилище Redux
import 'package:scenario_maker_app/services/auth.dart'; // Сервис аутентификации
import 'package:scenario_maker_app/ui/home_screen.dart'; // Экран главной страницы
import 'package:scenario_maker_app/ui/screens/authorization/login_screen.dart'; // Экран логина

void main() async {
  // Обеспечиваем корректную инициализацию виджетов перед асинхронными операциями
  WidgetsFlutterBinding.ensureInitialized();
  // Инициализируем Firebase SDK
  await Firebase.initializeApp();
  // Запускаем приложение
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      // Передаём наше хранилище Redux виджетам приложения
      store: store,
      child: MaterialApp(
        title: 'Scenario Maker App',
        theme: ThemeData(
          // Настройки темы приложения
          scaffoldBackgroundColor: Colors.white, // Фон Scaffold
          canvasColor: Colors.white, // Фон Material-виджетов
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white, // Фон AppBar
            elevation: 0, // Без тени
            iconTheme: IconThemeData(color: Colors.black), // Цвет иконок
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ), // Стиль текста заголовка
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white, // Фон нижней навигации
            selectedItemColor: Colors.blue, // Цвет выбранного пункта
            unselectedItemColor: Colors.grey, // Цвет невыбранных пунктов
          ),
        ),
        // В зависимости от состояния аутентификации показываем Home или Login
        home: StreamBuilder<User?>(
          stream: Auth().getAuthStateChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Если пользователь авторизован, показываем главный экран
              return const HomeScreen();
            } else {
              // Иначе — экран логина
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
