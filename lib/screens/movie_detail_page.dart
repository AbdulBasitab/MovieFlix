import 'package:flutter/material.dart';
import 'package:movies_app/models/moviedetail_model.dart';
import '../services/api_handler.dart';

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
      ),
      body: FutureBuilder<TrendingMovieDetail>(
          future: ApiHandler().fetchTrendingMovieDetail(widget.trendmovieid),
          builder: (context, snapshot) {
            //print(snapshot.data);

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
                              snapshot.data!.movieBackdrop.toString(),
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
                        snapshot.data!.releaseDate.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      const Text(
                        'Duration:  ',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '' +
                            durationToString(snapshot.data?.runTime as int) +
                            ' min',
                      ),
                      // Text(
                      //   '' + snapshot.data!.runTime.toString() + ' min',
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
                        snapshot.data!.rating!.toStringAsFixed(1).toString(),
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
                      if (snapshot.data!.genres.isNotEmpty &&
                          snapshot.data!.genres.length == 1)
                        Text(
                          snapshot.data!.genres.elementAt(0).name.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (snapshot.data!.genres.length == 2 ||
                          snapshot.data!.genres.length > 2)
                        (Row(
                          children: [
                            Text(
                              snapshot.data!.genres
                                  .elementAt(0)
                                  .name
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('  ,  '),
                            Text(
                              snapshot.data!.genres
                                  .elementAt(1)
                                  .name
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )),
                      if (snapshot.data!.genres.isEmpty == true) (Text('')),
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
