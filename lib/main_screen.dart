import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_provider.dart';
import 'auth_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Lifecycle Demo')),
          body: Center(
            child: auth.isAuthenticated
                ? const Text('Monitor app background/foreground transitions')
                : const Text('Monitor app came from background'),
          ),
        );
      },
    );
  }
}
