import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/api_bloc/api_service_bloc.dart';
import 'package:movies_app/bloc/watchlist_bloc/watchlist_bloc.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/screens/tv_detail_screen/tv_detail_screen.dart';
import 'package:movies_app/widgets/card_widget.dart';

class WatchlistShowsWidget extends StatelessWidget {
  const WatchlistShowsWidget({
    super.key,
    required Animation<double> animation,
  }) : _animation = animation;

  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state.watchlistedShows.isNotEmpty) {
          final List<TvShow> watchlistedShows = state.watchlistedShows;
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: watchlistedShows.length,
            itemBuilder: (BuildContext context, int index) {
              final show = watchlistedShows[index];
              return MovieTvCardWidget(
                onTap: () {
                  context
                      .read<ApiServiceBloc>()
                      .add(FetchTvShowDetail(tvShowId: show.id!));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TvDetailScreen(
                        tvShow: show,
                      ),
                    ),
                  );
                },
                posterImage: 'https://image.tmdb.org/t/p/w500${show.poster}',
                fromTrendingMovie: false,
                popTv: show,
              );
            },
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 130,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              mainAxisExtent: 240,
            ),
          );
        } else {
          return Center(
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/empty_watchlist.png'),
                  const SizedBox(height: 30),
                  Text(
                    "Uh-oh! Your watchlist is empty. Time to fill it up! 🍿",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
