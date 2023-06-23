import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/api_cubit/api_service_bloc.dart';
import '../../../cubit/api_cubit/api_service_cubit_state.dart';
import '../../../cubit/fav_cubit/favourite_cubit.dart';
import '../../../widgets/card_widget.dart';
import '../../tv_screens/tv_detail_screen.dart';

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
    final favCubit = context.watch<FavouriteMoviesShowsCubit>();
    return BlocBuilder<TvShowsCubit, ApiServiceBloc>(
      builder: (context, snapshot) {
        if (snapshot is FetchPopularTvShows) {
          final popTvs = snapshot.popularTvList;
          return SliverGrid.builder(
            itemCount: snapshot.popularTvList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 130,
              crossAxisSpacing: 30,
              mainAxisSpacing: 11,
              mainAxisExtent: 240,
            ),
            itemBuilder: (BuildContext ctx, index) {
              return MovieTvCardWidget(
                popTv: popTvs[index],
                favCubit: favCubit,
                posterImage:
                    'https://image.tmdb.org/t/p/w500${popTvs[index].poster}',
                fromTrendingMovie: false,
                onTap: () {
                  context
                      .read<PopularTvDetailCubit>()
                      .fetchPopularTvDetail(popTvs[index].id!.toDouble());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TvDetailPage(
                        tvShow: popTvs[index],
                      ),
                    ),
                  );
                },
                onFavouriteTap: () {
                  if (favCubit.isShowFavorited(popTvs[index]) == true) {
                    favCubit.removeFavShow(popTvs[index]);
                    return;
                  }
                  favCubit.addFavShow(popTvs[index]);
                },
              );
            },
          );
        } else if (snapshot is LoadingMovieState || snapshot is InitCubit) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot is ErrorMovieState) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
