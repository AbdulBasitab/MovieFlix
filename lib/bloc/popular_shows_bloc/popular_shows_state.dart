// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'popular_shows_bloc.dart';

enum DataStatus { success, error, loading }

class PopularShowsState {
  final DataStatus? dataStatus;
  final String? errorMessage;
  final List<TvShow> popularShows;
  PopularShowsState({
    this.dataStatus,
    this.errorMessage,
    required this.popularShows,
  });

  PopularShowsState copyWith({
    DataStatus? dataStatus,
    String? errorMessage,
    List<TvShow>? popularShows,
  }) {
    return PopularShowsState(
      dataStatus: dataStatus ?? this.dataStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      popularShows: popularShows ?? this.popularShows,
    );
  }
}

sealed class PopularShowsEvent {}

class FetchPopularShows extends PopularShowsEvent {
  FetchPopularShows();
}
