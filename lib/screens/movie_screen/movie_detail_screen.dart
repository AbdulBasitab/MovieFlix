import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/bloc/api_bloc/api_service_bloc.dart';
import 'package:movies_app/constants/data_constants.dart';
import 'package:movies_app/models/review/review.dart';
import 'package:movies_app/widgets/image_widget.dart';
import '../../bloc/watchlist_bloc/watchlist_bloc.dart';
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
        context
            .read<ApiServiceBloc>()
            .add(FetchSimilarMovies(widget.movie.id!));
        context
            .read<ApiServiceBloc>()
            .add(FetchRecommendedMovies(widget.movie.id!));
        context.read<ApiServiceBloc>().add(FetchMovieReviews(widget.movie.id!));
        context
            .read<ApiServiceBloc>()
            .add(FetchMovieWatchProvider(widget.movie.id!));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var watchlistBloc = context.watch<WatchlistBloc>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
          title: Text(
            "Detail",
            style: GoogleFonts.raleway(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                (!watchlistBloc.isMovieFavorited(widget.movie))
                    ? watchlistBloc.add(AddMovieToWatchlist(widget.movie))
                    : watchlistBloc.add(RemoveMovieFromWatchlist(widget.movie));
              },
              icon: Icon(
                (watchlistBloc.isMovieFavorited(widget.movie))
                    ? Icons.bookmark_added_rounded
                    : Icons.bookmark_outline_rounded,
                size: 26,
                color: (watchlistBloc.isMovieFavorited(widget.movie))
                    ? Colors.amber.shade500
                    : Colors.white,
              ),
            ),
          ],
        ),
        body: BlocBuilder<ApiServiceBloc, ApiServiceState>(
            builder: (context, state) {
          if (state.movieDetail != null) {
            final movie = state.movieDetail;
            return ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Column(
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
                          '${durationToString(movie?.runTime as int)} min',
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
                        if (movie!.genres.isNotEmpty &&
                            movie.genres.length == 1)
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
              ],
            );
          } else if (state.dataStatus == DataStatus.error &&
              state.movieDetail == null) {
            return Center(
                child: Text(state.errorMessage ?? "Some Error Occured"));
          }
          // else if (state.dataStatus == DataStatus.loading) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          else {
            return const Center(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        }),
      ),
    );
  }
}
