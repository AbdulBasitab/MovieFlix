import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/movie_detail/movie_detail.dart';
import 'package:movies_app/repositories/movie_repository.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(MovieDetailState(
          dataStatus: DataStatus.loading,
          errorMessage: '',
        )) {
    on<FetchMovieDetail>((event, emit) async {
      final movieDetail = await fetchMovieDetail(event.movieKey);
      if (movieDetail != null) {
        emit(state.copyWith(
          dataStatus: DataStatus.success,
          movieDetail: movieDetail,
        ));
      } else {
        emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage:
              "Failed to fetch movie detail.Check your Internet Connection and Try Again",
          movieDetail: movieDetail,
        ));
      }
    });
  }
  final MovieRepository _movieRepository;

  Future<MovieDetail?> fetchMovieDetail(int movieKey) async {
    final movieDetail = await _movieRepository.fetchMovieDetail(movieKey);
    return movieDetail;
  }
}
