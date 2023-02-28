// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebaseauthbloc/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final StreamSubscription authSubscription;
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthState.initial()) {
    authSubscription = authRepository.user.listen((fbAuth.User? user) {
      add(AuthStateChangedEvent(user: user));
    });
    on<AuthStateChangedEvent>(_authChanged);
    on<SignOutRequestedEvent>(_signOutEvent);
  }

  void _authChanged(AuthStateChangedEvent event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(
        state.copyWith(
          user: event.user,
          authStatus: AuthStatus.authenticated,
        ),
      );
    } else {
      emit(
        state.copyWith(
          user: null,
          authStatus: AuthStatus.unAuthenticated,
        ),
      );
    }
  }

  void _signOutEvent(
      SignOutRequestedEvent event, Emitter<AuthState> emit) async {
    await authRepository.signOut();
  }
}
