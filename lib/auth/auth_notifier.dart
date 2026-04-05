import 'package:flutter/foundation.dart';

import 'app_user.dart';
import 'auth_service.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier(this._service);

  final AuthService _service;

  AppUser? _user;
  bool _initialised = false;

  AppUser? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get initialised => _initialised;

  /// Called once on app start (from SplashScreen) to restore any existing session.
  Future<void> initialise() async {
    _user = await _service.getStoredUser();
    _initialised = true;
    notifyListeners();
  }

  Future<void> login() async {
    _user = await _service.login();
    notifyListeners();
  }

  Future<void> logout() async {
    await _service.logout();
    _user = null;
    notifyListeners();
  }

  Future<String?> getAccessToken() => _service.getAccessToken();
}
