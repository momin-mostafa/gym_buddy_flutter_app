import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext? {
  void showToast(String message) {
    if(this == null) return;
    ScaffoldMessenger.of(
      this!,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
