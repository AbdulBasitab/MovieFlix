import 'package:get_it/get_it.dart';
import 'package:movies_app/repositories/movie_repository.dart';
import 'package:movies_app/repositories/tv_show_repository.dart';
import 'package:movies_app/services/api_service.dart';
import 'package:movies_app/services/isar_service.dart';

final serviceLocator = GetIt.instance;

void initServiceLocator() {
  serviceLocator.registerLazySingleton<ApiService>(() => ApiService());
  serviceLocator.registerLazySingleton<IsarService>(() => IsarService());

  serviceLocator.registerLazySingleton<MovieRepository>(
    () => MovieRepository(
      serviceLocator<ApiService>(),
      serviceLocator<IsarService>(),
    ),
  );

  serviceLocator.registerLazySingleton<TvShowRepository>(
    () => TvShowRepository(
      serviceLocator<ApiService>(),
      serviceLocator<IsarService>(),
    ),
  );
}
