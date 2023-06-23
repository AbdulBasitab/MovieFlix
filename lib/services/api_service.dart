import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/movie/movie.dart';
import 'package:movies_app/models/movie_detail/movie_detail.dart';
import 'package:movies_app/models/tv_detail/tv_detail.dart';
import 'package:movies_app/models/tv_show/tv_show.dart';

// import '../constants/data_constants.dart';
class ApiService {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '2f524b9d4ecc59568226e745cef4ffe0';
  final String readToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjUyNGI5ZDRlY2M1OTU2ODIyNmU3NDVjZWY0ZmZlMCIsInN1YiI6IjYzNmU0MWM2ZDdmYmRhMDBlN2I3Nzc4OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pIhLyoiTyNqDfoc0RQqNHVRyb8ZxcsZzDTcD1u29WsI';

  Future<List<Movie>> fetchMovies() async {
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
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieDetail> fetchMovieDetail(double moviekey) async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/$moviekey?api_key=$apiKey'));
    print(response);
    if (response.statusCode == 200) {
      var movieDetails = json.decode(response.body);
      var movieDetail = MovieDetail.fromJson(movieDetails);
      print(movieDetail);
      return movieDetail;
    } else {
      throw Exception('Failed to load details');
    }
  }

  Future<List<TvShow>> fetchPopularTv() async {
    final response = await http.get(
        Uri.parse('$baseUrl/tv/popular?api_key=$apiKey&language=en-US&page=1'));
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

  Future<TvDetail> fetchPopularTvDetail(double tvKey) async {
    final response = await http
        .get(Uri.parse('$baseUrl/tv/$tvKey?api_key=$apiKey&language=en-US'));
    print(response.body);
    if (response.statusCode == 200) {
      var poptvDetails = json.decode(response.body);
      var poptvDetail = TvDetail.fromJson(poptvDetails);

      return poptvDetail;
    } else {
      throw Exception('Failed to load details');
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
      // emit(FetchSearchedMovies(searchedMovies));
    } else {
      // emit(ErrorMovieState("No Movies found"));
    }
    return searchedMovies;
  }
}
