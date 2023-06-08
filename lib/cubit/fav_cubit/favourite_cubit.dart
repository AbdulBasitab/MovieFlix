import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/tv_show.dart';
import 'package:movies_app/models/movie.dart';
import 'favourite_cubit_state.dart';

class FavouriteMoviesShowsCubit extends Cubit<FavMoviesShowsCubitState> {
  FavouriteMoviesShowsCubit()
      : super(
            FavMoviesShowsCubitState(favouriteMovies: [], favouriteShows: []));

  void addFavMovie(Movie favMovie) {
    state.favouriteMovies.add(favMovie);
    emit(
      state.copyWith(
        favouriteMovies: state.favouriteMovies,
      ),
    );
  }

  void addFavShow(TvShow show) {
    state.favouriteShows.add(show);
    emit(state.copyWith(
      favouriteShows: state.favouriteShows,
    ));
  }

  void removeFavMovie(Movie movie) {
    state.favouriteMovies.remove(movie);
    emit(state.copyWith(
      favouriteMovies: state.favouriteMovies,
    ));
  }

  void removeFavShow(TvShow show) {
    state.favouriteShows.remove(show);
    emit(state.copyWith(
      favouriteShows: state.favouriteShows,
    ));
  }

  bool isMovieFavorited(Movie movie) {
    return state.favouriteMovies.contains(movie);
  }

  bool isShowFavorited(TvShow show) {
    return state.favouriteShows.contains(show);
  }
}
