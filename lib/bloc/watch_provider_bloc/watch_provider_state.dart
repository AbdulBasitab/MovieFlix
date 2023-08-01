// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'watch_provider_bloc.dart';

enum DataStatus { success, error, loading }

class WatchProviderState {
  final DataStatus? dataStatus;
  final String? errorMessage;
  final WatchProvider? movieWatchProvider;
  WatchProviderState({
    this.dataStatus,
    this.errorMessage,
    this.movieWatchProvider,
  });

  WatchProviderState copyWith({
    DataStatus? dataStatus,
    String? errorMessage,
    WatchProvider? movieWatchProvider,
  }) {
    return WatchProviderState(
      dataStatus: dataStatus ?? this.dataStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      movieWatchProvider: movieWatchProvider ?? this.movieWatchProvider,
    );
  }
}

abstract class WatchProviderEvent {
  WatchProviderEvent();
}

class FetchWatchProviders extends WatchProviderEvent {
  final int movieId;
  FetchWatchProviders({
    required this.movieId,
  });
}
