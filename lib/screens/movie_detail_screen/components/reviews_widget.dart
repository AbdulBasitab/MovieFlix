import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movie_reviews_bloc/movie_reviews_bloc.dart';
import 'package:movies_app/common_widgets/image_widget.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieReviewsBloc, MovieReviewsState>(
      builder: (context, state) {
        if (state.movieReviews.isNotEmpty &&
            state.dataStatus == DataStatus.success) {
          return SizedBox(
            height: 400,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.movieReviews.length,
              itemBuilder: (context, index) {
                if (state.movieReviews.isEmpty) {
                  return const Center(child: Text("No movie reviews to show"));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: SizedBox(
                            width: 50,
                            height: 75,
                            child: Column(
                              children: [
                                ImageWidget(
                                  height: 40,
                                  width: 40,
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500${state.movieReviews[index].author.authorAvatar}',
                                  errorIcon: Icons.person,
                                  errorIconColor: Colors.black,
                                  iconSize: 18,
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      size: 10,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      '${state.movieReviews[index].author.rating ?? '0.0'}',
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          title: Text(state.movieReviews[index].author.name ??
                              state.movieReviews[index].authorUserName ??
                              'User'),
                          contentPadding: const EdgeInsets.all(10),
                          subtitle: Text(
                            state.movieReviews[index].reviewContent ?? '',
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 13.5),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                          isThreeLine: true,
                        ),
                        const SizedBox(height: 5),
                        const Divider(
                          color: Colors.grey,
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          );
        } else if (state.dataStatus == DataStatus.loading) {
          return const SizedBox(
            height: 90,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.dataStatus == DataStatus.error &&
            state.movieReviews.isEmpty) {
          return SizedBox(
            height: 90,
            child: Center(
              child: Text(state.errorMessage ?? ''),
            ),
          );
        } else {
          return const SizedBox(
              height: 90,
              child: Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }
}
