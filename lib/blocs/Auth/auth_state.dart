// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

enum AuthStatus {
  unknown,
  unAuthenticated,
  authenticated,
}

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final fbAuth.User? user;
  const AuthState({
    required this.authStatus,
    this.user,
  });

  @override
  List<Object?> get props => [authStatus, user];

  AuthState copyWith({
    AuthStatus? authStatus,
    fbAuth.User? user,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }

  factory AuthState.initial() {
    return const AuthState(authStatus: AuthStatus.unknown);
  }

  @override
  String toString() {
    "AuthState(authStatus:$authStatus, user:$user)";
    return super.toString();
  }
}
