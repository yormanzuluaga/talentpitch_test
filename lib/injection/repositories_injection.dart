part of 'injection_container.dart';

void _initRepositoriesInjections() {
  sl.registerFactory<CategoryRepository>(() => CategoryRepositoryImpl(categoryResource: sl()));
  sl.registerFactory<VideoRepository>(() => VideoRepositoryImpl(videoResource: sl()));
}
