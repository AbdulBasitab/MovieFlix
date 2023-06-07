import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/widgets/trending_movies_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/api_cubit/api_service_cubit.dart';
import '../widgets/popular_tv_widget.dart';
import 'fav_movies_screen.dart';
import 'fav_shows_screen.dart';

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
          title: const Text('MovieFlix'),
          centerTitle: true,
          elevation: 2,
          toolbarHeight: 65,
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
