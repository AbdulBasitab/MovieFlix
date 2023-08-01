part of 'similar_movies_bloc.dart';

enum DataStatus { success, error, loading }

class SimilarMoviesState {
  final DataStatus? dataStatus;
  final String? errorMessage;
  final List<Movie> similarMovies;
  SimilarMoviesState({
    this.dataStatus,
    this.errorMessage,
    required this.similarMovies,
  });

  SimilarMoviesState copyWith({
    DataStatus? dataStatus,
    String? errorMessage,
    List<Movie>? similarMovies,
  }) {
    return SimilarMoviesState(
      dataStatus: dataStatus ?? this.dataStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      similarMovies: similarMovies ?? this.similarMovies,
    );
  }
}

abstract class SimilarMoviesEvent {
  SimilarMoviesEvent();
}

class FetchSimilarMovies extends SimilarMoviesEvent {
  final int movieId;
  FetchSimilarMovies({
    required this.movieId,
  });
}
