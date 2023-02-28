// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_cubit.dart';

enum SignInStatus {
  initial,
  submiting,
  success,
  error,
}

class SignInState extends Equatable {
  final SignInStatus signInStatus;
  final CustomError customError;
const  SignInState({
    required this.signInStatus,
    required this.customError,
  });

  factory SignInState.inital() {
    return const SignInState(
      signInStatus: SignInStatus.initial,
      customError: CustomError(),
    );
  }

  @override
  List<Object> get props => [signInStatus, customError];

  SignInState copyWith({
    SignInStatus? signInStatus,
    CustomError? customError,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      customError: customError ?? this.customError,
    );
  }

  @override
  String toString() {
    "SignInState(signInStatus: $signInStatus,customError: $customError)";
    return super.toString();
  }
}
