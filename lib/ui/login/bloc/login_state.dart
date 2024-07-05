import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isObscure;

  const LoginState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.isObscure = false,
  });

  factory LoginState.empty() {
    return const LoginState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isObscure: false,
    );
  }

  LoginState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isObscure,
  }) {
    return LoginState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isObscure: isObscure ?? this.isObscure,
    );
  }

  @override
  List<Object> get props =>
      [isSubmitting, isSuccess, isFailure, isObscure];
}
