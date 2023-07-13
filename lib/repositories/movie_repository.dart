import 'package:movies_app/models/models.dart';
import 'package:movies_app/services/api_service.dart';
import 'package:movies_app/services/isar_service.dart';

class MovieRepository {
  final ApiService _apiService;
  final IsarService _isarService;

  const MovieRepository(this._apiService, this._isarService);

  Future<List<Movie>> fetchTrendingMovies() async {
    try {
      return await _apiService.fetchTrendingMovies();
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieDetail?> fetchMovieDetail(int movieId) async {
    try {
      return await _apiService.fetchMovieDetail(movieId);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Movie>> fetchSimilarMovies(int movieId) async {
    try {
      return await _apiService.fetchSimilarMovies(movieId);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Movie>> fetchRecommendedMovies(int movieId) async {
    try {
      return await _apiService.fetchRecommendedMovies(movieId);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Movie>> fetchSearchedMovies(String searchQuery) async {
    try {
      return await _apiService.searchMovies(searchQuery);
    } catch (e) {
      rethrow;
    }
  }

  Future<WatchProvider?> fetchMoviesWatchProviders(int movieId) async {
    try {
      return await _apiService.fetchMovieWatchProviders(movieId);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Review>> fetchMovieReviews(int movieId) async {
    try {
      return await _apiService.fetchMovieReviews(movieId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addWatchlistedMovieToDb(Movie movie) async {
    await _isarService.addWatchListMovieToDB(movie);
  }

  List<Movie> fetchWatchlistedMoviesFromDb() {
    return _isarService.fetchWatchListMoviesFromDB();
  }

  Future<void> removeMovieFromWatchlistDb(Movie movie) async {
    await _isarService.removeWatchListMovieFromDB(movie);
  }
}
