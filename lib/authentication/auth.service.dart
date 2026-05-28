import 'dart:developer';

import 'package:gym_buddy/authentication/interface/auth.interfaces.dart';
import 'package:gym_buddy/authentication/interface/failed_auth.exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService implements AuthInterface {
  final _auth = Supabase.instance.client.auth;

  bool get isUserAuthenticated => _auth.currentUser != null;

  @override
  Future<AuthResponse?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithPassword(password: password, email: email);
    } on AuthApiException catch (e, st) {
      log("signInWithEmailAndPassword.AuthApiException : ${e.message}", error: e, stackTrace: st);
      throw AuthFailure(message: e.message, error: e, stackTrace: st);
    } catch (e, st) {
      log("signInWithEmailAndPassword failed", error: e, stackTrace: st);
      return null;
    }
  }

  @override
  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _auth.signUp(password: password, email: email);
  }

  @override
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  @override
  Future<String?> getUserEmail() async {
    final session = _auth.currentSession;
    final User? user = session?.user;
    return user?.email;
  }
}
