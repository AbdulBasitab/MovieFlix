import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/screens/home_screen/components/trending_movies_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../bloc/api_bloc/api_service_bloc.dart';
import 'components/popular_tv_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    context.read<ApiServiceBloc>().add(FetchTrendingMovies());
    context.read<ApiServiceBloc>().add(FetchPopularTvShows());
    // });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.ideographic,
            children: [
              const SizedBox(width: 5),
              Image.asset(
                'assets/logo/movieflix.png',
                scale: 14,
              ),
              const SizedBox(width: 7),
              Text(
                'MovieFlix',
                style: GoogleFonts.raleway(
                    fontSize: 22, height: 1.6, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 10,
          toolbarHeight: 65,
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
                      top: 20,
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
                        // IconButton(
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const FavMovies()),
                        //     );
                        //   },
                        //   icon: const Icon(
                        //     Icons.favorite_border_rounded,
                        //     color: Colors.amber,
                        //   ),
                        // ),
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
                  top: 20,
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
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const FavShows()),
                    //     );
                    //   },
                    //   icon: const Icon(
                    //     Icons.favorite_border_rounded,
                    //     color: Colors.amber,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const PopularTvWidget(),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
