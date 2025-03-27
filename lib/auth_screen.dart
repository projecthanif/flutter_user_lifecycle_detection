import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_lifecycle_app/auth_provider.dart';
import 'package:user_lifecycle_app/main_screen.dart';
import 'package:user_lifecycle_app/widgets/app_input_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String email = 'projechanif@gmail.com';
  final String password = 'password';

  _authLogin() {
    debugPrint("logging in");

    Provider.of<AuthProvider>(context, listen: false).inApp();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MainScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          AppInputWidget(
            controller: emailController,
          ),
          AppInputWidget(
            controller: passwordController,
          ),
          ElevatedButton(
            onPressed: _authLogin,
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}
