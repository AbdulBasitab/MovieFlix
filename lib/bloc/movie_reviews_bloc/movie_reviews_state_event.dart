// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'movie_reviews_bloc.dart';

enum DataStatus { success, error, loading }

class MovieReviewsState {
  final DataStatus? dataStatus;
  final String? errorMessage;

  final List<Review> movieReviews;
  MovieReviewsState({
    this.dataStatus,
    this.errorMessage,
    required this.movieReviews,
  });

  MovieReviewsState copyWith({
    DataStatus? dataStatus,
    String? errorMessage,
    List<Review>? movieReviews,
  }) {
    return MovieReviewsState(
      dataStatus: dataStatus ?? this.dataStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      movieReviews: movieReviews ?? this.movieReviews,
    );
  }
}

abstract class MovieReviewsEvent {
  MovieReviewsEvent();
}

class FetchMovieReviews extends MovieReviewsEvent {
  final int movieId;

  FetchMovieReviews(this.movieId);
}
