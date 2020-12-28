import 'package:get_it/get_it.dart';

class ServiceLocator {
  final GetIt _serviceLocator = GetIt.instance;

  T get<T>([String name]) => _serviceLocator.get<T>(instanceName: name);

  void registerSingleton<T>(T instance, [String name]) =>
      _serviceLocator.registerSingleton<T>(instance, instanceName: name);

  void registerLazySingleton<T>(T Function() instance, [String name]) =>
      _serviceLocator.registerLazySingleton<T>(instance, instanceName: name);

  void registerLazy<T>(T Function() instance, [String name]) =>
      _serviceLocator.registerFactory<T>(instance, instanceName: name);
}
