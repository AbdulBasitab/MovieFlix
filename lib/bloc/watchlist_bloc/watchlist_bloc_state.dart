// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'watchlist_bloc.dart';

class WatchlistState {
  List<Movie> watchlistedMovies;
  List<TvShow> watchlistedShows;

  WatchlistState({
    required this.watchlistedMovies,
    required this.watchlistedShows,
  });

  WatchlistState copyWith({
    List<Movie>? watchlistedMovies,
    List<TvShow>? watchlistedShows,
  }) {
    return WatchlistState(
      watchlistedMovies: watchlistedMovies ?? this.watchlistedMovies,
      watchlistedShows: watchlistedShows ?? this.watchlistedShows,
    );
  }
}

abstract class WatchlistEvent {}

class AddMovieToWatchlist extends WatchlistEvent {
  final Movie movie;

  AddMovieToWatchlist(this.movie);
}

class AddShowToWatchlist extends WatchlistEvent {
  final TvShow show;

  AddShowToWatchlist(this.show);
}

class RemoveMovieFromWatchlist extends WatchlistEvent {
  final Movie movie;

  RemoveMovieFromWatchlist(this.movie);
}

class RemoveTvShowFromWatchlist extends WatchlistEvent {
  final TvShow show;

  RemoveTvShowFromWatchlist(this.show);
}

class FetchWatchlistMovies extends WatchlistEvent {}

class FetchWatchlistShows extends WatchlistEvent {}
