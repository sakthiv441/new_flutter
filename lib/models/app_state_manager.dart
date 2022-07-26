import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _loggedIn = false;
  bool _onboardingComplete = false;
  int _selectedtab = 0;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  set isLoggedIn(bool isLoggedIn) => isLoggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedtab => _selectedtab;

  void intializeApp() {
    Timer(const Duration(milliseconds: 2000), () {
      _initialized = true;
      notifyListeners();
    });
  }

  void completeOnboarding() {
    _onboardingComplete = true;
    notifyListeners();
  }

  void logininfo(String name, String password) {
    _loggedIn = true;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    _onboardingComplete = false;
    _initialized = false;
    _selectedtab = 0;
    intializeApp();
    notifyListeners();
  }
}
