import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/tv_show/tv_show.dart';
import 'package:movies_app/repositories/tv_show_repository.dart';

part 'popular_shows_state.dart';

class PopularShowsBloc extends Bloc<PopularShowsEvent, PopularShowsState> {
  PopularShowsBloc({required TvShowRepository tvShowRepository})
      : _tvShowRepository = tvShowRepository,
        super(PopularShowsState(
          dataStatus: DataStatus.loading,
          errorMessage: '',
          popularShows: [],
        )) {
    on<FetchPopularShows>((event, emit) async {
      final popularShows = await fetchPopularShows();
      if (popularShows.isNotEmpty) {
        emit(state.copyWith(
            popularShows: popularShows, dataStatus: DataStatus.success));
      } else {
        emit(
          state.copyWith(
              dataStatus: DataStatus.error,
              errorMessage:
                  'Failed to fetch Tv Shows.Check your Internet Connection and Try Again'),
        );
      }
    });
  }

  final TvShowRepository _tvShowRepository;

  Future<List<TvShow>> fetchPopularShows() async {
    final popularShows = await _tvShowRepository.fetchPopularTvShows();
    return popularShows;
  }
}
