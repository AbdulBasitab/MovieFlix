import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/popular_tv_model.dart';
import 'package:movies_app/models/trending_movie_model.dart';
import 'favourite_cubit_state.dart';

class FavouriteMoviesShowsCubit extends Cubit<FavMoviesShowsCubitState> {
  FavouriteMoviesShowsCubit()
      : super(
            FavMoviesShowsCubitState(favouriteMovies: [], favouriteShows: []));

  void addFavMovie(TrendingMovie favMovie) {
    state.favouriteMovies.add(favMovie);
    emit(
      state.copyWith(
        favouriteMovies: state.favouriteMovies,
      ),
    );
  }

  void addFavShow(PopularTv show) {
    state.favouriteShows.add(show);
    emit(state.copyWith(
      favouriteShows: state.favouriteShows,
    ));
  }

  void removeFavMovie(TrendingMovie movie) {
    state.favouriteMovies.remove(movie);
    emit(state.copyWith(
      favouriteMovies: state.favouriteMovies,
    ));
  }

  void removeFavShow(PopularTv show) {
    state.favouriteShows.remove(show);
    emit(state.copyWith(
      favouriteShows: state.favouriteShows,
    ));
  }

  bool isMovieFavorited(TrendingMovie movie) {
    return state.favouriteMovies.contains(movie);
  }

  bool isShowFavorited(PopularTv show) {
    return state.favouriteShows.contains(show);
  }
}
