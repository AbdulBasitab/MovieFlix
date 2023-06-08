// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movies_app/models/tv_show.dart';
import 'package:movies_app/models/movie.dart';

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
