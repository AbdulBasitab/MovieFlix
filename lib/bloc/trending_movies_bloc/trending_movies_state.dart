// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'trending_movies_bloc.dart';

enum DataStatus { success, error, loading }

class TrendingMoviesState {
  final DataStatus? dataStatus;
  final String? errorMessage;
  final List<Movie> trendingMovies;

  TrendingMoviesState({
    this.dataStatus,
    this.errorMessage,
   required this.trendingMovies,
});

  TrendingMoviesState copyWith({
    DataStatus? dataStatus,
    String? errorMessage,
    List<Movie>? trendingMovies,
  }) {
    return TrendingMoviesState(
     dataStatus: dataStatus ?? this.dataStatus,
    errorMessage:  errorMessage ?? this.errorMessage,
    trendingMovies:  trendingMovies ?? this.trendingMovies,
    );
  }
}

sealed class TrendingMoviesEvent {}

class FetchTrendingMovies extends TrendingMoviesEvent {
  FetchTrendingMovies();
}
