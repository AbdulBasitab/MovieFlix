// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movies_app/models/popular_tv_model.dart';
import 'package:movies_app/models/trending_movie_model.dart';

class FavMoviesShowsCubitState {
  List<TrendingMovie> favouriteMovies;
  List<PopularTv> favouriteShows;

  FavMoviesShowsCubitState({
    required this.favouriteMovies,
    required this.favouriteShows,
  });

  FavMoviesShowsCubitState copyWith({
    List<TrendingMovie>? favouriteMovies,
    List<PopularTv>? favouriteShows,
  }) {
    return FavMoviesShowsCubitState(
      favouriteMovies: favouriteMovies ?? this.favouriteMovies,
      favouriteShows: favouriteShows ?? this.favouriteShows,
    );
  }
}
