import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/api_bloc/api_service_bloc.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:movies_app/widgets/card_widget.dart';

class TrendingMoviesWidget extends StatefulWidget {
  const TrendingMoviesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TrendingMoviesWidget> createState() => _TrendingMoviesWidgetState();
}

class _TrendingMoviesWidgetState extends State<TrendingMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiServiceBloc, ApiServiceState>(
      builder: (context, state) {
        if ((state.dataStatus == DataStatus.loading &&
                state.trendingMovies.isEmpty) ||
            (state.dataStatus == DataStatus.success &&
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
              maxCrossAxisExtent: 140,
              crossAxisSpacing: 30,
              mainAxisSpacing: 11,
              mainAxisExtent: 240,
            ),
            itemBuilder: (BuildContext ctx, index) {
              return MovieTvCardWidget(
                fromTrendingMovie: true,
                trendingMovie: trendingMovies[index],
                onTap: () {
                  context.read<ApiServiceBloc>().add(
                        FetchMovieDetail(movieId: trendingMovies[index].id!),
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
        } else if (state.dataStatus == DataStatus.error &&
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
