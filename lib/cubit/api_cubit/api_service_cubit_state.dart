// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movies_app/models/movie_detail.dart';
import 'package:movies_app/models/tv_show.dart';
import 'package:movies_app/models/tv_detail.dart';
import 'package:movies_app/models/movie.dart';

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
