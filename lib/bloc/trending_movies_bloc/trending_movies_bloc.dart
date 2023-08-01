import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/repositories/movie_repository.dart';

part 'trending_movies_state.dart';

class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  TrendingMoviesBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(TrendingMoviesState(
          dataStatus: DataStatus.loading,
          errorMessage: '',
          trendingMovies: [],
        )) {
    on<FetchTrendingMovies>((event, emit) async {
      final trendMovies = await fetchTrendingMovies();
      if (trendMovies.isNotEmpty) {
        emit(state.copyWith(
            trendingMovies: trendMovies, dataStatus: DataStatus.success));
      } else {
        emit(
          state.copyWith(
              dataStatus: DataStatus.error,
              errorMessage:
                  'Failed to fetch Movies.Check your Internet Connection and Try Again'),
        );
      }
    });
  }

  final MovieRepository _movieRepository;

  Future<List<Movie>> fetchTrendingMovies() async {
    final trendMovies = await _movieRepository.fetchTrendingMovies();

    return trendMovies;
  }
}
