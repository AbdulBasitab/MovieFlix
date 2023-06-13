import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/screens/home_screen/components/trending_movies_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/screens/search_screen/search_screen.dart';
import '../../cubit/api_cubit/api_service_cubit.dart';
import 'components/popular_tv_widget.dart';
import '../movie_screens/fav_movies_screen.dart';
import '../tv_screens/fav_shows_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MoviesCubit>().fetchTrendingMovies();
      context.read<TvShowsCubit>().fetchPopularTv();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          //foregroundColor: Colors.white,
          title: const Text(
            'MovieFlix',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          centerTitle: true,
          elevation: 2,
          toolbarHeight: 65,
          actions: [
            Hero(
              tag: 'Searchicon',
              child: IconButton(
                tooltip: "Search",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SearchScreen();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search_rounded,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FavMovies()),
                            );
                          },
                          icon: const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const TrendingMoviesPage(),
            SliverToBoxAdapter(
              child: Container(
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
                      'Popular Shows',
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FavShows()),
                        );
                      },
                      icon: const Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const PopularTvPage(),
          ],
        ),
      ),
    );
  }
}
