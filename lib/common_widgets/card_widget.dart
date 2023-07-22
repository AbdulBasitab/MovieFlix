import 'package:flutter/material.dart';
import 'package:movies_app/common_widgets/image_widget.dart';
import 'package:movies_app/constants/theme_constants.dart';
import '../models/movie/movie.dart';
import '../models/tv_show/tv_show.dart';

class MovieTvCardWidget extends StatelessWidget {
  const MovieTvCardWidget({
    super.key,
    this.popTv,
    this.trendingMovie,
    required this.onTap,
    required this.posterImage,
    this.fromTrendingMovie = false,
  });

  final TvShow? popTv;
  final Movie? trendingMovie;
  final bool fromTrendingMovie;
  final void Function() onTap;
  final String posterImage;

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
              style: AppTextStyles.customTextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
