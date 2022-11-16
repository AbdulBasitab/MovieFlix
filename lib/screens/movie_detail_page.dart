// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:movies_app/models/moviedetail_model.dart';

import '../models/trending_movie_model.dart';
import '../widgets/api_handler.dart';

class MovieDetailPage extends StatelessWidget {
  final double trendmovieid;
  const MovieDetailPage({
    Key? key,
    required this.trendmovieid,
  }) : super(key: key);

//   @override
//   State<MovieDetailPage> createState() => _MovieDetailPageState();
// }

// class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<TrendingMovieDetail>(
          future: ApiHandler().fetchTrendingMovieDetail(trendmovieid),
          builder: (context, snapshot) {
            //print(snapshot.data);
            print(snapshot.error);
            if (snapshot.hasData) {
              return Column(
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
                              snapshot.data!.backdrop.toString(),
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
                      snapshot.data!.movieDetailTitle.toString(),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
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
                        snapshot.data!.releaseDate.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 70,
                      ),
                      const Text(
                        'Duration:  ',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      // ignore: prefer_interpolation_to_compose_strings
                      Text(
                        '' + snapshot.data!.runTime.toString() + ' min',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
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
                          'Rating:  ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Text(
                        snapshot.data!.rating!.roundToDouble().toString(),
                        style: TextStyle(
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
                    height: 25,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      snapshot.data!.description.toString(),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return const Text('Loading');
            }
          }),
    );
  }
}
