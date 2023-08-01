import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/movie/movie.dart';
import 'package:movies_app/models/tv_show/tv_show.dart';
import 'package:movies_app/repositories/movie_repository.dart';
import 'package:movies_app/repositories/tv_show_repository.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(
      {required MovieRepository movieRepository,
      required TvShowRepository tvShowRepository})
      : _movieRepository = movieRepository,
        _tvShowRepository = tvShowRepository,
        super(
          SearchState(searchedMovies: [], searchedTvShows: []),
        ) {
    on<SearchMovies>((event, emit) async {
      emit(state.copyWith(dataStatus: DataStatus.loading));
      final searchedMovies = await fetchSearchedMovies(event.searchQuery);
      if (searchedMovies.isNotEmpty) {
        emit(state.copyWith(
            dataStatus: DataStatus.success, searchedMovies: searchedMovies));
      } else {
        emit(state.copyWith(
            dataStatus: DataStatus.error, searchedMovies: searchedMovies));
      }
    });
    on<SearchTvShows>((event, emit) async {
      emit(state.copyWith(dataStatus: DataStatus.loading));
      final searchedTvShows = await fetchSearchedTvShows(event.searchQuery);
      if (searchedTvShows.isNotEmpty) {
        emit(state.copyWith(
            dataStatus: DataStatus.success, searchedTvShows: searchedTvShows));
      } else {
        emit(state.copyWith(
            dataStatus: DataStatus.error, searchedTvShows: searchedTvShows));
      }
    });
  }
  final MovieRepository _movieRepository;
  final TvShowRepository _tvShowRepository;

  Future<List<Movie>> fetchSearchedMovies(String searchedQuery) async {
    final searchedMovies =
        await _movieRepository.fetchSearchedMovies(searchedQuery);
    return searchedMovies;
  }

  Future<List<TvShow>> fetchSearchedTvShows(String searchedQuery) async {
    final searchedTvShows =
        _tvShowRepository.fetchSearchedTvShows(searchedQuery);
    return searchedTvShows;
  }
}
