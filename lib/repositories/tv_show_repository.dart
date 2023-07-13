import 'package:movies_app/models/models.dart';
import 'package:movies_app/services/api_service.dart';
import 'package:movies_app/services/isar_service.dart';

class TvShowRepository {
  final ApiService _apiService;
  final IsarService _isarService;

  const TvShowRepository(this._apiService, this._isarService);

  Future<List<TvShow>> fetchPopularTvShows() async {
    try {
      return await _apiService.fetchPopularTvShows();
    } catch (e) {
      rethrow;
    }
  }

  Future<TvShowDetail?> fetchTvShowDetail(int showId) async {
    try {
      return await _apiService.fetchTvShowDetail(showId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addWatchlistedTvShowToDb(TvShow tvShow) async {
    await _isarService.addWatchListShowToDB(tvShow);
  }

  List<TvShow> fetchWatchlistedTvShowsFromDb() {
    return _isarService.fetchWatchListShowsFromDB();
  }

  Future<void> removeTvShowFromWatchlistDb(TvShow tvShow) async {
    await _isarService.removeWatchListShowFromDB(tvShow);
  }
}
