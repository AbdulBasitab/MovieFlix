import 'package:flutter/material.dart';
import 'package:movies_app/widgets/image_widget.dart';
import '../bloc/fav_cubit/favourite_cubit.dart';
import '../models/movie/movie.dart';
import '../models/tv_show/tv_show.dart';

class MovieTvCardWidget extends StatelessWidget {
  const MovieTvCardWidget({
    super.key,
    this.popTv,
    this.trendingMovie,
    required this.favCubit,
    required this.onTap,
    required this.posterImage,
    required this.onFavouriteTap,
    this.fromTrendingMovie = false,
  });

  final TvShow? popTv;
  final Movie? trendingMovie;
  final bool fromTrendingMovie;
  final FavouriteMoviesShowsCubit favCubit;
  final void Function() onTap;
  final String posterImage;
  final void Function() onFavouriteTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Stack(
              // alignment: Alignment.topRight,
              children: [
                SizedBox(
                  height: 170,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ImageWidget(imageUrl: posterImage)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 45,
            child: Text(
              (fromTrendingMovie)
                  ? trendingMovie?.title ?? ''
                  : popTv?.title ?? '',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
