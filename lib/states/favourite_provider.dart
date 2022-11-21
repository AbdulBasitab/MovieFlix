import 'package:flutter/material.dart';
import 'package:movies_app/models/popular_tv_model.dart';
import 'package:movies_app/models/trending_movie_model.dart';

class Favourite extends ChangeNotifier {
  List<TrendingMovie> _favMovies = [];
  List<PopularTv> _favTvShows = [];
  List<TrendingMovie> get favMovies => _favMovies;
  List<PopularTv> get favTvShows => _favTvShows;

  void addtofavtv(PopularTv favtv) {
    _favTvShows.add(favtv);
    notifyListeners();
  }

  void removefromfavtv(PopularTv favtv) {
    _favTvShows.remove(favtv);
    notifyListeners();
  }

  void addtofav(TrendingMovie favmovie) {
    if (!_favMovies.contains(favmovie.movieId)) {
      _favMovies.add(favmovie);
      notifyListeners();
    } else
      _favMovies.remove(favmovie);
    notifyListeners();
  }

  void removefromfav(TrendingMovie favmovie) {
    _favMovies.remove(favmovie);
    notifyListeners();
  }
}
