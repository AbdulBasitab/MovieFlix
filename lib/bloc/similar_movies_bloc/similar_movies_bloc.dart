import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/repositories/movie_repository.dart';

part 'similar_movies_state.dart';

class SimilarMoviesBloc extends Bloc<SimilarMoviesEvent, SimilarMoviesState> {
  SimilarMoviesBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(SimilarMoviesState(
            similarMovies: [], dataStatus: DataStatus.loading)) {
    on<FetchSimilarMovies>((event, emit) async {
      final similarMovies = await fetchSimilarMovies(event.movieId);
      if (similarMovies.isNotEmpty) {
        emit(state.copyWith(
            dataStatus: DataStatus.success, similarMovies: similarMovies));
      } else {
        emit(state.copyWith(
            dataStatus: DataStatus.error, similarMovies: similarMovies));
      }
    });
  }
  final MovieRepository _movieRepository;

  Future<List<Movie>> fetchSimilarMovies(int movieId) async {
    final similarMovies = await _movieRepository.fetchSimilarMovies(movieId);
    return similarMovies;
  }
}
