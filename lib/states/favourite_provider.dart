import 'package:flutter/material.dart';
import 'package:movies_app/models/trending_movie_model.dart';
import 'package:movies_app/screens/fav_movies.dart';
import '../services/api_handler.dart';
import '../widgets/trending_movies.dart';
import '../widgets/popular_tv.dart';

class Favourite extends ChangeNotifier {
  List<TrendingMovie> _favMovies = [];
  List<TrendingMovie> get favMovies => _favMovies;

  void addtofav(List<TrendingMovie> favmovie) {
    _favMovies.add(favmovie);
    ChangeNotifier();
  }

  void removefromfav(List<TrendingMovie> favmovie) {
    _favMovies.remove(favmovie);
    ChangeNotifier();
  }

  contains(TrendingMovie faviritemovie) {}
}
