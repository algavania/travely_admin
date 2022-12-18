import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../repositories/auth/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit(this._authRepository) : super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  void changeStatusToInitial() {
    emit(state.copyWith(status: LoginStatus.initial));
  }

  Future<void> login(BuildContext context) async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    if (state.email != 'admin@gmail.com') throw 'User bukan admin';
    await _authRepository.login(email: state.email, password: state.password, context: context);
    emit(state.copyWith(status: LoginStatus.success));
  }
}
