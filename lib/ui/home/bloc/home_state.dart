import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool isListView;

  const HomeState({required this.isListView});

  factory HomeState.initial() {
    return const HomeState(isListView: true);
  }

  HomeState copyWith({bool? isListView}) {
    return HomeState(
      isListView: isListView ?? this.isListView,
    );
  }

  @override
  List<Object> get props => [isListView];
}
