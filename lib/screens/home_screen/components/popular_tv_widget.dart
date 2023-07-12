import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/api_bloc/api_service_bloc.dart';
import '../../../widgets/card_widget.dart';
import '../../tv_screen/tv_detail_screen.dart';

class PopularTvWidget extends StatefulWidget {
  const PopularTvWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularTvWidget> createState() => _PopularTvWidgetState();
}

class _PopularTvWidgetState extends State<PopularTvWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiServiceBloc, ApiServiceState>(
      builder: (context, state) {
        if (state.popularTvShows.isNotEmpty &&
            state.dataStatus == DataStatus.success) {
          final popTvs = state.popularTvShows;
          return SliverGrid.builder(
            itemCount: state.popularTvShows.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 130,
              crossAxisSpacing: 30,
              mainAxisSpacing: 11,
              mainAxisExtent: 240,
            ),
            itemBuilder: (BuildContext ctx, index) {
              return MovieTvCardWidget(
                popTv: popTvs[index],

                posterImage:
                    'https://image.tmdb.org/t/p/w500${popTvs[index].poster}',
                fromTrendingMovie: false,
                onTap: () {
                  context
                      .read<ApiServiceBloc>()
                      .add(FetchTvShowDetail(tvShowId: popTvs[index].id!));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TvDetailScreen(
                        tvShow: popTvs[index],
                      ),
                    ),
                  );
                },
                // onFavouriteTap: () {
                //   if (favCubit.isShowFavorited(popTvs[index]) == true) {
                //     favCubit.removeFavShow(popTvs[index]);
                //     return;
                //   }
                //   favCubit.addFavShow(popTvs[index]);
                // },
              );
            },
          );
        } else if (state.dataStatus == DataStatus.loading &&
            state.popularTvShows.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.dataStatus == DataStatus.error &&
            state.popularTvShows.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(state.errorMessage ?? "Some error occured"),
            ),
          );
        } else {
          final popTvs = state.popularTvShows;
          return SliverGrid.builder(
            itemCount: state.popularTvShows.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 130,
              crossAxisSpacing: 30,
              mainAxisSpacing: 11,
              mainAxisExtent: 240,
            ),
            itemBuilder: (BuildContext ctx, index) {
              return MovieTvCardWidget(
                popTv: popTvs[index],
                posterImage:
                    'https://image.tmdb.org/t/p/w500${popTvs[index].poster}',
                fromTrendingMovie: false,
                onTap: () {
                  context
                      .read<ApiServiceBloc>()
                      .add(FetchTvShowDetail(tvShowId: popTvs[index].id!));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TvDetailScreen(
                        tvShow: popTvs[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
