part of 'injection_container.dart';

void _initResourcesInjections() {
  sl.registerFactory<CategoryResource>(() => CategoryResource(
        apiClient: sl(),
      ));
  sl.registerFactory<VideoResource>(() => VideoResource(
        apiClient: sl(),
      ));
}
