import 'package:flutter/material.dart';
import 'package:movies_app/widgets/trending_movies.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/popular_tv.dart';
import 'fav_movies.dart';
import 'fav_shows.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final fav = context.watch<Favourite>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          //foregroundColor: Colors.white,
          title: const Text('MovieFlix'),
          elevation: 2,
          toolbarHeight: 65,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 1070,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trending Movies',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavMovies()),
                            );
                          });
                        },
                        icon: const Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
                const TrendingMoviesPage(),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 15,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Tv Shows',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FavShows()),
                            );
                          });
                        },
                        icon: const Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
                const PopularTvPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
