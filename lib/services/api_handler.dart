import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/moviedetail_model.dart';
import '../models/trending_movie_model.dart';
import '../models/popular_tv_model.dart';
import '../models/populartv_detail.dart';

class ApiHandler {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '2f524b9d4ecc59568226e745cef4ffe0';
  final String readToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjUyNGI5ZDRlY2M1OTU2ODIyNmU3NDVjZWY0ZmZlMCIsInN1YiI6IjYzNmU0MWM2ZDdmYmRhMDBlN2I3Nzc4OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pIhLyoiTyNqDfoc0RQqNHVRyb8ZxcsZzDTcD1u29WsI';

  Future<List<TrendingMovie>> fetchTrendingMovies() async {
    final response = await http
        .get(Uri.parse('$baseUrl/trending/movie/week?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      var trendMovies = <TrendingMovie>[];
      trendMovies = <TrendingMovie>[
        ...data['results']
            .map((trendmovie) => TrendingMovie.fromJson(trendmovie))
            .toList()
      ];

      return trendMovies;
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load movies');
    }
  }

  Future<TrendingMovieDetail> fetchTrendingMovieDetail(double moviekey) async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/$moviekey?api_key=$apiKey'));
    print(response);
    if (response.statusCode == 200) {
      var movieDetails = json.decode(response.body);
      var movieDetail = TrendingMovieDetail.fromJson(movieDetails);
      print(movieDetail);
      return movieDetail;
    } else {
      throw Exception('Failed to load details');
    }
  }

  Future<List<PopularTv>> fetchPopularTv() async {
    final response = await http.get(
        Uri.parse('$baseUrl/tv/popular?api_key=$apiKey&language=en-US&page=1'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      var trendTvs = <PopularTv>[];
      trendTvs = <PopularTv>[
        ...data['results']
            .map((trendtv) => PopularTv.fromJson(trendtv))
            .toList()
      ];

      return trendTvs;
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load movies');
    }
  }

  Future<PopularTvDetailModel> fetchPopularTvDetail(double tvKey) async {
    final response = await http
        .get(Uri.parse('$baseUrl/tv/$tvKey?api_key=$apiKey&language=en-US'));
    print(response.body);
    if (response.statusCode == 200) {
      var poptvDetails = json.decode(response.body);
      var poptvDetail = PopularTvDetailModel.fromJson(poptvDetails);

      return poptvDetail;
    } else {
      throw Exception('Failed to load details');
    }
  }
}
