import 'package:equatable/equatable.dart';
import 'package:user_directory/domain/model/user.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class InitialHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadedHomeState extends HomeState {
  final List<User> userData;
  final int currentPage;
  final bool isLastPage;
  final bool isPaginationLoading;

  const LoadedHomeState({
      required this.userData, required this.currentPage, required this.isLastPage, required this.isPaginationLoading});

  LoadedHomeState copyWith(
      {List<User>? userData,
      int? currentPage,
      bool? isLastPage,
      bool? isPaginationLoading}) {
    return LoadedHomeState(
      userData: userData ?? this.userData,
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }

  @override
  List<Object> get props => [userData, currentPage, isLastPage, isPaginationLoading];
}

class LoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class FailedHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}
