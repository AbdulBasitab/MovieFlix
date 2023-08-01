// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

enum DataStatus { success, error, loading }

class SearchState {
  final DataStatus? dataStatus;
  final String? errorMessage;
  final List<Movie> searchedMovies;
  final List<TvShow> searchedTvShows;
  SearchState({
    this.dataStatus,
    this.errorMessage,
    required this.searchedMovies,
    required this.searchedTvShows,
  });

  SearchState copyWith({
    DataStatus? dataStatus,
    String? errorMessage,
    List<Movie>? searchedMovies,
    List<TvShow>? searchedTvShows,
  }) {
    return SearchState(
      dataStatus: dataStatus ?? this.dataStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      searchedMovies: searchedMovies ?? this.searchedMovies,
      searchedTvShows: searchedTvShows ?? this.searchedTvShows,
    );
  }
}

abstract class SearchEvent {
  SearchEvent();
}

class SearchMovies extends SearchEvent {
  final String searchQuery;
  SearchMovies({
    required this.searchQuery,
  });
}

class SearchTvShows extends SearchEvent {
  final String searchQuery;
  SearchTvShows({
    required this.searchQuery,
  });
}
