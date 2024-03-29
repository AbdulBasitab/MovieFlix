import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:movies_app/bloc/popular_shows_bloc/popular_shows_bloc.dart';
import 'package:movies_app/bloc/trending_movies_bloc/trending_movies_bloc.dart';
import 'package:movies_app/bloc/watchlist_bloc/watchlist_bloc.dart';
import 'package:movies_app/constants/theme_constants.dart';
import 'package:movies_app/screens/home_screen/components/trending_movies_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/popular_tv_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    fetchApiAndDbDataForFirstTime();
  }

  void fetchApiAndDbDataForFirstTime() {
    if (!context.read<NavigationBloc>().state.isDataFetched) {
      context.read<TrendingMoviesBloc>().add(FetchTrendingMovies());
      context.read<PopularShowsBloc>().add(FetchPopularShows());
      context.read<WatchlistBloc>().add(FetchWatchlistMovies());
      context.read<WatchlistBloc>().add(FetchWatchlistShows());
      return;
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const Column(children: []),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.ideographic,
          children: [
            // const SizedBox(width: 5),
            Image.asset(
              'assets/logo/movieflix.png',
              scale: 13,
            ),
            const SizedBox(width: 7),
            Text(
              'MovieFlix',
              style: GoogleFonts.raleway(
                  fontSize: 24, height: 1.6, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 10,
        toolbarHeight: 65,
        actions: const [
          SizedBox(width: 50),
        ],
      ),
      body: CustomScrollView(
        controller: widget.scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 70,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    top: 30,
                    bottom: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trending Movies',
                        style: AppTextStyles.customTextStyle(
                            fontSize: 21, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const TrendingMoviesWidget(),
          SliverToBoxAdapter(
            child: Container(
              height: 70,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 10,
                left: 20,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Shows',
                    style: AppTextStyles.customTextStyle(
                        fontSize: 21, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          const PopularTvWidget(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
