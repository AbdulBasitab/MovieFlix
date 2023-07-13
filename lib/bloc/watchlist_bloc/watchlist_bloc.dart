import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/repositories/movie_repository.dart';
import 'package:movies_app/repositories/tv_show_repository.dart';
import '../../models/movie/movie.dart';
import '../../models/tv_show/tv_show.dart';

part 'watchlist_bloc_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc(
      {required MovieRepository movieRepository,
      required TvShowRepository tvShowRepository})
      : _movieRepository = movieRepository,
        _tvShowRepository = tvShowRepository,
        super(
          WatchlistState(
            watchlistedMovies: [],
            watchlistedShows: [],
          ),
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

  final MovieRepository _movieRepository;
  final TvShowRepository _tvShowRepository;

  void addMovieToWatchlist(Emitter<WatchlistState> emit, Movie movie) async {
    emit(
      state.copyWith(
        watchlistedMovies: [...state.watchlistedMovies, movie],
      ),
    );
    await _movieRepository.addWatchlistedMovieToDb(movie);
  }

  void fetchWatchlistMovies(Emitter<WatchlistState> emit) {
    var watchlistMovies = _movieRepository.fetchWatchlistedMoviesFromDb();
    emit(state.copyWith(watchlistedMovies: watchlistMovies));
  }

  void fetchWatchlistShows(Emitter<WatchlistState> emit) {
    var watchlistShows = _tvShowRepository.fetchWatchlistedTvShowsFromDb();
    emit(state.copyWith(watchlistedShows: watchlistShows));
  }

  void addShowToWatchlist(Emitter<WatchlistState> emit, TvShow show) async {
    emit(state.copyWith(
      watchlistedShows: [...state.watchlistedShows, show],
    ));
    await _tvShowRepository.addWatchlistedTvShowToDb(show);
  }

  void removeMovieFromWatchlist(Emitter<WatchlistState> emit, Movie movie) {
    state.watchlistedMovies.removeWhere((element) => element.id == movie.id);
    emit(state.copyWith(
      watchlistedMovies: state.watchlistedMovies,
    ));
    _movieRepository.removeMovieFromWatchlistDb(movie);
  }

  void removeShowFromWatchlist(Emitter<WatchlistState> emit, TvShow show) {
    state.watchlistedShows.removeWhere((element) => element.id == show.id);
    emit(state.copyWith(
      watchlistedShows: state.watchlistedShows,
    ));
    _tvShowRepository.removeTvShowFromWatchlistDb(show);
  }

  bool isMovieFavorited(Movie movie) {
    return state.watchlistedMovies.contains(movie);
  }

  bool isShowFavorited(TvShow show) {
    return state.watchlistedShows.contains(show);
  }
}
