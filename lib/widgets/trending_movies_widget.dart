import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/cubit/api_service_cubit.dart';
import 'package:movies_app/models/trending_movie_model.dart';
import '../cubit/api_service_cubit_state.dart';
import '../cubit/favourite_cubit.dart';
import '../screens/movie_detail_screen.dart';

class TrendingMoviesPage extends StatefulWidget {
  const TrendingMoviesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TrendingMoviesPage> createState() => _TrendingMoviesPageState();
}

class _TrendingMoviesPageState extends State<TrendingMoviesPage> {
  @override
  Widget build(BuildContext context) {
    final favCubit = context.watch<FavouriteMoviesShowsCubit>();
    return BlocBuilder<MoviesCubit, ApiServiceCubit>(
      builder: (context, state) {
        //   context.read<FetchTrendingMoviesCubit>().fetchTrendingMovies();
        if (state is LoadingMovieState || state is InitCubit) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is TrendingMovieState) {
          final trendingMovies = state.trendingMovies;
          return SliverGrid.builder(
            itemCount: state.trendingMovies.length,
            // scrollDirection: Axis.horizontal,
            // cacheExtent: 10,
            // padding: const EdgeInsets.only(top: 15, left: 9, right: 9),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 140,
              crossAxisSpacing: 30,
              mainAxisSpacing: 11,
              mainAxisExtent: 240,
            ),
            itemBuilder: (BuildContext ctx, index) {
              // final favouritemovie = state[index];
              // final fav = FavouriteMovieTv(
              //     id: favouritemovie.movieId,
              //     title: favouritemovie.movieTitle.toString(),
              //     image: favouritemovie.moviePoster.toString(),
              //     isFavourite: false);
              // final favItem = favmovies.firstWhere(
              //     (element) => element.id == favouritemovie.movieId,
              //     orElse: (() => fav));

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        context
                            .read<MovieDetailCubit>()
                            .fetchTrendingMovieDetail(
                              trendingMovies[index].movieId!.toDouble(),
                            );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailPage(
                              trendmovieid:
                                  trendingMovies[index].movieId!.toDouble(),
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        //alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  'https://image.tmdb.org/t/p/w500' +
                                      trendingMovies[index]
                                          .moviePoster
                                          .toString(),
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
                                if (favCubit.isMovieFavorited(
                                        trendingMovies[index]) ==
                                    true) {
                                  favCubit
                                      .removeFavMovie(trendingMovies[index]);
                                  return;
                                }
                                favCubit.addFavMovie(trendingMovies[index]);
                              },
                              icon: favCubit
                                      .isMovieFavorited(trendingMovies[index])
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black45,
                                          blurRadius: 20,
                                          offset: Offset(0, 2.0),
                                        )
                                      ],
                                    )
                                  : const Icon(
                                      Icons.favorite_outline_rounded,
                                      color: Colors.white,
                                      shadows: [
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
                        trendingMovies[index].movieTitle ?? '',
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
        } else if (state is ErrorMovieState) {
          SliverToBoxAdapter(
            child: Center(
              child: Text(state.errorMessage),
            ),
          );
        }
        return SliverToBoxAdapter(
          child: Center(
            child: Text(state.toString()),
          ),
        );
      },
      // listener: (context, state) {
      //   if (state.isEmpty) {
      //     print("No movies found");
      //   }
      // },
      // bloc: FetchTrendingMoviesCubit(),
    );

    // FutureBuilder<List<TrendingMovie>>(
    //   future: ApiHandler().fetchTrendingMovies(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return SizedBox(
    //         height: 250,
    //         child: GridView.builder(
    //           itemCount: snapshot.data?.length,
    //           scrollDirection: Axis.horizontal,
    //           cacheExtent: 10,
    //           padding: const EdgeInsets.only(top: 15, left: 9, right: 9),
    //           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //             maxCrossAxisExtent: 700,
    //             crossAxisSpacing: 0,
    //             mainAxisSpacing: 30,
    //             mainAxisExtent: 115,
    //           ),
    //           itemBuilder: (BuildContext ctx, index) {
    //             final favouritemovie = snapshot.data![index];
    //             final fav = FavouriteMovieTv(
    //                 id: favouritemovie.movieId,
    //                 title: favouritemovie.movieTitle.toString(),
    //                 image: favouritemovie.moviePoster.toString(),
    //                 isFavourite: false);
    //             final favItem = favmovies.firstWhere(
    //                 (element) => element.id == favouritemovie.movieId,
    //                 orElse: (() => fav));

    //             return Column(
    //               children: [
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => MovieDetailPage(
    //                           trendmovieid:
    //                               snapshot.data![index].movieId!.toDouble(),
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                   child: Stack(
    //                     //alignment: Alignment.topRight,
    //                     children: [
    //                       Container(
    //                         height: 170,
    //                         decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(10),
    //                           shape: BoxShape.rectangle,
    //                           image: DecorationImage(
    //                             fit: BoxFit.contain,
    //                             image: NetworkImage(
    //                               // ignore: prefer_interpolation_to_compose_strings
    //                               'https://image.tmdb.org/t/p/w500' +
    //                                   snapshot.data![index].moviePoster
    //                                       .toString(),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Positioned(
    //                         top: 7,
    //                         left: 77,
    //                         right: 0,
    //                         bottom: 140,
    //                         child: IconButton(
    //                           onPressed: () {},
    //                           icon: favItem.isFavourite == true
    //                               ? const Icon(
    //                                   Icons.favorite,
    //                                   color: Colors.red,
    //                                   shadows: [
    //                                     Shadow(
    //                                       color: Colors.black45,
    //                                       blurRadius: 20,
    //                                       offset: Offset(0, 2.0),
    //                                     )
    //                                   ],
    //                                 )
    //                               : const Icon(
    //                                   Icons.favorite_outline_rounded,
    //                                   color: Colors.white,
    //                                   shadows: [
    //                                     Shadow(
    //                                       color: Colors.black45,
    //                                       blurRadius: 20,
    //                                       offset: Offset(0, 2.0),
    //                                     )
    //                                   ],
    //                                 ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 10,
    //                 ),
    //                 SizedBox(
    //                   height: 45,
    //                   child: Text(
    //                     snapshot.data?[index].movieTitle ?? '',
    //                     style: const TextStyle(
    //                       fontSize: 13,
    //                       fontWeight: FontWeight.bold,
    //                       color: Colors.white70,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             );
    //           },
    //         ),
    //       );
    //     } else if (snapshot.hasError) {
    //       return const Text("Error");
    //     }
    //     return Text("Loading...");
    //   },
    // );
  }
}
