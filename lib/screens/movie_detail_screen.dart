import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/api_cubit/api_service_cubit.dart';
import '../cubit/api_cubit/api_service_cubit_state.dart';

class MovieDetailPage extends StatefulWidget {
  final double trendmovieid;
  const MovieDetailPage({
    Key? key,
    required this.trendmovieid,
  }) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')} hr ${parts[1].padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
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
                    Image(
                      height: 235,
                      width: MediaQuery.of(context).size.width,
                      // ignore: prefer_interpolation_to_compose_strings
                      image: NetworkImage(
                        // ignore: prefer_interpolation_to_compose_strings
                        'https://image.tmdb.org/t/p/w500' +
                            movie.movieBackdrop.toString(),
                      ),
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
                    movie.movieDetailTitle.toString(),
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
                      movie.releaseDate.toString(),
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
                    // Text(
                    //   '' +movie.runTime.toString() + ' min',
                    //   style: TextStyle(
                    //       color: Colors.white, fontWeight: FontWeight.bold),
                    // ),
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
                      movie.rating!.toStringAsFixed(1).toString(),
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
                    movie.description.toString(),
                    textAlign: TextAlign.justify,
                  ),
                ),
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
