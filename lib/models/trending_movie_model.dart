import 'dart:convert';
import 'dart:core';
import '../widgets/api_handler.dart';
import 'package:http/http.dart' as http;

// class Genres {
//   List genre;
//   final int id;
//   final String name;

//   Genres({required this.id, required this.name});
// }

class TrendingMovie {
  final String movieTitle;
  final String imageMoviePath;
  final int movieId;

  TrendingMovie({
    required this.movieId,
    required this.movieTitle,
    required this.imageMoviePath,
  });

  factory TrendingMovie.fromJson(Map<String, dynamic> json) {
    return TrendingMovie(
      movieId: json["id"],
      movieTitle: json["title"],
      imageMoviePath: json["poster_path"],
    );
  }
  @override
  String toString() {
    return '$movieId, $movieTitle, $imageMoviePath';
  }
}
