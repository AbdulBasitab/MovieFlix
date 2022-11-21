import 'package:flutter/material.dart';
import 'package:movies_app/models/trending_movie_model.dart';
import 'package:movies_app/screens/fav_movies.dart';
import 'package:provider/provider.dart';
import '../models/favourite_movies.dart';
import '../screens/movie_detail_page.dart';
import '../services/api_handler.dart';
import '../states/favourite_provider.dart';

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
    final favmovies = context.watch<Favourite>().favMovies.toList();
    final provider = Provider.of<Favourite>(context, listen: false);
    return FutureBuilder<List<TrendingMovie>>(
      future: ApiHandler().fetchTrendingMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 250,
            child: GridView.builder(
              itemCount: snapshot.data?.length,
              scrollDirection: Axis.horizontal,
              cacheExtent: 10,
              padding: const EdgeInsets.only(top: 15, left: 9, right: 9),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 700,
                crossAxisSpacing: 0,
                mainAxisSpacing: 30,
                mainAxisExtent: 115,
              ),
              itemBuilder: (BuildContext ctx, index) {
                final favouritemovie = snapshot.data![index];
                final fav = FavouriteMovieTv(
                    id: favouritemovie.movieId,
                    title: favouritemovie.movieTitle.toString(),
                    image: favouritemovie.moviePoster.toString(),
                    isFavourite: false);
                final favItem = favmovies.firstWhere(
                    (element) => element.id == favouritemovie.movieId,
                    orElse: (() => fav));

                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailPage(
                              trendmovieid:
                                  snapshot.data![index].movieId!.toDouble(),
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
                                      snapshot.data![index].moviePoster
                                          .toString(),
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
                                provider.togglefav(fav);
                                // if (favmovies.contains(fav)) {
                                //   context.read<Favourite>().removefromfav(fav);
                                //   fav.isFavourite = false;
                                // } else {
                                //   fav.isFavourite = true;
                                //   context.read<Favourite>().addtofav(fav);
                                // }
                              },
                              icon: favItem.isFavourite == true
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
                        snapshot.data?[index].movieTitle ?? '',
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
            ),
          );
        } else if (snapshot.hasError) {
          return const Text("Error");
        }
        return Text("Loading...");
      },
    );
  }
}
