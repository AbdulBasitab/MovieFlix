import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/repositories/movie_repository.dart';

part 'recommended_movies_state.dart';

class RecommendedMoviesBloc
    extends Bloc<RecommendedMoviesEvent, RecommendedMoviesState> {
  RecommendedMoviesBloc({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(RecommendedMoviesState(
          dataStatus: DataStatus.loading,
          recommendedMovies: [],
        )) {
    on<FetchRecommendedMovies>((event, emit) async {
      final recommendedMovies = await fetchRecommendedMovies(event.movieId);
      if (recommendedMovies.isNotEmpty) {
        emit(state.copyWith(
            dataStatus: DataStatus.success,
            recommendedMovies: recommendedMovies));
      } else {
        emit(state.copyWith(
            dataStatus: DataStatus.error,
            recommendedMovies: recommendedMovies,
            errorMessage: 'Failed to load recommended movies'));
      }
    });
  }
  final MovieRepository _movieRepository;

  Future<List<Movie>> fetchRecommendedMovies(int movieId) async {
    final recommendedMovies =
        await _movieRepository.fetchRecommendedMovies(movieId);
    return recommendedMovies;
  }
}
