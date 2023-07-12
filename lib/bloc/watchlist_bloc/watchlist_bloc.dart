import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/services/isar_service.dart';
import '../../models/movie/movie.dart';
import '../../models/tv_show/tv_show.dart';

part 'watchlist_bloc_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc()
      : super(
          WatchlistState(
              watchlistedMovies: [],
              watchlistedShows: [],
              isarService: IsarService()),
        ) {
    on<AddMovieToWatchlist>(
        (event, emit) => addMovieToWatchlist(emit, event.movie));
    on<AddShowToWatchlist>(
        (event, emit) => addShowToWatchlist(emit, event.show));
    on<RemoveMovieFromWatchlist>(
        (event, emit) => removeMovieFromWatchlist(emit, event.movie));
    on<RemoveTvShowFromWatchlist>(
        (event, emit) => removeShowFromWatchlist(emit, event.show));
    on<FetchWatchlistMovies>((event, emit) => fetchWatchlistMovies(emit));
    on<FetchWatchlistShows>((event, emit) => fetchWatchlistShows(emit));
  }

  void addMovieToWatchlist(Emitter<WatchlistState> emit, Movie movie) async {
    emit(
      state.copyWith(
        watchlistedMovies: [...state.watchlistedMovies, movie],
      ),
    );
    await state.isarService.addWatchListMovieToDB(movie);
  }

  void fetchWatchlistMovies(Emitter<WatchlistState> emit) {
    var watchlistMovies = state.isarService.fetchWatchListMoviesFromDB();
    emit(state.copyWith(watchlistedMovies: watchlistMovies));
  }

  void fetchWatchlistShows(Emitter<WatchlistState> emit) {
    var watchlistShows = state.isarService.fetchWatchListShowsFromDB();
    emit(state.copyWith(watchlistedShows: watchlistShows));
  }

  void addShowToWatchlist(Emitter<WatchlistState> emit, TvShow show) async {
    emit(state.copyWith(
      watchlistedShows: [...state.watchlistedShows, show],
    ));
    await state.isarService.addWatchListShowToDB(show);
  }

  void removeMovieFromWatchlist(Emitter<WatchlistState> emit, Movie movie) {
    state.watchlistedMovies.removeWhere((element) => element.id == movie.id);
    emit(state.copyWith(
      watchlistedMovies: state.watchlistedMovies,
    ));
    state.isarService.removeWatchListMovieFromDB(movie);
  }

  void removeShowFromWatchlist(Emitter<WatchlistState> emit, TvShow show) {
    state.watchlistedShows.removeWhere((element) => element.id == show.id);
    emit(state.copyWith(
      watchlistedShows: state.watchlistedShows,
    ));
    state.isarService.removeWatchListShowFromDB(show);
  }

  bool isMovieFavorited(Movie movie) {
    return state.watchlistedMovies.contains(movie);
  }

  bool isShowFavorited(TvShow show) {
    return state.watchlistedShows.contains(show);
  }
}
