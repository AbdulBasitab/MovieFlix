import 'package:flutter/material.dart';
import 'package:movies_app/models/trending_movie_model.dart';
import 'package:provider/provider.dart';
import '../states/favourite_provider.dart';

class FavMovies extends StatefulWidget {
  const FavMovies({Key? key}) : super(key: key);

  @override
  State<FavMovies> createState() => _FavMoviesState();
}

class _FavMoviesState extends State<FavMovies> {
  @override
  Widget build(BuildContext context) {
    final favMovies = context.watch<Favourite>().favMovies;
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
        child: GridView.builder(
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
                                currentFavMovie.image.toString(),
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
                          if (favMovies.contains(currentFavMovie)) {
                            context
                                .read<Favourite>()
                                .removefromfav(currentFavMovie.id!);
                          }
                        },
                        icon: Icon(
                          Icons.favorite_rounded,
                          color: favMovies.contains(currentFavMovie)
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
                    currentFavMovie.title ?? '',
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
        ),
      ),
    );
  }
}
