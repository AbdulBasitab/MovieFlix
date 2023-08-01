import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/repositories/movie_repository.dart';

part 'watch_provider_state.dart';

class WatchProviderBloc extends Bloc<WatchProviderEvent, WatchProviderState> {
  WatchProviderBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(WatchProviderState(
          dataStatus: DataStatus.loading,
        )) {
    on<FetchWatchProviders>((event, emit) async {
      final movieWatchProviders = await fetchMovieWatchProviders(event.movieId);
      if (movieWatchProviders != null) {
        emit(state.copyWith(
            dataStatus: DataStatus.success,
            movieWatchProvider: movieWatchProviders));
      } else {
        emit(state.copyWith(
            dataStatus: DataStatus.error,
            movieWatchProvider: movieWatchProviders));
      }
    });
  }
  final MovieRepository _movieRepository;

  Future<WatchProvider?> fetchMovieWatchProviders(int movieId) async {
    final movieWatchProviders =
        await _movieRepository.fetchMoviesWatchProviders(movieId);
    return movieWatchProviders;
  }
}
