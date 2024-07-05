import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String avatar;
  final String email;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.email,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, firstName, lastName, avatar, email];
}
