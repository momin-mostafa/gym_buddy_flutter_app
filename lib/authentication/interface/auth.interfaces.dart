abstract class AuthInterface<T> {
  Future signInWithEmailAndPassword(String email, String password);

  Future signUpWithEmailAndPassword(String email, String password);

  Future<void> signOut();

  Future<String?> getUserEmail();

  bool get isUserAuthenticated;
}

class AuthenticationDTO {}
