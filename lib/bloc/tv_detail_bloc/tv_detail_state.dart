// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tv_detail_bloc.dart';

enum DataStatus { success, error, loading }

class TvDetailState {
  final DataStatus? dataStatus;
  final String? errorMessage;
  final TvShowDetail? tvShowDetail;
  TvDetailState({
    this.dataStatus,
    this.errorMessage,
    this.tvShowDetail,
  });

  TvDetailState copyWith({
    DataStatus? dataStatus,
    String? errorMessage,
    TvShowDetail? tvShowDetail,
  }) {
    return TvDetailState(
      dataStatus: dataStatus ?? this.dataStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      tvShowDetail: tvShowDetail ?? this.tvShowDetail,
    );
  }
}

@immutable
sealed class TvDetailEvent {
  const TvDetailEvent();
}

class FetchTvDetail extends TvDetailEvent {
  final int tvShowKey;
  const FetchTvDetail({
    required this.tvShowKey,
  });
}
