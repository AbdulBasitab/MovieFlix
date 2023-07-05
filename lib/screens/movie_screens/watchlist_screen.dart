import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/bloc/api_bloc/api_service_bloc.dart';
import 'package:movies_app/screens/movie_screens/movie_detail_screen.dart';
import 'package:movies_app/widgets/image_widget.dart';
import '../../bloc/fav_cubit/favourite_cubit.dart';
import '../../bloc/fav_cubit/favourite_cubit_state.dart';
import '../../models/movie/movie.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _controller.view, curve: Curves.easeIn);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favCubit = context.watch<FavouriteMoviesShowsCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Watchlist',
            style: GoogleFonts.raleway(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.blue.shade900,
          elevation: 2,
          toolbarHeight: 65,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 20,
            right: 15,
            bottom: 10,
          ),
          child:
              BlocBuilder<FavouriteMoviesShowsCubit, FavMoviesShowsCubitState>(
            builder: (context, state) {
              if (state.favouriteMovies.isNotEmpty) {
                final List<Movie> favMovies = state.favouriteMovies;
                return GridView.builder(
                  itemCount: favMovies.length,
                  itemBuilder: (BuildContext context, int index) {
                    final currentFavMovie = favMovies[index];
                    return Stack(
                      children: [
                        Container(
                          color: Colors.black,
                          height: 225,
                        ),
                        Center(
                          child: Hero(
                            tag: 'movieCard2$index',
                            placeholderBuilder: (context, heroSize, child) {
                              return Container(
                                color: Colors.black,
                                height: heroSize.height,
                                width: heroSize.width,
                                child: const SizedBox(),
                              );
                            },
                            child: Material(
                              type: MaterialType.transparency,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<ApiServiceBloc>().add(
                                          FetchMovieDetail(
                                              movieId: currentFavMovie.id!));

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailPage(
                                              movie: currentFavMovie,
                                              heroTag: 'movieCard2$index',
                                            ),
                                          ));
                                    },
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        SizedBox(
                                          height: 170,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: ImageWidget(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${currentFavMovie.poster}'),
                                          ),
                                        ),
                                        Positioned(
                                          top: 7,
                                          left: 77,
                                          right: 0,
                                          bottom: 140,
                                          child: IconButton(
                                            onPressed: () {
                                              if (favCubit.isMovieFavorited(
                                                  currentFavMovie)) {
                                                favCubit.removeFavMovie(
                                                    currentFavMovie);
                                                return;
                                              }
                                            },
                                            icon: Icon(
                                              Icons.favorite_rounded,
                                              color: favCubit.isMovieFavorited(
                                                      currentFavMovie)
                                                  ? Colors.red
                                                  : Colors.white,
                                              shadows: const [
                                                Shadow(
                                                  color: Colors.black45,
                                                  blurRadius: 20,
                                                  offset: Offset(0, 2.0),
                                                ),
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
                                      currentFavMovie.title ?? '',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
          ),
        ),
      ),
    );
  }
}
