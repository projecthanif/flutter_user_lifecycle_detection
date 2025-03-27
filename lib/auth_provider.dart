import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  late bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void inApp() {
    _isAuthenticated = true;
    notifyListeners();
  }

  void outOfApp() {
    _isAuthenticated = false;
    notifyListeners();
  }

}