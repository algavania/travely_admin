import 'package:flutter/material.dart';

class AuthService {
  static String handleAuthErrorCodes(BuildContext context, String code) {
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return 'Email sudah digunakan';
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return 'Password salah';
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return 'User tidak ditemukan';
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return 'User tidak tersedia';
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return 'Terlalu banyak request';
      case "ERROR_OPERATION_NOT_ALLOWED":
        return 'Server error';
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return 'Email invalid';
      default:
        return 'Error';
    }
  }
}
