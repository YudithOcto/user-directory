import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends HomeEvent {
  final int nextPage;
  const LoadDataEvent({required this.nextPage});

  @override
  List<Object> get props => [];
}
