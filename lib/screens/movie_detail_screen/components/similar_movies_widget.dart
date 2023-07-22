import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/common_widgets/image_widget.dart';

import '../../../bloc/api_bloc/api_service_bloc.dart';

class SimilarMoviesWidget extends StatelessWidget {
  const SimilarMoviesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiServiceBloc, ApiServiceState>(
      builder: (context, state) {
        if (state.similarMovies.isNotEmpty &&
            state.dataStatus == DataStatus.success) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: state.similarMovies.length,
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
                                    'https://image.tmdb.org/t/p/w500${state.similarMovies[index].poster}'),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 90,
                          child: Text(
                            state.similarMovies[index].title!,
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
                              state.similarMovies[index].rating!
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
            state.similarMovies.isEmpty) {
          return SizedBox(
            height: 90,
            child: Center(
              child:
                  Text(state.errorMessage ?? 'Some Error Occured try again ⚠️'),
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
