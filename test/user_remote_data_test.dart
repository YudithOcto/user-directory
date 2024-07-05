import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:user_directory/common/constants.dart';
import 'package:user_directory/data/network/network_services.dart';
import 'package:user_directory/data/user/user_remote_data_source.dart';

import 'user_remote_data_test.mocks.dart'; // Adjust import path as needed

class MockNetworkService extends Mock implements NetworkService {}

@GenerateMocks([MockNetworkService])
void main() {
  late DefaultUserRemoteDataSource dataSource;
  MockNetworkService mockNetworkService = MockMockNetworkService();

  setUp(() {
    dataSource =
        DefaultUserRemoteDataSource(mockNetworkService);
  });

  tearDown(() {
    // Clean up after tests if needed
  });

  group('login', () {
    test('returns token on successful login', () async {
      // Arrange
      final email = 'test@example.com';
      final password = 'password';
      final tokenResponse = {'token': 'test_token'};

      when(mockNetworkService.post(Constants.loginUrl, data: anyNamed('data')))
          .thenAnswer((_) async =>
              Response(data: tokenResponse, requestOptions: RequestOptions()));

      // Act
      final result = await dataSource.login(email, password);

      // Assert
      expect(result, equals('test_token'));
    });

    test('returns error message on failed login', () async {
      // Arrange
      final email = 'test@example.com';
      final password = 'password';
      final errorMessage = 'Login failed';
      final expectedError = Exception(errorMessage);

      // Mocking the network service to throw an exception when login is called
      when(mockNetworkService.post(Constants.loginUrl, data: anyNamed('data')))
          .thenThrow(expectedError);

      // Act
      Future<String> loginFuture = dataSource.login(email, password);

      // Assert
      expect(loginFuture, throwsA(isInstanceOf<Exception>()));
    });
  });

  group('getUsers', () {
    test('returns UserDto on successful API call', () async {
      // Arrange
      final page = 1;
      final userDtoResponse = {
        'page': 1,
        'totalPage': 10,
        'data': [
          {'id': 1, 'first_name': 'Test User'}
        ]
      };

      when(mockNetworkService.get(Constants.getUsersUrl,
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
              data: userDtoResponse, requestOptions: RequestOptions()));

      // Act
      final result = await dataSource.getUsers(page);

      // Assert
      expect(result.users?.first.id, equals(1));
      expect(result.users?.first.avatar, equals(''));
      expect(result.users?.first.firstName, equals('Test User'));
    });

    test('throws exception on failed API call', () {
      // Arrange
      final page = 1;
      final errorMessage = 'Failed to fetch users';

      when(mockNetworkService.get(Constants.getUsersUrl,
              queryParameters: anyNamed('queryParameters')))
          .thenThrow(Exception(errorMessage));

      // Act & Assert
      expect(() => dataSource.getUsers(page), throwsException);
    });
  });
}
