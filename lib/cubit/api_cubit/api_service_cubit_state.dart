// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movies_app/models/moviedetail_model.dart';
import 'package:movies_app/models/popular_tv_model.dart';
import 'package:movies_app/models/populartv_detail.dart';
import 'package:movies_app/models/trending_movie_model.dart';

abstract class ApiServiceCubit {}

class InitCubit extends ApiServiceCubit {}

class LoadingMovieState extends ApiServiceCubit {}

class ErrorMovieState extends ApiServiceCubit {
  final String errorMessage;

  ErrorMovieState(this.errorMessage);
}

class TrendingMovieState extends ApiServiceCubit {
  List<TrendingMovie> trendingMovies;
  TrendingMovieState({
    required this.trendingMovies,
  });
}

class TrendingMovieDetailState extends ApiServiceCubit {
  final TrendingMovieDetail movieDetail;
  TrendingMovieDetailState({
    required this.movieDetail,
  });
}

class PopularMoviesState extends ApiServiceCubit {
  final List<PopularTv> popularTvList;
  PopularMoviesState({
    required this.popularTvList,
  });
}

class PopularMovieDetailState extends ApiServiceCubit {
  final PopularTvDetailModel popularTvDetail;
  PopularMovieDetailState({
    required this.popularTvDetail,
  });
}
