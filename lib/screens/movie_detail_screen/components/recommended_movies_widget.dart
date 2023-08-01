import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/recommended_movies_bloc/recommended_movies_bloc.dart';
import 'package:movies_app/common_widgets/image_widget.dart';
import 'package:movies_app/constants/theme_constants.dart';

class RecommendedMoviesWidget extends StatelessWidget {
  const RecommendedMoviesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedMoviesBloc, RecommendedMoviesState>(
      builder: (context, state) {
        if (state.recommendedMovies.isNotEmpty) {
          return SizedBox(
            height: 210,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(5),
                itemCount: state.recommendedMovies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 120,
                            width: 90,
                            child: ImageWidget(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${state.recommendedMovies[index].poster}'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 90,
                          child: Center(
                            child: Text(
                              state.recommendedMovies[index].title!,
                              style:
                                  AppTextStyles.customTextStyle(fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rate_rounded,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 1),
                            Text(
                              state.recommendedMovies[index].rating!
                                  .toStringAsFixed(1),
                              style:
                                  AppTextStyles.numberTextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
        } else if (state.dataStatus == DataStatus.loading) {
          return const SizedBox(
            height: 90,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.dataStatus == DataStatus.error &&
            state.recommendedMovies.isEmpty &&
            state.dataStatus != DataStatus.loading) {
          return SizedBox(
            height: 90,
            child: Center(
              child: Text(state.errorMessage ?? 'Some Error occured'),
            ),
          );
        } else {
          return const SizedBox(
            height: 90,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
