// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_detail_bloc.dart';

enum DataStatus { success, error, loading }

class MovieDetailState {
  final DataStatus? dataStatus;
  final String? errorMessage;
  final MovieDetail? movieDetail;
  MovieDetailState({
    this.dataStatus,
    this.errorMessage,
    this.movieDetail,
  });

  MovieDetailState copyWith({
    DataStatus? dataStatus,
    String? errorMessage,
    MovieDetail? movieDetail,
  }) {
    return MovieDetailState(
      dataStatus: dataStatus ?? this.dataStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      movieDetail: movieDetail ?? this.movieDetail,
    );
  }
}

@immutable
sealed class MovieDetailEvent {
  const MovieDetailEvent();
}

class FetchMovieDetail extends MovieDetailEvent {
  final int movieKey;
  const FetchMovieDetail({
    required this.movieKey,
  });
}
