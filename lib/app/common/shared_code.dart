import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../main.dart';
import '../routes/router.gr.dart';
import '../widgets/custom_alert_dialog.dart';
import '../widgets/custom_error_dialog.dart';

class SharedCode {
  static const double defaultPadding = 16;

  String? emptyValidator(value) {
    return value.toString().trim().isEmpty ? 'Tidak boleh kosong' : null;
  }

  String? passwordValidator(value) {
    return value.toString().length < 6 ? 'Password harus kurang lebih 6 karakter' : null;
  }

  String? confirmPasswordValidator(String? value, String password) {
    if (value?.isEmpty ?? true) return 'Tidak boleh kosong';
    return value != password ? 'Password harus sama' : null;
  }

  String? emailValidator(value) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    return !emailValid ? 'Email tidak valid' : null;
  }

  static void showErrorDialog(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomErrorDialog(title: title, content: content);
        });
  }

  static void showSnackBar(BuildContext context, String status, String content,
      {Duration? duration}) {
    Color color = Colors.green;
    switch (status) {
      case 'success':
        color = Colors.green;
        break;
      case 'error':
        color = Colors.red;
        break;
    }
    SnackBar snackBar = SnackBar(
      content: Text(content, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      duration: duration ?? const Duration(milliseconds: 4000),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showAlertDialog(
      BuildContext context, String title, String content, Function onYesTap) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(title: title, content: content, onYesTap: onYesTap);
        });
  }

  Future<void> handleAuthenticationRouting(
      {required BuildContext context,
        bool isLogout = false,
        bool emailVerified = false}) async {
    AppRouter appRouter = MyApp.getAppRouter(context);
    if (isLogout) {
      await logout();
      Future.delayed(Duration.zero, () {
        context.loaderOverlay.hide();
        appRouter.pushAndPopUntil(const LoginRoute(), predicate: (Route<dynamic> route) => false);
      });
    } else {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        context.loaderOverlay.hide();
        if (user == null) {
          appRouter.pushAndPopUntil(const LoginRoute(), predicate: (Route<dynamic> route) => false);
        } else {
          appRouter.pushAndPopUntil(const NavigationRoute(), predicate: (Route<dynamic> route) => false);
        }
      });
    }

    if (context.loaderOverlay.visible) {
      context.loaderOverlay.hide();
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}