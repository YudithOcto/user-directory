import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_directory/data/user/user_remote_data_source.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRemoteDataSource _authRemoteDataSource;
  LoginBloc(this._authRemoteDataSource) : super(LoginState.empty()) {
    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      final result =
          await _authRemoteDataSource.login(event.email, event.password);
      if (result.isNotEmpty) {
        emit(state.copyWith(
            isSubmitting: false, isSuccess: true, isFailure: false));
      } else {
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
