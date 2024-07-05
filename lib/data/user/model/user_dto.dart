class UserDto {
  int? page;
  int? totalPage;
  List<UserDetailDto>? users;

  UserDto({
    this.page,
    this.totalPage,
    this.users,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
        page: json['page'] ?? 0,
        totalPage: json['total_pages'] ?? 0,
        users: json['data'] == null
            ? []
            : (json['data'] as List<dynamic>)
                .map((e) => UserDetailDto.fromJson(e))
                .toList());
  }
}

class UserDetailDto {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UserDetailDto(
      {this.id, this.email, this.firstName, this.lastName, this.avatar});

  factory UserDetailDto.fromJson(Map<String, dynamic> json) {
    return UserDetailDto(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}
