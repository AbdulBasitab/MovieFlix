import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/api_cubit/api_service_cubit.dart';
import '../cubit/api_cubit/api_service_cubit_state.dart';
import '../cubit/fav_cubit/favourite_cubit.dart';
import '../screens/tv_detail_screen.dart';

class PopularTvPage extends StatefulWidget {
  const PopularTvPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  Widget build(BuildContext context) {
    final favCubit = context.watch<FavouriteMoviesShowsCubit>();
    return BlocBuilder<TvShowsCubit, ApiServiceCubit>(
      builder: (context, snapshot) {
        if (snapshot is PopularMoviesState) {
          final popTvs = snapshot.popularTvList;
          return SliverGrid.builder(
            itemCount: snapshot.popularTvList.length,
            // shrinkWrap: false,
            // cacheExtent: 10,
            // padding: const EdgeInsets.only(top: 15, left: 9, right: 9),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 130,
              crossAxisSpacing: 30,
              mainAxisSpacing: 11,
              mainAxisExtent: 240,
            ),
            itemBuilder: (BuildContext ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        context
                            .read<PopularTvDetailCubit>()
                            .fetchPopularTvDetail(
                                popTvs[index].popTvId!.toDouble());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TvDetailPage(
                              tvpopularid: popTvs[index].popTvId!.toDouble(),
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        // alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${popTvs[index].popTvPoster}',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 7,
                            left: 67,
                            right: 0,
                            bottom: 140,
                            child: IconButton(
                              onPressed: () {
                                if (favCubit.isShowFavorited(popTvs[index]) ==
                                    true) {
                                  favCubit.removeFavShow(popTvs[index]);
                                  return;
                                }
                                favCubit.addFavShow(popTvs[index]);
                              },
                              icon: Icon(
                                Icons.favorite_rounded,
                                color: favCubit.isShowFavorited(popTvs[index])
                                    ? Colors.red
                                    : Colors.white,
                                shadows: const [
                                  Shadow(
                                    color: Colors.black45,
                                    blurRadius: 20,
                                    offset: Offset(0, 2.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 45,
                      child: Text(
                        popTvs[index].popTvTitle ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot is LoadingMovieState || snapshot is InitCubit) {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot is ErrorMovieState) {
          return const SliverToBoxAdapter(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }
        return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

// final favItem = favtv.firstWhere(
                //   (element) => element.id == favouritetv.popTvId,
                //   orElse: () => false as FavouriteMovieTv,
                // );