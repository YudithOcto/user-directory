import 'package:equatable/equatable.dart';
import 'package:user_directory/data/user/model/user_dto.dart';
import 'package:user_directory/domain/model/user.dart';

class UserPaginated extends Equatable {
  int page;
  int totalPage;
  List<User> users;

  UserPaginated(
      {required this.page, required this.totalPage, required this.users});

  @override
  List<Object?> get props => [page, totalPage, users];
}

UserPaginated userPaginatedfromDto(UserDto userDto) {
  return UserPaginated(
      page: userDto.page ?? 0,
      totalPage: userDto.totalPage ?? 0,
      users: userDto.users
              ?.map((e) => User(
                  id: e.id ?? 0,
                  firstName: e.firstName ?? "",
                  lastName: e.lastName ?? "",
                  avatar: e.avatar ?? "",
                  email: e.email ?? ""))
              .toList() ??
          []);
}
