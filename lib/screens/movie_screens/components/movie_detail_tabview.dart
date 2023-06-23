import 'package:flutter/material.dart';
import 'package:movies_app/screens/movie_screens/components/recommended_movies_widget.dart';
import 'package:movies_app/screens/movie_screens/components/reviews_widget.dart';
import 'package:movies_app/screens/movie_screens/components/similar_movies_widget.dart';
import 'package:movies_app/screens/movie_screens/components/where_to_watch_widget.dart';

class MoviesDetailTabViewWidget extends StatefulWidget {
  const MoviesDetailTabViewWidget({
    super.key,
    required this.movieDetailTabController,
    required this.selectedIndex,
  });

  final TabController movieDetailTabController;
  final int selectedIndex;

  @override
  State<MoviesDetailTabViewWidget> createState() =>
      _MoviesDetailTabViewWidgetState();
}

class _MoviesDetailTabViewWidgetState extends State<MoviesDetailTabViewWidget> {
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.selectedIndex,
      children: [
        Visibility(
          maintainState: true,
          visible: widget.selectedIndex == 0,
          child: const RecommendedMoviesWidget(),
        ),
        Visibility(
          maintainState: true,
          visible: widget.selectedIndex == 1,
          child: const SimilarMoviesWidget(),
        ),
        Visibility(
          maintainState: true,
          visible: widget.selectedIndex == 2,
          child: const ReviewsWidget(),
        ),
        Visibility(
          maintainState: true,
          visible: widget.selectedIndex == 3,
          child: const WhereToWatchWidget(),
        ),
      ],
    );
  }
}
