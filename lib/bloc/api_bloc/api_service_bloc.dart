import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants/data_constants.dart';
import 'package:movies_app/models/review/review.dart';
import 'package:movies_app/models/watch_provider/watch_provider.dart';
import '../../models/movie/movie.dart';
import '../../models/movie_detail/movie_detail.dart';
import '../../models/tv_detail/tv_detail.dart';
import '../../models/tv_show/tv_show.dart';

part 'api_service_state_event.dart';

class ApiServiceBloc extends Bloc<ApiServiceEvent, ApiServiceState>
    with ApiServiceConstants {
  ApiServiceBloc()
      : super(ApiServiceState(
          dataStatus: DataStatus.loading,
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

  /// This function fetches trending movies
  Future<void> fetchTrendingMovies(Emitter<ApiServiceState> emit) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final response = await http
        .get(Uri.parse('$baseUrl/trending/movie/week?api_key=$apiKey'));
    // print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      var trendMovies = <Movie>[];
      trendMovies = <Movie>[
        ...data['results']
            .map((trendmovie) => Movie.fromJson(trendmovie))
            .toList()
      ];

      emit(state.copyWith(
          trendingMovies: trendMovies, dataStatus: DataStatus.success));
      //return trendMovies;
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
    final response =
        await http.get(Uri.parse('$baseUrl/movie/$moviekey?api_key=$apiKey'));
    print(response);
    if (response.statusCode == 200) {
      var movieDetails = json.decode(response.body);
      var movieDetail = MovieDetail.fromJson(movieDetails);
      // print(movieDetail);
      emit(state.copyWith(
          movieDetail: movieDetail, dataStatus: DataStatus.success));
    } else {
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: "Failed to load movie detail"));
      // throw Exception('Failed to load details');
    }
  }

  Future<void> fetchPopularTvShows(Emitter<ApiServiceState> emit) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final response = await http.get(Uri.parse(
        '$baseUrl/tv/top_rated?api_key=$apiKey&language=en-US&page=1'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      var popularTvShows = <TvShow>[];
      popularTvShows = <TvShow>[
        ...data['results'].map((trendtv) => TvShow.fromJson(trendtv)).toList()
      ];
      emit(state.copyWith(
          popularTvShows: popularTvShows, dataStatus: DataStatus.success));
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
    final response = await http
        .get(Uri.parse('$baseUrl/tv/$tvKey?api_key=$apiKey&language=en-US'));
    // print(response.body);
    if (response.statusCode == 200) {
      var poptvDetails = json.decode(response.body);
      var poptvDetail = TvDetail.fromJson(poptvDetails);

      emit(state.copyWith(
          popularTvDetail: poptvDetail, dataStatus: DataStatus.success));
    } else {
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: "Failed to load show details"));
      //throw Exception('Failed to load details');
    }
  }

  Future<List<Movie>> searchMovies(
      String query, Emitter<ApiServiceState> emit) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    var response = await http.get(Uri.parse(
        "$baseUrl/search/movie?query=$query&include_adult=false&language=en-US&page=1&api_key=$apiKey"));
    print(response.body);
    final data = json.decode(response.body) as Map<String, dynamic>;
    var searchedMovies = <Movie>[];
    searchedMovies = [
      ...data['results'].map((movie) => Movie.fromJson(movie)).toList()
    ];
    if (searchedMovies.isNotEmpty) {
      searchedMovies.sort((a, b) => b.rating!.compareTo(a.rating!));
      emit(state.copyWith(
          searchedMovies: searchedMovies, dataStatus: DataStatus.success));
    } else {
      emit(state.copyWith(dataStatus: DataStatus.error));
    }
    return searchedMovies;
  }

  Future<List<Movie>> fetchSimilarMovies(
      int movieId, Emitter<ApiServiceState> emit) async {
    //  emit(state.copyWith(dataStatus: DataStatus.loading));
    var response = await http.get(Uri.parse(
        "$baseUrl/movie/$movieId/similar?language=en-US&page=1&api_key=$apiKey"));
    print(response.body);
    final data = json.decode(response.body) as Map<String, dynamic>;
    var similarMovies = <Movie>[];
    similarMovies = [
      ...data['results'].map((movie) => Movie.fromJson(movie)).toList()
    ];
    if (similarMovies.isNotEmpty) {
      similarMovies.sort((a, b) => b.rating!.compareTo(a.rating!));
      emit(state.copyWith(
          similarMovies: similarMovies, dataStatus: DataStatus.success));
    } else {
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: "Failed to load similar movies"));
    }
    return similarMovies;
  }

  Future<List<Review>> fetchMovieReviews(
      int movieId, Emitter<ApiServiceState> emit) async {
    // emit(state.copyWith(dataStatus: DataStatus.loading));
    var response = await http.get(Uri.parse(
        "$baseUrl/movie/$movieId/reviews?language=en-US&page=1&api_key=$apiKey"));
    print(response.body);
    final data = json.decode(response.body) as Map<String, dynamic>;
    var movieReviews = <Review>[];
    movieReviews = [
      ...data['results'].map((review) => Review.fromJson(review)).toList()
    ];
    if (movieReviews.isNotEmpty) {
      emit(state.copyWith(
          movieReviews: movieReviews, dataStatus: DataStatus.success));
    } else {
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: "Failed to load reviews"));
    }
    return movieReviews;
  }

  Future<List<Movie>> fetchRecommendedMovies(
      int movieId, Emitter<ApiServiceState> emit) async {
    // emit(state.copyWith(dataStatus: DataStatus.loading));
    var response = await http.get(Uri.parse(
        "$baseUrl/movie/$movieId/recommendations?language=en-US&page=1&api_key=$apiKey"));
    print(response.body);
    final data = json.decode(response.body) as Map<String, dynamic>;
    var recommendedMovies = <Movie>[];
    recommendedMovies = [
      ...data['results'].map((movie) => Movie.fromJson(movie)).toList()
    ];
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
    return recommendedMovies;
  }

  Future<void> fetchMovieWatchProviders(
      int movieId, Emitter<ApiServiceState> emit) async {
    // emit(state.copyWith(dataStatus: DataStatus.loading));
    try {
      var response = await http.get(
          Uri.parse(
            "$baseUrl/movie/$movieId/watch/providers",
          ),
          headers: {
            'accept': 'application/json',
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjUyNGI5ZDRlY2M1OTU2ODIyNmU3NDVjZWY0ZmZlMCIsInN1YiI6IjYzNmU0MWM2ZDdmYmRhMDBlN2I3Nzc4OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pIhLyoiTyNqDfoc0RQqNHVRyb8ZxcsZzDTcD1u29WsI'
          });
      print(response.body);
      final data = json.decode(response.body) as Map<String, dynamic>;
      WatchProvider? movieProviderSingleCountry;
      var watchProvidersData = data['results'];
      var singleWatchProvider = watchProvidersData['US'];
      movieProviderSingleCountry = WatchProvider.fromJson(singleWatchProvider);

      if (movieProviderSingleCountry != null) {
        emit(state.copyWith(movieWatchProvider: movieProviderSingleCountry));
      } else {
        emit(state.copyWith(
            dataStatus: DataStatus.error,
            errorMessage: "No watch providers found"));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage: "No watch providers found"));
    }
  }
}

class ApiServiceConstants {
  final baseUrl = DataConstants.baseUrl;
  final apiKey = DataConstants.apiKey;
}
