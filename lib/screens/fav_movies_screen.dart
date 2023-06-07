import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/trending_movie_model.dart';

import '../cubit/fav_cubit/favourite_cubit.dart';
import '../cubit/fav_cubit/favourite_cubit_state.dart';

class FavMovies extends StatefulWidget {
  const FavMovies({Key? key}) : super(key: key);

  @override
  State<FavMovies> createState() => _FavMoviesState();
}

class _FavMoviesState extends State<FavMovies> {
  @override
  Widget build(BuildContext context) {
    final favCubit = context.watch<FavouriteMoviesShowsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Movies'),
        backgroundColor: Colors.blue.shade900,
        elevation: 2,
        toolbarHeight: 65,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 20,
          right: 15,
          bottom: 10,
        ),
        child: BlocBuilder<FavouriteMoviesShowsCubit, FavMoviesShowsCubitState>(
          builder: (context, state) {
            if (state.favouriteMovies.isNotEmpty) {
              final List<TrendingMovie> favMovies = state.favouriteMovies;
              return GridView.builder(
                itemCount: favMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  final currentFavMovie = favMovies[index];
                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
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
                                      currentFavMovie.moviePoster.toString(),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 7,
                            left: 77,
                            right: 0,
                            bottom: 140,
                            child: IconButton(
                              onPressed: () {
                                if (favCubit
                                    .isMovieFavorited(currentFavMovie)) {
                                  favCubit.removeFavMovie(currentFavMovie);
                                  return;
                                }
                              },
                              icon: Icon(
                                Icons.favorite_rounded,
                                color:
                                    favCubit.isMovieFavorited(currentFavMovie)
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
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        child: Text(
                          currentFavMovie.movieTitle ?? '',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
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
              return const Center(
                child: Text(
                  "No Favourite Movies added yet",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
