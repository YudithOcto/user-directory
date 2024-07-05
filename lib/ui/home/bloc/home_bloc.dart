import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_directory/domain/model/user.dart';
import 'package:user_directory/domain/repository/user_repository.dart';
import 'package:user_directory/ui/home/bloc/home_event.dart';
import 'package:user_directory/ui/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepository;

  HomeBloc(this._userRepository) : super(InitialHomeState()) {
    on<LoadDataEvent>((event, emit) async {
      if (event.nextPage == 1) {
        emit(LoadingState());
      }
      try {
        final result = await _userRepository.getUserList(event.nextPage);
        List<User> users = (state is LoadedHomeState)
            ? (state as LoadedHomeState).userData
            : [];
        users.addAll(result.users);
        emit(LoadedHomeState(
            userData: users,
            currentPage: event.nextPage,
            isLastPage: result.page == result.totalPage,
            isPaginationLoading: false));
      } catch (e) {
        emit(FailedHomeState());
      }
    });
  }
}
