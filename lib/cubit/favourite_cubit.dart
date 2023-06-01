import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/popular_tv_model.dart';
import 'package:movies_app/models/trending_movie_model.dart';

import 'favourite_cubit_state.dart';

class FavouriteMoviesShowsCubit extends Cubit<FavMoviesShowsCubitState> {
  FavouriteMoviesShowsCubit() : super(InitFavState());

  List<TrendingMovie> _favMovies = [];
  List<PopularTv> _favShows = [];

  void addFavMovie(TrendingMovie favMovie) {
    _favMovies.add(favMovie);
    emit(FavMoviesState(_favMovies));
  }

  void addFavShow(PopularTv show) {
    _favShows.add(show);
    emit(FavShowsState(_favShows));
  }

  void removeFavMovie(TrendingMovie movie) {
    _favMovies.remove(movie);
    emit(FavMoviesState(_favMovies));
  }

  void removeFavShow(PopularTv show) {
    _favShows.remove(show);
    emit(FavShowsState(_favShows));
  }

  bool isMovieFavorited(TrendingMovie movie) {
    return _favMovies.contains(movie);
  }

  // Check if a show is favorited by the user
  bool isShowFavorited(PopularTv show) {
    return _favShows.contains(show);
  }
}
