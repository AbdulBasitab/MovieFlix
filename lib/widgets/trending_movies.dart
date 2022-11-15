import 'package:flutter/material.dart';
import 'package:movies_app/models/trending_movie_model.dart';
import '../screens/home_page.dart';
import '../screens/movie_detail_page.dart';
import 'api_handler.dart';

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
    return FutureBuilder<List<TrendingMovie>>(
      future: ApiHandler().fetchTrendingMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: GridView.builder(
              itemCount: snapshot.data?.length,
              shrinkWrap: false,
              padding: EdgeInsets.only(top: 15, left: 9, right: 9),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 110,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                mainAxisExtent: 190,
              ),
              itemBuilder: (BuildContext ctx, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetailPage(
                                    trendmovieid: snapshot.data![index].movieId
                                        .toDouble(),
                                  )),
                        );
                      },
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              // ignore: prefer_interpolation_to_compose_strings
                              'https://image.tmdb.org/t/p/w500' +
                                  snapshot.data![index].imageMoviePath,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      height: 40,
                      child: Text(
                        snapshot.data?[index].movieTitle ?? '',
                        style: const TextStyle(
                          fontSize: 11,
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
          return Text("Error");
        }
        return Text("Loading...");
      },
    );
  }
}
