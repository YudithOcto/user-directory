// Mocks generated by Mockito 5.4.4 from annotations
// in user_directory/test/user_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;
import 'package:user_directory/data/user/model/user_dto.dart' as _i2;

import 'user_repository_test.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUserDto_0 extends _i1.SmartFake implements _i2.UserDto {
  _FakeUserDto_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MockUserRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMockUserRemoteDataSource extends _i1.Mock
    implements _i3.MockUserRemoteDataSource {
  MockMockUserRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<String> login(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            email,
            password,
          ],
        ),
        returnValue: _i4.Future<String>.value(_i5.dummyValue<String>(
          this,
          Invocation.method(
            #login,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<String>);

  @override
  _i4.Future<_i2.UserDto> getUsers(int? page) => (super.noSuchMethod(
        Invocation.method(
          #getUsers,
          [page],
        ),
        returnValue: _i4.Future<_i2.UserDto>.value(_FakeUserDto_0(
          this,
          Invocation.method(
            #getUsers,
            [page],
          ),
        )),
      ) as _i4.Future<_i2.UserDto>);
}

/// A class which mocks [MockStorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockMockStorageService extends _i1.Mock
    implements _i3.MockStorageService {
  MockMockStorageService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> saveData<T>(
    String? key,
    T? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveData,
          [
            key,
            value,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<T?> getData<T>(String? key) => (super.noSuchMethod(
        Invocation.method(
          #getData,
          [key],
        ),
        returnValue: _i4.Future<T?>.value(),
      ) as _i4.Future<T?>);

  @override
  _i4.Future<void> deleteData(String? key) => (super.noSuchMethod(
        Invocation.method(
          #deleteData,
          [key],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> clearAll() => (super.noSuchMethod(
        Invocation.method(
          #clearAll,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}