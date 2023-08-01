import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/repositories/tv_show_repository.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  TvDetailBloc({required TvShowRepository tvShowRepository})
      : _tvShowRepository = tvShowRepository,
        super(TvDetailState(
          dataStatus: DataStatus.loading,
          errorMessage: '',
        )) {
    on<FetchTvDetail>((event, emit) async {
      final tvShowDetail = await fetchTvDetail(event.tvShowKey);
      if (tvShowDetail != null) {
        emit(state.copyWith(
          dataStatus: DataStatus.success,
          tvShowDetail: tvShowDetail,
        ));
      } else {
        emit(state.copyWith(
          dataStatus: DataStatus.error,
          errorMessage:
              'Failed to fetch show detail.Check your Internet Connection and Try Again',
          tvShowDetail: tvShowDetail,
        ));
      }
    });
  }
  final TvShowRepository _tvShowRepository;

  Future<TvShowDetail?> fetchTvDetail(int tvShowKey) async {
    final tvShowDetail = await _tvShowRepository.fetchTvShowDetail(tvShowKey);
    return tvShowDetail;
  }
}
