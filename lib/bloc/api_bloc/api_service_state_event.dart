// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'api_service_bloc.dart';

enum DataStatus { success, error, loading }

class ApiServiceState {
  final DataStatus? dataStatus;
  final List<Movie> trendingMovies;
  final List<TvShow> popularTvShows;
  final MovieDetail? movieDetail;
  final TvDetail? popularTvDetail;
  final List<Movie> searchedMovies;
  final List<Movie> similarMovies;
  final List<Movie> recommendedMovies;
  final List<Review> movieReviews;
  final WatchProvider? movieWatchProvider;

  ApiServiceState(
      {this.dataStatus,
      required this.trendingMovies,
      required this.popularTvShows,
      this.movieDetail,
      this.popularTvDetail,
      required this.searchedMovies,
      required this.similarMovies,
      required this.recommendedMovies,
      required this.movieReviews,
      this.movieWatchProvider});

  ApiServiceState copyWith({
    DataStatus? dataStatus,
    List<Movie>? trendingMovies,
    List<TvShow>? popularTvShows,
    MovieDetail? movieDetail,
    TvDetail? popularTvDetail,
    List<Movie>? searchedMovies,
    List<Movie>? similarMovies,
    List<Movie>? recommendedMovies,
    List<Review>? movieReviews,
    WatchProvider? movieWatchProvider,
  }) {
    return ApiServiceState(
      dataStatus: dataStatus ?? this.dataStatus,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      popularTvShows: popularTvShows ?? this.popularTvShows,
      movieDetail: movieDetail ?? this.movieDetail,
      popularTvDetail: popularTvDetail ?? this.popularTvDetail,
      searchedMovies: searchedMovies ?? this.searchedMovies,
      similarMovies: similarMovies ?? this.similarMovies,
      recommendedMovies: recommendedMovies ?? this.recommendedMovies,
      movieReviews: movieReviews ?? this.movieReviews,
      movieWatchProvider: movieWatchProvider ?? this.movieWatchProvider,
    );
  }
}

abstract class ApiServiceEvent {}

class FetchTrendingMovies extends ApiServiceEvent {
  FetchTrendingMovies();
}

class FetchMovieDetail extends ApiServiceEvent {
  final int movieId;
  FetchMovieDetail({
    required this.movieId,
  });
}

class FetchPopularTvShows extends ApiServiceEvent {
  FetchPopularTvShows();
}

class FetchPopularShowDetail extends ApiServiceEvent {
  final TvDetail popularTvDetail;
  FetchPopularShowDetail({
    required this.popularTvDetail,
  });
}

class FetchSearchedMovies extends ApiServiceEvent {
  final String query;

  FetchSearchedMovies(this.query);
}

class FetchSimilarMovies extends ApiServiceEvent {
  final int movieId;

  FetchSimilarMovies(this.movieId);
}

class FetchMovieReviews extends ApiServiceEvent {
  final int movieId;

  FetchMovieReviews(this.movieId);
}

class FetchRecommendedMovies extends ApiServiceEvent {
  final int movieId;
  FetchRecommendedMovies(this.movieId);
}

class FetchMovieWatchProvider extends ApiServiceEvent {
  final int movieId;

  FetchMovieWatchProvider(this.movieId);
}
