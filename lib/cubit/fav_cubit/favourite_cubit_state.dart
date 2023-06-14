// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../models/movie/movie.dart';
import '../../models/tv_show/tv_show.dart';

class FavMoviesShowsCubitState {
  List<Movie> favouriteMovies;
  List<TvShow> favouriteShows;

  FavMoviesShowsCubitState({
    required this.favouriteMovies,
    required this.favouriteShows,
  });

  FavMoviesShowsCubitState copyWith({
    List<Movie>? favouriteMovies,
    List<TvShow>? favouriteShows,
  }) {
    return FavMoviesShowsCubitState(
      favouriteMovies: favouriteMovies ?? this.favouriteMovies,
      favouriteShows: favouriteShows ?? this.favouriteShows,
    );
  }
}
