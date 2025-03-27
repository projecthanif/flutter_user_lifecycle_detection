import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_lifecycle_app/auth_screen.dart';
import 'package:user_lifecycle_app/main_screen.dart';
import 'package:user_lifecycle_app/widgets/app_input_widget.dart';

import 'auth_provider.dart';

void main() {
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  DateTime? _lastInactiveTime;
  final ValueNotifier<bool> _isAppInBackground = ValueNotifier(false);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        _handleAppInactive();
        break;
      case AppLifecycleState.paused:
        _handleAppPaused();
        break;
      case AppLifecycleState.resumed:
        _handleAppResumed();
        break;
      case AppLifecycleState.detached:
        _handleAppDetached();
        break;
      case AppLifecycleState.hidden:
        _handleAppHidden();
        break;
    }
  }

  void _handleAppInactive() {
    // App is still visible but not receiving input (e.g., showing a system dialog)
    _lastInactiveTime = DateTime.now();
    debugPrint('App became inactive at $_lastInactiveTime');
  }

  void _handleAppHidden() {
    // App is still visible but not receiving input (e.g., showing a system dialog)
    _lastInactiveTime = DateTime.now();
    debugPrint('App became hidden at $_lastInactiveTime');
  }

  void _handleAppPaused() {
    // App is completely obscured (user pressed home button or switched apps)
    _isAppInBackground.value = true;
    debugPrint('App went to background');

    // Perform background tasks (save state, pause media, etc.)
    _saveAppState();
  }

  void _handleAppResumed() {
    // App is back in foreground
    if (_isAppInBackground.value) {
      final duration = _lastInactiveTime != null
          ? DateTime.now().difference(_lastInactiveTime!)
          : Duration.zero;

      debugPrint(
          'App returned from background after ${duration.inSeconds} seconds');
      _isAppInBackground.value = false;

      // Restore app state if needed
      _restoreAppState();
    }
  }

  void _handleAppDetached() {
    // Rare case - app is about to be destroyed
    debugPrint('App detached from Flutter engine');
  }

  // Example methods for state management
  void _saveAppState() {
    Provider.of<AuthProvider>(context, listen: false).outOfApp();
  }

  void _restoreAppState() {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        body: MainScreen(),
      ),
    );
  }
}
