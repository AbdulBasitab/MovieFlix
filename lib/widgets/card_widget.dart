import 'package:flutter/material.dart';
import 'package:movies_app/models/trending_movie_model.dart';
import '../cubit/fav_cubit/favourite_cubit.dart';
import '../models/popular_tv_model.dart';

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

  final PopularTv? popTv;
  final TrendingMovie? trendingMovie;
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
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(
                        posterImage,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 7,
                  left: 67,
                  right: 0,
                  bottom: 140,
                  child: IconButton(
                    onPressed: onFavouriteTap,
                    icon: ((fromTrendingMovie)
                            ? favCubit.isMovieFavorited(trendingMovie!)
                            : favCubit.isShowFavorited(popTv!))
                        ? const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                blurRadius: 20,
                                offset: Offset(0, 2.0),
                              )
                            ],
                          )
                        : const Icon(
                            Icons.favorite_outline_rounded,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                blurRadius: 20,
                                offset: Offset(0, 2.0),
                              )
                            ],
                          ),
                  ),
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
                  ? trendingMovie?.movieTitle ?? ''
                  : popTv?.popTvTitle ?? '',
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
