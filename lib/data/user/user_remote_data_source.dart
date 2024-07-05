import 'package:user_directory/common/constants.dart';
import 'package:user_directory/common/error_message_utils.dart';
import 'package:user_directory/common/extensions.dart';
import 'package:user_directory/data/local/storage_service.dart';
import 'package:user_directory/data/network/network_services.dart';
import 'package:user_directory/data/user/model/user_dto.dart';

abstract class UserRemoteDataSource {
  Future<String> login(String email, String password);
  Future<UserDto> getUsers(int page);
}

class DefaultUserRemoteDataSource extends UserRemoteDataSource {
  final NetworkService _networkService;

  DefaultUserRemoteDataSource(this._networkService);

  @override
  Future<String> login(String email, String password) async {
    try {
      final result = await _networkService.post(Constants.loginUrl, data: {
        "email": email,
        "password": password,
      });
      return result.data['token'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDto> getUsers(int page) async {
    try {
      final result =
          await _networkService.get(Constants.getUsersUrl, queryParameters: {
        "page": page,
      });
      return UserDto.fromJson(result.data);
    } catch (e) {
      rethrow;
    }
  }
}
