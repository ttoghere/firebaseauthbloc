// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:firebaseauthbloc/models/custom_error.dart';
import 'package:firebaseauthbloc/repositories/auth_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;
  SignInCubit(
    this.authRepository,
  ) : super(SignInState.inital());

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(signInStatus: SignInStatus.submiting));
    try {
      await authRepository.signIn(email: email, password: password);
      emit(state.copyWith(signInStatus: SignInStatus.success));
    } on CustomError catch (error) {
      log(error.toString());
      emit(
        state.copyWith(signInStatus: SignInStatus.error, customError: error),
      );
    }
  }
}
