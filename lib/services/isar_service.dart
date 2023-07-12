import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:movies_app/models/movie/movie.dart';
import 'package:movies_app/models/tv_show/tv_show.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static Isar? isar;

  static Future<void> isarDBInit() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([MovieSchema, TvShowSchema], directory: dir.path);
  }

  Future<void> addWatchListMovieToDB(Movie movie) async {
    isar!.writeTxn(() async {
      final moviesCollection = isar!.movies;
      moviesCollection.put(movie).then((value) => debugPrint("$value"));
    });
  }

  List<Movie> fetchWatchListMoviesFromDB() {
    List<Movie> watchlistMovies = [];
    isar!.writeTxnSync(() {
      watchlistMovies = isar!.movies.where().findAllSync();
    });
    return watchlistMovies;
  }

  Future<void> removeWatchListMovieFromDB(Movie movie) async {
    isar!.writeTxn(() async {
      final moviesCollection = isar!.movies;
      moviesCollection
          .delete(movie.isarId)
          .then((value) => debugPrint("$value"));
    });
  }

  Future<void> addWatchListShowToDB(TvShow show) async {
    isar!.writeTxn(() async {
      final showsCollection = isar!.tvShows;
      showsCollection.put(show).then((value) => debugPrint("$value"));
    });
  }

  Future<void> removeWatchListShowFromDB(TvShow show) async {
    isar!.writeTxn(() async {
      final showsCollection = isar!.tvShows;
      showsCollection.delete(show.isarId).then((value) => debugPrint("$value"));
    });
  }

  List<TvShow> fetchWatchListShowsFromDB() {
    List<TvShow> watchlistedShows = [];
    isar!.writeTxnSync(() {
      watchlistedShows = isar!.tvShows.where().findAllSync();
    });
    return watchlistedShows;
  }
}
