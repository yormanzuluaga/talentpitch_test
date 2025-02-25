part of 'injection_container.dart';

void _initBlocsInjections() {
  sl.registerFactory(
    () => CategoryBloc(categoryRepository: sl()),
  );
  sl.registerFactory(
    () => VideoBloc(videoRepository: sl()),
  );
}
