import 'package:flutter/material.dart';
import 'package:gym_buddy/authentication/auth.service.dart';
import 'package:gym_buddy/main.dart';
import 'package:gym_buddy/user_interaction_tracker.dart';

import '../interface/failed_auth.exception.dart' show AuthFailure;
import '../../extensions/snack_bar.extension.dart';

class AuthVM with ChangeNotifier {
  SupabaseAuthService authService;

  AuthVM({required this.authService});

  bool get isUserAuthenticated => authService.isUserAuthenticated;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authService.signInWithEmailAndPassword(
        email,
        password,
      );
      final userID = response?.user?.id;
      if (response?.user?.id != null) {
        UserInteractionTracker().amplitude?.setUserId(userID);
      }
      notifyListeners();
    } on AuthFailure catch (e) {
      navigatorKey.currentContext?.showToast(e.message);
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final response = await authService.signUpWithEmailAndPassword(email, password);
    final userID = response.user?.id;
    if (response.user?.id != null) {
      UserInteractionTracker().amplitude?.setUserId(userID);
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
