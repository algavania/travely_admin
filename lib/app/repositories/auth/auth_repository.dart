import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/database_service.dart';
import 'base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends BaseAuthRepository {
  late final FirebaseAuth _auth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _auth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get user => _auth.userChanges();

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<User> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthService.handleAuthErrorCodes(context, e.code);
    }
  }
}
