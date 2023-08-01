import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/popular_shows_bloc/popular_shows_bloc.dart'
    as popshowsbloc;
import 'package:movies_app/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import '../../../common_widgets/card_widget.dart';
import '../../tv_detail_screen/tv_detail_screen.dart';

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
    return BlocBuilder<popshowsbloc.PopularShowsBloc,
        popshowsbloc.PopularShowsState>(
      builder: (context, state) {
        if (state.popularShows.isNotEmpty &&
            state.dataStatus == popshowsbloc.DataStatus.success) {
          final popTvs = state.popularShows;
          return SliverGrid.builder(
            itemCount: popTvs.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 0,
              mainAxisSpacing: 10,
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
                      .read<TvDetailBloc>()
                      .add(FetchTvDetail(tvShowKey: popTvs[index].id!));
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
        } else if (state.dataStatus == popshowsbloc.DataStatus.loading &&
            state.popularShows.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.dataStatus == popshowsbloc.DataStatus.error &&
            state.popularShows.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(state.errorMessage ?? "Some error occured"),
            ),
          );
        } else {
          final popTvs = state.popularShows;
          return SliverGrid.builder(
            itemCount: state.popularShows.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 0,
              mainAxisSpacing: 10,
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
                      .read<TvDetailBloc>()
                      .add(FetchTvDetail(tvShowKey: popTvs[index].id!));
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
