import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:movies_app/models/favourite_movies.dart';

class Favourite extends ChangeNotifier {
  final List<FavouriteMovieTv> _favMovies = [];
  UnmodifiableListView<FavouriteMovieTv> get favMovies =>
      UnmodifiableListView(_favMovies);

  bool _fav = false;
  bool get isFav => _fav;

  void addtofav(FavouriteMovieTv favmovietv) {
    _favMovies.add(favmovietv);
    notifyListeners();
  }

  void removefromfav(int id) {
    _favMovies.removeWhere(((element) => element.id == id));
    notifyListeners();
  }

  void togglefav(FavouriteMovieTv favmovie) {
    final isExist = _favMovies.contains(favmovie);
    if (isExist) {
      favmovie.copyWith(isFavourite: false);
      _favMovies.remove(favmovie);
    } else {
      favmovie.copyWith(isFavourite: true);
      _favMovies.add(favmovie);
    }
    notifyListeners();
  }

  bool isFavourite(FavouriteMovieTv fav) {
    final isExist = _favMovies.contains(fav);
    print(isExist);
    return isExist;
  }

  isFavorited() {
    _fav = !_fav;
    notifyListeners();
  }
}
