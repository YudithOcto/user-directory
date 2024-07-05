import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_directory/domain/repository/user_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  LoginBloc(this._userRepository) : super(LoginState.empty()) {
    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      try {
        await _userRepository.login(event.email, event.password);
        emit(state.copyWith(
            isSubmitting: false, isSuccess: true, isFailure: false));
      } catch (e) {
        emit(state.copyWith(
            isSubmitting: false, isSuccess: false, isFailure: true));
      }
    });
    on<PasswordVisibilityChanged>((event, emit) {
      final currentState = state.copyWith(isObscure: !state.isObscure);
      emit(currentState);
    });
  }
}
