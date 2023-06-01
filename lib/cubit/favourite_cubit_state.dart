import 'package:movies_app/models/favourite_movies.dart';
import 'package:movies_app/models/popular_tv_model.dart';
import 'package:movies_app/models/trending_movie_model.dart';

abstract class FavMoviesShowsCubitState {}

class InitFavState extends FavMoviesShowsCubitState {}

class LoadingFavState extends FavMoviesShowsCubitState {}

class ErrorFavState extends FavMoviesShowsCubitState {
  final String message;

  ErrorFavState(this.message);
}

class FavMoviesState extends FavMoviesShowsCubitState {
  final List<TrendingMovie> favMovies;

  FavMoviesState(this.favMovies);
}

class FavShowsState extends FavMoviesShowsCubitState {
  final List<PopularTv> favShows;

  FavShowsState(this.favShows);
}
