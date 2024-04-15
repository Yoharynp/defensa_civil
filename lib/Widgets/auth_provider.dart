import 'package:defensa_civil/Screens/Extras/funciton_login.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  void setToken(String? token) {
    _token = token;
    notifyListeners();
  }

  void removeToken() {
    _token = null;
    AuthService().logout();
    notifyListeners();
  }
}
