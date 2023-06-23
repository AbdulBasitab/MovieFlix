import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants/data_constants.dart';
import 'package:movies_app/cubit/fav_cubit/favourite_cubit.dart';
import 'package:movies_app/models/review/review.dart';
import 'package:movies_app/widgets/image_widget.dart';
import '../../cubit/api_cubit/api_service_bloc.dart';
import '../../cubit/api_cubit/api_service_cubit_state.dart';
import '../../models/movie/movie.dart';
import 'components/movie_detail_tabview.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final String heroTag;
  const MovieDetailPage({
    Key? key,
    required this.movie,
    required this.heroTag,
  }) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with TickerProviderStateMixin {
  List<Movie> recommendedMovieslist = [];
  List<Review> movieReviewsList = [];
  int selectedIndex = 0;
  late TabController movieDetailTabController;

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')} hr ${parts[1].padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    movieDetailTabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1), () {
        context.read<SimilarMoviesCubit>().fetchSimilarMovies(widget.movie.id!);
        context
            .read<RecommendedMoviesCubit>()
            .fetchRecommendedMovies(widget.movie.id!);
        context.read<MovieReviewsCubit>().fetchMovieReviews(widget.movie.id!);
        context
            .read<MovieWatchProviderCubit>()
            .fetchMovieWatchProviders(widget.movie.id!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var favCubit = context.watch<FavouriteMoviesShowsCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Detail",
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              favCubit.addFavMovie(widget.movie);
            },
            icon: Icon(
              (favCubit.isMovieFavorited(widget.movie))
                  ? Icons.bookmark_added_rounded
                  : Icons.bookmark_outline_rounded,
              size: 26,
              color: (favCubit.isMovieFavorited(widget.movie))
                  ? Colors.amber.shade500
                  : Colors.white,
            ),
          ),
        ],
      ),
      body: BlocBuilder<MovieDetailCubit, ApiServiceBloc>(
          builder: (context, snapshot) {
        if (snapshot is fetchMovieDetail) {
          final movie = snapshot.movieDetail;
          return ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Hero(
                tag: widget.heroTag,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ImageWidget(
                          height: 235,
                          width: MediaQuery.of(context).size.width,
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${widget.movie.backdrop}',
                          iconSize: 24,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 18,
                        bottom: 12,
                      ),
                      child: Text(
                        widget.movie.title.toString(),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Release Date:  ',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          widget.movie.releaseDate!.formatDate().toString(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        const Text(
                          'Duration:  ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '${durationToString(movie.runTime as int)} min',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 0),
                          child: Text(
                            'Rating:  ',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          widget.movie.rating!.toStringAsFixed(1).toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber.shade600,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Genre:  ',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        if (movie.genres.isNotEmpty && movie.genres.length == 1)
                          Text(
                            movie.genres.elementAt(0).name.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (movie.genres.length == 2 || movie.genres.length > 2)
                          (Row(
                            children: [
                              Text(
                                movie.genres.elementAt(0).name.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(' , '),
                              Text(
                                movie.genres.elementAt(1).name.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )),
                        if (movie.genres.isEmpty == true) (const Text('')),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        widget.movie.description.toString(),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TabBar(
                      tabs: movieDetailPageTabs,
                      controller: movieDetailTabController,
                      padding: const EdgeInsets.all(8),
                      labelPadding: const EdgeInsets.all(12),
                      isScrollable: true,
                      indicator: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.blue.shade900, width: 2.5),
                      ),
                      indicatorColor: Colors.blue.shade900,
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: (index) async {
                        setState(() {
                          selectedIndex = index;
                          movieDetailTabController.animateTo(index);
                        });
                      },
                    ),
                    MoviesDetailTabViewWidget(
                      movieDetailTabController: movieDetailTabController,
                      selectedIndex: selectedIndex,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot is ErrorMovieState) {
          return const Center(child: Text('Error 404'));
        } else if (snapshot is LoadingMovieState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(
            child: Text("Some Error Occured"),
          );
        }
      }),
    );
  }
}
