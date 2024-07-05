import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:user_directory/common/constants.dart';
import 'package:user_directory/data/local/storage_service.dart';
import 'package:user_directory/data/user/model/user_dto.dart';
import 'package:user_directory/data/user/user_remote_data_source.dart';
import 'package:user_directory/domain/model/user_paginated.dart';
import 'package:user_directory/domain/repository/user_repository.dart';
import 'package:mockito/annotations.dart';

import 'user_repository_test.mocks.dart';

// Mock class for UserRemoteDataSource
class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

// Mocking the repository to focus on caller testing
class MockUserRepository extends Mock implements UserRepository {}

class MockStorageService extends Mock implements StorageService {}

@GenerateMocks([MockUserRemoteDataSource, MockStorageService])
void main() {
  MockUserRemoteDataSource mockRemoteDataSource =
      MockMockUserRemoteDataSource();
  late DefaultUserRepository userRepository;
  MockStorageService mockStorageService = MockMockStorageService();

  group('fetchUserList', () {
    setUp(() {
      userRepository =
          DefaultUserRepository(mockRemoteDataSource, mockStorageService);
    });

    test('returns user list on success', () async {
      // Arrange
      final expectedUsers = UserDto(page: 0, totalPage: 0, users: [
        UserDetailDto(
            id: 1,
            firstName: "name",
            lastName: "name",
            email: "email.@gmail.com",
            avatar: "avatar.jpg")
      ]);
      final expectedResult = userPaginatedfromDto(expectedUsers);

      when(mockRemoteDataSource.getUsers(1))
          .thenAnswer((_) async => expectedUsers);

      // Act
      final result = await userRepository.getUserList(1);

      // Assert
      expect(result.page, equals(expectedResult.page));
      expect(result.totalPage, equals(expectedResult.totalPage));
      expect(result.users, equals(expectedResult.users));
    });

    test('throws an exception on error', () async {
      // Arrange
      when(mockRemoteDataSource.getUsers(1))
          .thenThrow(Exception('Failed to fetch users'));

      // Act
      expect(
        () async => await userRepository.getUserList(1),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('login', () {
    setUp(() {
      userRepository =
          DefaultUserRepository(mockRemoteDataSource, mockStorageService);
    });

    test('returns token on successful login', () async {
      // Arrange
      const expectedToken = "test_token";

      when(mockRemoteDataSource.login("email", "password"))
          .thenAnswer((_) async => expectedToken);

      // Act
      final result = await userRepository.login("email", "password");

      // Assert
      expect(result, equals(expectedToken));
      verify(mockStorageService.saveData(Constants.bearerToken, 'test_token'))
          .called(1);
    });

    test('throws an exception on error', () async {
      // Arrange
      when(mockRemoteDataSource.login("email", "password"))
          .thenThrow(Exception('Failed to login'));

      // Act
      expect(
        () async => await userRepository.login("email", "password"),
        throwsA(isA<Exception>()),
      );
      verifyNever(
          mockStorageService.saveData(Constants.bearerToken, 'test_token'));
    });
  });
}
