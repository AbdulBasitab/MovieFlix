import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movies_app/bloc/trending_movies_bloc/trending_movies_bloc.dart'
    as trendingmoviebloc;
import 'package:movies_app/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:movies_app/common_widgets/card_widget.dart';

class TrendingMoviesWidget extends StatefulWidget {
  const TrendingMoviesWidget({
    super.key,
  });

  @override
  State<TrendingMoviesWidget> createState() => _TrendingMoviesWidgetState();
}

class _TrendingMoviesWidgetState extends State<TrendingMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<trendingmoviebloc.TrendingMoviesBloc,
        trendingmoviebloc.TrendingMoviesState>(
      builder: (context, state) {
        if ((state.dataStatus == trendingmoviebloc.DataStatus.loading &&
                state.trendingMovies.isEmpty) ||
            (state.dataStatus == trendingmoviebloc.DataStatus.success &&
                state.trendingMovies.isEmpty)) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.trendingMovies.isNotEmpty) {
          final trendingMovies = state.trendingMovies;
          return SliverGrid.builder(
            itemCount: state.trendingMovies.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 5,
              mainAxisSpacing: 0,
              mainAxisExtent: 215,
            ),
            itemBuilder: (BuildContext ctx, index) {
              return MovieTvCardWidget(
                fromTrendingMovie: true,
                trendingMovie: trendingMovies[index],
                onTap: () {
                  context.read<MovieDetailBloc>().add(
                        FetchMovieDetail(movieKey: trendingMovies[index].id!),
                      );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(
                        movie: trendingMovies[index],
                        heroTag: 'movieCard$index',
                      ),
                    ),
                  );
                },
                posterImage:
                    'https://image.tmdb.org/t/p/w500${trendingMovies[index].poster}',
              );
            },
          );
        } else if (state.dataStatus == trendingmoviebloc.DataStatus.error &&
            state.trendingMovies.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child:
                  Text(state.errorMessage ?? 'Failed to load trending movies'),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
          //   final trendingMovies = state.trendingMovies;
          //   return SliverGrid.builder(
          //     itemCount: state.trendingMovies.length,
          //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          //       maxCrossAxisExtent: 140,
          //       crossAxisSpacing: 30,
          //       mainAxisSpacing: 11,
          //       mainAxisExtent: 240,
          //     ),
          //     itemBuilder: (BuildContext ctx, index) {
          //       return Hero(
          //         tag: 'movieCard$index',
          //         child: Material(
          //           type: MaterialType.transparency,
          //           child: MovieTvCardWidget(
          //             fromTrendingMovie: true,
          //             trendingMovie: trendingMovies[index],
          //             onTap: () {
          //               context.read<ApiServiceBloc>().add(
          //                     FetchMovieDetail(
          //                         movieId: trendingMovies[index].id!),
          //                   );
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) => MovieDetailPage(
          //                     movie: trendingMovies[index],
          //                     heroTag: 'movieCard$index',
          //                   ),
          //                 ),
          //               );
          //             },
          //             posterImage:
          //                 'https://image.tmdb.org/t/p/w500${trendingMovies[index].poster}',
          //           ),
          //         ),
          //       );
          //     },
          //   );
        }
      },
    );
  }
}
