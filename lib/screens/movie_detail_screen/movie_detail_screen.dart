import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/bloc/movie_detail_bloc/movie_detail_bloc.dart'
    as moviedetailbloc;
import 'package:movies_app/bloc/movie_reviews_bloc/movie_reviews_bloc.dart';
import 'package:movies_app/bloc/recommended_movies_bloc/recommended_movies_bloc.dart';
import 'package:movies_app/bloc/similar_movies_bloc/similar_movies_bloc.dart';
import 'package:movies_app/bloc/watch_provider_bloc/watch_provider_bloc.dart';
import 'package:movies_app/constants/data_constants.dart';
import 'package:movies_app/constants/theme_constants.dart';
import 'package:movies_app/models/review/review.dart';
import 'package:movies_app/common_widgets/image_widget.dart';
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
            .read<SimilarMoviesBloc>()
            .add(FetchSimilarMovies(movieId: widget.movie.id!));
        context
            .read<RecommendedMoviesBloc>()
            .add(FetchRecommendedMovies(movieId: widget.movie.id!));
        context
            .read<MovieReviewsBloc>()
            .add(FetchMovieReviews(widget.movie.id!));
        context
            .read<WatchProviderBloc>()
            .add(FetchWatchProviders(movieId: widget.movie.id!));
      });
    });
  }

//TODO: Fix issues in sizes and UI if any
  @override
  Widget build(BuildContext context) {
    var watchlistBloc = context.watch<WatchlistBloc>();
    return Scaffold(
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
              if (!watchlistBloc.isMovieFavorited(widget.movie)) {
                watchlistBloc.add(AddMovieToWatchlist(widget.movie));
                showSuccessMessage(
                    "Movie added to watchlist", AppColors.primaryColor);
              } else {
                watchlistBloc.add(RemoveMovieFromWatchlist(widget.movie));
                showErrorMessage(
                    msg: "Movie removed from watchlist",
                    color: AppColors.primaryColor);
              }
            },
            icon: Icon(
              (watchlistBloc.isMovieFavorited(widget.movie))
                  ? Icons.bookmark_added_rounded
                  : Icons.bookmark_outline_rounded,
              size: 26,
              color: (watchlistBloc.isMovieFavorited(widget.movie))
                  ? AppColors.secondaryColor
                  : Colors.white,
            ),
          ),
        ],
      ),
      body: BlocBuilder<moviedetailbloc.MovieDetailBloc,
          moviedetailbloc.MovieDetailState>(builder: (context, state) {
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
                      style: AppTextStyles.numberTextStyle(
                        fontSize: 24,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Release Date:  ',
                          style: AppTextStyles.numberTextStyle(
                              fontSize: 14, textColor: AppColors.greyColor),
                        ),
                      ),
                      Text(
                        widget.movie.releaseDate!.formatDate().toString(),
                        style: AppTextStyles.numberTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 26,
                      ),
                      Text(
                        'Duration:  ',
                        style: AppTextStyles.numberTextStyle(
                            fontSize: 14, textColor: AppColors.greyColor),
                      ),
                      Text(
                        '${durationToString(movie?.runTime as int)} min',
                        style: AppTextStyles.numberTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 0),
                        child: Text(
                          'Rating:  ',
                          style: AppTextStyles.numberTextStyle(
                              fontSize: 14, textColor: AppColors.greyColor),
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber.shade600,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.movie.rating!.toStringAsFixed(1).toString(),
                        style: AppTextStyles.numberTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Genre:  ',
                          style: AppTextStyles.numberTextStyle(
                              fontSize: 14, textColor: AppColors.greyColor),
                        ),
                      ),
                      if (movie!.genres.isNotEmpty && movie.genres.length == 1)
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
                              style:
                                  AppTextStyles.customTextStyle(fontSize: 14),
                            ),
                            const Text(' , '),
                            Text(
                              movie.genres.elementAt(1).name.toString(),
                              style:
                                  AppTextStyles.customTextStyle(fontSize: 14),
                            )
                          ],
                        )),
                      if (movie.genres.isEmpty == true) (const Text('')),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      widget.movie.description ?? '',
                      textAlign: TextAlign.left,
                      style: AppTextStyles.numberTextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TabBar(
                    tabs: movieDetailPageTabs,
                    controller: movieDetailTabController,
                    padding: const EdgeInsets.all(8),
                    labelPadding: const EdgeInsets.all(12),
                    unselectedLabelStyle: AppTextStyles.unselectedItemTextStyle(
                      fontSize: 13.5,
                    ),
                    labelStyle: AppTextStyles.customTextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                    isScrollable: true,
                    indicator: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.primaryColor, width: 3),
                    ),
                    indicatorColor: AppColors.primaryColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    automaticIndicatorColorAdjustment: false,
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
        } else if (state.dataStatus == moviedetailbloc.DataStatus.error &&
            state.movieDetail == null) {
          return Center(
              child: Text(state.errorMessage ?? "Some Error Occured"));
        } else {
          return const Center(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      }),
    );
  }
}
