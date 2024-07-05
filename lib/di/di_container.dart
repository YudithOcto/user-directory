import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:user_directory/data/user/user_remote_data_source.dart';
import 'package:user_directory/data/local/storage_service.dart';
import 'package:user_directory/data/network/network_services.dart';
import 'package:user_directory/domain/repository/user_repository.dart';
import 'package:user_directory/services/dio_services.dart';
import 'package:user_directory/services/hive_storage_services.dart';
import 'package:user_directory/ui/home/bloc/home_bloc.dart';
import 'package:user_directory/ui/login/bloc/login_bloc.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // Register Dio
  final options = BaseOptions(
      baseUrl: "https://reqres.in/api",
      receiveTimeout: const Duration(milliseconds: 5000),
      maxRedirects: 3,
      connectTimeout: const Duration(milliseconds: 5000));

  final dio = Dio(options);
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    request: true,
    error: true,
  ));
  dio.transformer = BackgroundTransformer();
  dio.options.contentType = Headers.formUrlEncodedContentType;

  // Register Third Party
  locator.registerSingleton<Dio>(dio);
  final storageServices = HiveStorageService();
  await storageServices.init();
  locator.registerLazySingleton<StorageService>(() => storageServices);

  // Register NetworkService
  locator.registerSingleton<NetworkService>(
      DioService(locator<Dio>(), locator<StorageService>()));

  // Register DataSource
  locator.registerSingleton<UserRemoteDataSource>(
      DefaultUserRemoteDataSource(locator<NetworkService>()));

  // Register Repository
  locator.registerSingleton<UserRepository>(DefaultUserRepository(
      locator<UserRemoteDataSource>(), locator<StorageService>()));

  // Register Bloc
  locator
      .registerSingleton<LoginBloc>(LoginBloc(locator<UserRemoteDataSource>()));
  locator.registerSingleton<HomeBloc>(HomeBloc());
}
