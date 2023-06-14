import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants/data_constants.dart';
import 'package:movies_app/widgets/image_widget.dart';
import '../../cubit/api_cubit/api_service_cubit.dart';
import '../../cubit/api_cubit/api_service_cubit_state.dart';
import '../../models/movie/movie.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with TickerProviderStateMixin {
  List<Movie> similarMovieslist = [];
  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')} hr ${parts[1].padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    context.read<SimilarMoviesCubit>().fetchSimilarMovies(widget.movie.id!);
  }

  @override
  Widget build(BuildContext context) {
    TabController movieDetailTabController =
        TabController(length: 4, vsync: this);
    final similarCubit = context.watch<SimilarMoviesCubit>();
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
      ),
      body: BlocBuilder<MovieDetailCubit, ApiServiceCubit>(
          builder: (context, snapshot) {
        if (snapshot is TrendingMovieDetailState) {
          final movie = snapshot.movieDetail;
          return SingleChildScrollView(
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
                          const Text('  ,  '),
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
                    textAlign: TextAlign.justify,
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
                    border: Border.all(color: Colors.blue.shade900, width: 2.5),
                  ),
                  indicatorColor: Colors.blue.shade900,
                  indicatorSize: TabBarIndicatorSize.tab,
                  onTap: (value) async {
                    if (value == 0 && similarMovieslist.isEmpty) {
                      similarMovieslist = await similarCubit
                          .fetchSimilarMovies(widget.movie.id!);
                    }
                  },
                ),
                MoviesDetailTabViewWidget(
                    movieDetailTabController: movieDetailTabController),
                const SizedBox(height: 10),
              ],
            ),
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

class MoviesDetailTabViewWidget extends StatelessWidget {
  const MoviesDetailTabViewWidget({
    super.key,
    required this.movieDetailTabController,
  });

  final TabController movieDetailTabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBarView(
        controller: movieDetailTabController,
        children: [
          BlocBuilder<SimilarMoviesCubit, ApiServiceCubit>(
            builder: (context, state) {
              if (state is SimilarMoviesState) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(5),
                    itemCount: state.similarMovies.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: 110,
                                width: 80,
                                child: ImageWidget(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w500${state.similarMovies[index].poster}'),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star_rate_rounded),
                                Text('${state.similarMovies[index].rating}'),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              } else if (state is LoadingMovieState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ErrorMovieState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return const Center(
                  child: Text("Some Error Occured try again ⚠️"),
                );
              }
            },
          ),
          Text("Reviews"),
          Text("Where to watch"),
          Text("Recommendations")
        ],
      ),
    );
  }
}
