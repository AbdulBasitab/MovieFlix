import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/repositories/movie_repository.dart';

part 'movie_reviews_state_event.dart';

class MovieReviewsBloc extends Bloc<MovieReviewsEvent, MovieReviewsState> {
  MovieReviewsBloc({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(MovieReviewsState(
          dataStatus: DataStatus.loading,
          movieReviews: [],
        )) {
    on<FetchMovieReviews>(
        (event, emit) => fetchMovieReviews(event.movieId, emit));
  }
  final MovieRepository _movieRepository;

  Future<void> fetchMovieReviews(
      int movieId, Emitter<MovieReviewsState> emit) async {
    // emit(state.copyWith(dataStatus: DataStatus.loading));
    var movieReviews = await _movieRepository.fetchMovieReviews(movieId);

    if (movieReviews.isNotEmpty) {
      emit(state.copyWith(
          movieReviews: movieReviews, dataStatus: DataStatus.success));
    } else {
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: "Failed to load reviews"));
    }
  }
}
