import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/review/review.dart';
import 'package:movies_app/models/watch_provider/watch_provider.dart';
import '../../models/movie/movie.dart';
import '../../models/movie_detail/movie_detail.dart';
import '../../models/tv_detail/tv_detail.dart';
import '../../models/tv_show/tv_show.dart';
import '../../services/api_service.dart';

part 'api_service_state_event.dart';

class ApiServiceBloc extends Bloc<ApiServiceEvent, ApiServiceState> {
  ApiServiceBloc()
      : super(ApiServiceState(
          dataStatus: DataStatus.loading,
          apiService: ApiService(),
          trendingMovies: [],
          recommendedMovies: [],
          similarMovies: [],
          popularTvShows: [],
          searchedMovies: [],
          movieReviews: [],
        )) {
    on<FetchTrendingMovies>((event, emit) => fetchTrendingMovies(emit));
    on<FetchMovieDetail>(
        (event, emit) => fetchMovieDetail(event.movieId, emit));
    on<FetchPopularTvShows>((event, emit) => fetchPopularTvShows(emit));
    on<FetchTvShowDetail>(
        (event, emit) => fetchTvShowDetail(event.tvShowId, emit));
    on<FetchSearchedMovies>((event, emit) => searchMovies(event.query, emit));
    on<FetchSimilarMovies>(
        (event, emit) => fetchSimilarMovies(event.movieId, emit));
    on<FetchRecommendedMovies>(
        (event, emit) => fetchRecommendedMovies(event.movieId, emit));
    on<FetchMovieReviews>(
        (event, emit) => fetchMovieReviews(event.movieId, emit));
    on<FetchMovieWatchProvider>(
        (event, emit) => fetchMovieWatchProviders(event.movieId, emit));
  }

  /// Fetches trending movies
  Future<void> fetchTrendingMovies(Emitter<ApiServiceState> emit) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final trendMovies = await state.apiService.fetchTrendingMovies();

    if (trendMovies.isNotEmpty) {
      emit(state.copyWith(
          trendingMovies: trendMovies, dataStatus: DataStatus.success));
    } else {
      // If the response was umexpected, throw an error.
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: 'Failed to fetch Movies'));
    }
  }

  Future<void> fetchMovieDetail(
      int moviekey, Emitter<ApiServiceState> emit) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final movieDetail = await state.apiService.fetchMovieDetail(moviekey);
    if (movieDetail != null) {
      emit(state.copyWith(
          movieDetail: movieDetail, dataStatus: DataStatus.success));
    } else {
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: "Failed to load movie detail"));
    }
  }

  Future<void> fetchPopularTvShows(Emitter<ApiServiceState> emit) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final popTvShows = await state.apiService.fetchPopularTv();
    if (popTvShows.isNotEmpty) {
      emit(state.copyWith(
          popularTvShows: popTvShows, dataStatus: DataStatus.success));
    } else {
      // If the response was umexpected, throw an error.
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: "Failed to load tv shows"));
      //throw Exception('Failed to load movies');
    }
  }

  Future<void> fetchTvShowDetail(
      int tvKey, Emitter<ApiServiceState> emit) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final popTvDetail = await state.apiService.fetchPopularTvDetail(tvKey);
    // print(response.body);
    if (popTvDetail != null) {
      emit(state.copyWith(
          popularTvDetail: popTvDetail, dataStatus: DataStatus.success));
    } else {
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: "Failed to load show details"));
    }
  }

  Future<void> searchMovies(String query, Emitter<ApiServiceState> emit) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    var searchedMovies = await state.apiService.searchMovies(query);
    if (searchedMovies.isNotEmpty) {
      searchedMovies.sort((a, b) => b.rating!.compareTo(a.rating!));
      emit(state.copyWith(
          searchedMovies: searchedMovies, dataStatus: DataStatus.success));
    } else {
      emit(state.copyWith(dataStatus: DataStatus.error));
    }
  }

  Future<void> fetchSimilarMovies(
      int movieId, Emitter<ApiServiceState> emit) async {
    //  emit(state.copyWith(dataStatus: DataStatus.loading));
    var similarMovies = await state.apiService.fetchSimilarMovies(movieId);

    if (similarMovies.isNotEmpty) {
      similarMovies.sort((a, b) => b.rating!.compareTo(a.rating!));
      emit(state.copyWith(
          similarMovies: similarMovies, dataStatus: DataStatus.success));
    } else {
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: "Failed to load similar movies"));
    }
  }

  Future<void> fetchMovieReviews(
      int movieId, Emitter<ApiServiceState> emit) async {
    // emit(state.copyWith(dataStatus: DataStatus.loading));
    var movieReviews = await state.apiService.fetchMovieReviews(movieId);

    if (movieReviews.isNotEmpty) {
      emit(state.copyWith(
          movieReviews: movieReviews, dataStatus: DataStatus.success));
    } else {
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: "Failed to load reviews"));
    }
  }

  Future<void> fetchRecommendedMovies(
      int movieId, Emitter<ApiServiceState> emit) async {
    // emit(state.copyWith(dataStatus: DataStatus.loading));
    var recommendedMovies =
        await state.apiService.fetchRecommendedMovies(movieId);

    if (recommendedMovies.isNotEmpty) {
      recommendedMovies.sort((a, b) => b.rating!.compareTo(a.rating!));
      emit(state.copyWith(
          recommendedMovies: recommendedMovies,
          dataStatus: DataStatus.success));
    } else {
      emit(state.copyWith(
          errorMessage: "Failed to load recommended movies",
          dataStatus: DataStatus.error));
    }
  }

  Future<void> fetchMovieWatchProviders(
      int movieId, Emitter<ApiServiceState> emit) async {
    // emit(state.copyWith(dataStatus: DataStatus.loading));
    var movieWatchProvider =
        await state.apiService.fetchMovieWatchProviders(movieId);
    if (movieWatchProvider != null) {
      emit(state.copyWith(movieWatchProvider: movieWatchProvider));
    } else {
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: "No watch providers found"));
    }
  }
}
