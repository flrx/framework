import 'package:get_it/get_it.dart';

class ServiceLocator {
  final GetIt _serviceLocator = GetIt.I;

  static ServiceLocator? _instance;

  factory ServiceLocator() {
    _instance ??= ServiceLocator._();
    return _instance!;
  }

  ServiceLocator._();

  T get<T extends Object>([String? name]) =>
      _serviceLocator.get<T>(instanceName: name);

  void registerSingleton<T extends Object>(T instance, [String? name]) =>
      _serviceLocator.registerSingleton<T>(instance, instanceName: name);

  void registerLazySingleton<T extends Object>(T Function() instance,
          [String? name]) =>
      _serviceLocator.registerLazySingleton<T>(instance, instanceName: name);

  void registerLazy<T extends Object>(T Function() instance, [String? name]) =>
      _serviceLocator.registerFactory<T>(instance, instanceName: name);

  Future<void> reset() => _serviceLocator.reset();
}
