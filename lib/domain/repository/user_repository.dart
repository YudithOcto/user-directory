import 'package:user_directory/common/extensions.dart';
import 'package:user_directory/data/local/storage_service.dart';
import 'package:user_directory/data/user/user_remote_data_source.dart';
import 'package:user_directory/domain/model/user_paginated.dart';

abstract class UserRepository {
  Future<UserPaginated> getUserList(int page);
  Future<String> login(String email, String password);
}

class DefaultUserRepository extends UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  final StorageService _localService;

  DefaultUserRepository(this._userRemoteDataSource, this._localService);

  @override
  Future<UserPaginated> getUserList(int page) async {
    return await _userRemoteDataSource
        .getUsers(page)
        .then((value) => userPaginatedfromDto(value));
  }

  @override
  Future<String> login(String email, String password) async {
    try {
      String token = await _userRemoteDataSource.login(email, password);
      if (token.isNotNullOrEmpty) {
        _localService.saveData("token", token);
      }
      return token;
    } catch (e) {
      rethrow;
    }
  }
}
