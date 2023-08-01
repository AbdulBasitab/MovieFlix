// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recommended_movies_bloc.dart';

enum DataStatus { success, error, loading }

class RecommendedMoviesState {
  final DataStatus? dataStatus;
  final String? errorMessage;
  final List<Movie> recommendedMovies;
  RecommendedMoviesState({
    this.dataStatus,
    this.errorMessage,
    required this.recommendedMovies,
  });

  RecommendedMoviesState copyWith({
    DataStatus? dataStatus,
    String? errorMessage,
    List<Movie>? recommendedMovies,
  }) {
    return RecommendedMoviesState(
      dataStatus: dataStatus ?? this.dataStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      recommendedMovies: recommendedMovies ?? this.recommendedMovies,
    );
  }
}

abstract class RecommendedMoviesEvent {
  RecommendedMoviesEvent();
}

class FetchRecommendedMovies extends RecommendedMoviesEvent {
  final int movieId;
  FetchRecommendedMovies({
    required this.movieId,
  });
}
