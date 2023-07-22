import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ApiService {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '2f524b9d4ecc59568226e745cef4ffe0';
  static const String readToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjUyNGI5ZDRlY2M1OTU2ODIyNmU3NDVjZWY0ZmZlMCIsInN1YiI6IjYzNmU0MWM2ZDdmYmRhMDBlN2I3Nzc4OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pIhLyoiTyNqDfoc0RQqNHVRyb8ZxcsZzDTcD1u29WsI';

  Future<List<Movie>> fetchTrendingMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/trending/movie/week?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      print(data.toString());
      var trendMovies = <Movie>[];
      trendMovies = <Movie>[
        ...data['results']
            .map((trendmovie) => Movie.fromJson(trendmovie))
            .toList()
      ];

      return trendMovies;
    } else {
      return <Movie>[];
    }
  }

  Future<MovieDetail?> fetchMovieDetail(int moviekey) async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/$moviekey?api_key=$apiKey'));
    print(response);
    if (response.statusCode == 200) {
      var movieDetails = json.decode(response.body);
      var movieDetail = MovieDetail.fromJson(movieDetails);
      print(movieDetail);
      return movieDetail;
    } else {
      return null;
    }
  }

  Future<List<TvShow>> fetchPopularTvShows() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/tv/top_rated?api_key=$apiKey&language=en-US&page=1'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      var trendTvs = <TvShow>[];
      trendTvs = <TvShow>[
        ...data['results'].map((trendtv) => TvShow.fromJson(trendtv)).toList()
      ];
      return trendTvs;
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load movies');
    }
  }

  Future<TvShowDetail?> fetchTvShowDetail(int tvKey) async {
    final response = await http
        .get(Uri.parse('$baseUrl/tv/$tvKey?api_key=$apiKey&language=en-US'));
    print(response.body);
    if (response.statusCode == 200) {
      var poptvDetails = json.decode(response.body);
      var poptvDetail = TvShowDetail.fromJson(poptvDetails);

      return poptvDetail;
    } else {
      return null;
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
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
    } else {}
    return searchedMovies;
  }

  Future<List<Movie>> fetchSimilarMovies(int movieId) async {
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
    } else {}
    return similarMovies;
  }

  Future<List<Review>> fetchMovieReviews(
    int movieId,
  ) async {
    var response = await http.get(Uri.parse(
        "$baseUrl/movie/$movieId/reviews?language=en-US&page=1&api_key=$apiKey"));
    print(response.body);
    final data = json.decode(response.body) as Map<String, dynamic>;
    var movieReviews = <Review>[];
    movieReviews = [
      ...data['results'].map((review) => Review.fromJson(review)).toList()
    ];
    if (movieReviews.isNotEmpty) {
    } else {}
    return movieReviews;
  }

  Future<List<Movie>> fetchRecommendedMovies(
    int movieId,
  ) async {
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
    } else {}
    return recommendedMovies;
  }

  Future<WatchProvider?> fetchMovieWatchProviders(
    int movieId,
  ) async {
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

      return movieProviderSingleCountry;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
