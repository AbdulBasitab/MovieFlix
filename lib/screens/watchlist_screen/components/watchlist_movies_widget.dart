import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/api_bloc/api_service_bloc.dart';
import 'package:movies_app/bloc/watchlist_bloc/watchlist_bloc.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:movies_app/widgets/card_widget.dart';

class WatchlistMoviesWidget extends StatelessWidget {
  const WatchlistMoviesWidget({
    super.key,
    required Animation<double> animation,
  }) : _animation = animation;

  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state.watchlistedMovies.isNotEmpty) {
          final List<Movie> watchlistedMovies = state.watchlistedMovies;
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: watchlistedMovies.length,
            itemBuilder: (BuildContext context, int index) {
              final movie = watchlistedMovies[index];
              return MovieTvCardWidget(
                onTap: () {
                  context
                      .read<ApiServiceBloc>()
                      .add(FetchMovieDetail(movieId: movie.id!));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                          movie: movie,
                          heroTag: 'movieCard2$index',
                        ),
                      ));
                },
                posterImage: 'https://image.tmdb.org/t/p/w500${movie.poster}',
                fromTrendingMovie: true,
                trendingMovie: movie,
              );
            },
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 130,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              mainAxisExtent: 240,
            ),
          );
        } else {
          return Center(
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/empty_watchlist.png'),
                  const SizedBox(height: 30),
                  Text(
                    "Uh-oh! Your watchlist is empty. Time to fill it up! 🍿",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
