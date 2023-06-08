import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants/data_constants.dart';
import '../../models/movie_detail.dart';
import '../../models/tv_show.dart';
import '../../models/tv_detail.dart';
import '../../models/movie.dart';
import 'api_service_cubit_state.dart';

class MoviesCubit extends Cubit<ApiServiceCubit> with ApiServiceConstants {
  MoviesCubit() : super(InitCubit());

  Future<void> fetchTrendingMovies() async {
    emit(LoadingMovieState());
    final response = await http
        .get(Uri.parse('$baseUrl/trending/movie/week?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      var trendMovies = <Movie>[];
      trendMovies = <Movie>[
        ...data['results']
            .map((trendmovie) => Movie.fromJson(trendmovie))
            .toList()
      ];

      emit(TrendingMovieState(trendingMovies: trendMovies));
      //return trendMovies;
    } else {
      // If the response was umexpected, throw an error.
      emit(ErrorMovieState("Failed to load movies"));
      throw Exception('Failed to load movies');
    }
  }
}

class MovieDetailCubit extends Cubit<ApiServiceCubit> with ApiServiceConstants {
  MovieDetailCubit() : super(InitCubit());

  Future<void> fetchTrendingMovieDetail(double moviekey) async {
    emit(LoadingMovieState());
    final response =
        await http.get(Uri.parse('$baseUrl/movie/$moviekey?api_key=$apiKey'));
    print(response);
    if (response.statusCode == 200) {
      var movieDetails = json.decode(response.body);
      var movieDetail = MovieDetail.fromJson(movieDetails);
      // print(movieDetail);
      emit(TrendingMovieDetailState(movieDetail: movieDetail));
    } else {
      emit(ErrorMovieState("Error 404"));
      throw Exception('Failed to load details');
    }
  }
}

class TvShowsCubit extends Cubit<ApiServiceCubit> with ApiServiceConstants {
  TvShowsCubit() : super(InitCubit());

  Future<void> fetchPopularTv() async {
    emit(LoadingMovieState());
    final response = await http.get(Uri.parse(
        '$baseUrl/tv/top_rated?api_key=$apiKey&language=en-US&page=1'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      var popularTvShows = <TvShow>[];
      popularTvShows = <TvShow>[
        ...data['results'].map((trendtv) => TvShow.fromJson(trendtv)).toList()
      ];
      emit(PopularMoviesState(popularTvList: popularTvShows));
    } else {
      // If the response was umexpected, throw an error.
      emit(ErrorMovieState("Error 404"));
      throw Exception('Failed to load movies');
    }
  }
}

class PopularTvDetailCubit extends Cubit<ApiServiceCubit>
    with ApiServiceConstants {
  PopularTvDetailCubit() : super(InitCubit());

  Future<void> fetchPopularTvDetail(double tvKey) async {
    emit(LoadingMovieState());
    final response = await http
        .get(Uri.parse('$baseUrl/tv/$tvKey?api_key=$apiKey&language=en-US'));
    // print(response.body);
    if (response.statusCode == 200) {
      var poptvDetails = json.decode(response.body);
      var poptvDetail = TvDetail.fromJson(poptvDetails);

      emit(PopularMovieDetailState(popularTvDetail: poptvDetail));
    } else {
      emit(ErrorMovieState("Error 404"));
      throw Exception('Failed to load details');
    }
  }
}

class ApiServiceConstants {
  final baseUrl = DataConstants.baseUrl;
  final apiKey = DataConstants.apiKey;
}
