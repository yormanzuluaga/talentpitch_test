part of 'injection_container.dart';

void _initNetworkInjections(void Function(dynamic, StackTrace?)? onError) {
  sl.registerLazySingleton<ApiClient>(() => ApiClient(onError: onError));
}
