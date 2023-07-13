import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/api_bloc/api_service_bloc.dart';
import 'package:movies_app/widgets/image_widget.dart';

class RecommendedMoviesWidget extends StatelessWidget {
  const RecommendedMoviesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiServiceBloc, ApiServiceState>(
      builder: (context, state) {
        if (state.recommendedMovies.isNotEmpty) {
          return SizedBox(
            height: 200,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 110,
                            width: 80,
                            child: ImageWidget(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${state.recommendedMovies[index].poster}'),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 90,
                          child: Text(
                            state.recommendedMovies[index].title!,
                            style: const TextStyle(fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rate_rounded,
                              color: Colors.amber,
                              size: 14,
                            ),
                            Text(
                              state.recommendedMovies[index].rating!
                                  .toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 13,
                              ),
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
            state.recommendedMovies.isEmpty) {
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
