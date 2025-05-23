import 'package:flutter/material.dart';
import 'package:scenario_maker_app/services/auth.dart';
import 'package:scenario_maker_app/services/helpers.dart';
import 'package:scenario_maker_app/ui/screens/authorization/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passController;
  final _formKey = GlobalKey<FormState>();
  final authService = Auth();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Добро пожаловать!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Введите ваш Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  validator: validateEmail,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Введите пароль',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor:
                              Theme.of(context).primaryColor, // Цвет из темы
                          foregroundColor: Colors.white, // Цвет текста
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authService.signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passController.text,
                            );
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.login, size: 20),
                            SizedBox(width: 8),
                            Text('Войти', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Кнопка "Регистрация" с иконкой и другим стилем
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ), // Обводка
                          ),
                          backgroundColor: Colors.transparent, // Прозрачный фон
                          foregroundColor:
                              Theme.of(
                                context,
                              ).primaryColor, // Цвет текста как у основной кнопки
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authService.createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passController.text,
                            );
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_add, size: 20),
                            SizedBox(width: 8),
                            Text('Регистрация', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text('Забыл пароль?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
