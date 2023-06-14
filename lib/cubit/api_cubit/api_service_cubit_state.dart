// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../models/movie/movie.dart';
import '../../models/movie_detail/movie_detail.dart';
import '../../models/tv_detail/tv_detail.dart';
import '../../models/tv_show/tv_show.dart';

abstract class ApiServiceCubit {}

class InitCubit extends ApiServiceCubit {}

class LoadingMovieState extends ApiServiceCubit {}

class ErrorMovieState extends ApiServiceCubit {
  final String errorMessage;

  ErrorMovieState(this.errorMessage);
}

class TrendingMovieState extends ApiServiceCubit {
  List<Movie> trendingMovies;
  TrendingMovieState({
    required this.trendingMovies,
  });
}

class TrendingMovieDetailState extends ApiServiceCubit {
  final MovieDetail movieDetail;
  TrendingMovieDetailState({
    required this.movieDetail,
  });
}

class PopularMoviesState extends ApiServiceCubit {
  final List<TvShow> popularTvList;
  PopularMoviesState({
    required this.popularTvList,
  });
}

class PopularMovieDetailState extends ApiServiceCubit {
  final TvDetail popularTvDetail;
  PopularMovieDetailState({
    required this.popularTvDetail,
  });
}

class SearchMoviesState extends ApiServiceCubit {
  final List<Movie> searchedMovies;

  SearchMoviesState(this.searchedMovies);
}

class SimilarMoviesState extends ApiServiceCubit {
  final List<Movie> similarMovies;

  SimilarMoviesState(this.similarMovies);
}

class RecommendedMoviesState extends ApiServiceCubit {
  final List<Movie> recommendedMovies;

  RecommendedMoviesState(this.recommendedMovies);
}
