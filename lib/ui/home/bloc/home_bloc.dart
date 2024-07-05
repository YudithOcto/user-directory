import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_directory/ui/home/bloc/home_event.dart';
import 'package:user_directory/ui/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<ToggleView>((event, emit) {
      emit(state.copyWith(isListView: !state.isListView));
    });
  }
}
