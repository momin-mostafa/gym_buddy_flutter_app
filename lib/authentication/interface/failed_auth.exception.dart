class AuthFailure implements Exception {
  String message;
  dynamic error;
  StackTrace stackTrace;

  AuthFailure({
    required this.message,
    required this.error,
    required this.stackTrace,
  });
}
