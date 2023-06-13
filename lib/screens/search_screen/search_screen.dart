import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants/data_constants.dart';
import 'package:movies_app/cubit/api_cubit/api_service_cubit_state.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/image_widget.dart';
import 'package:movies_app/widgets/searchbar_widget.dart';
import '../../cubit/api_cubit/api_service_cubit.dart';
import '../movie_screens/movie_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchBarController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    searchFocusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    searchBarController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.watch<SearchMoviesShowCubit>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.only(
            right: 14,
            top: 15,
            bottom: 10,
            left: 5,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      (Platform.isAndroid)
                          ? Icons.arrow_back_rounded
                          : Icons.arrow_back_ios_new_rounded,
                    ),
                  ),
                  Hero(
                    tag: "Searchbar",
                    child: CustomMaterial3SearchBar(
                      controller: searchBarController,
                      onChanged: (query) {
                        searchCubit.searchMovieAndShowCubit(query);
                      },
                      onClear: () {
                        searchBarController.clear();
                      },
                      focusNode: searchFocusNode,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                  child: BlocBuilder<SearchMoviesShowCubit, ApiServiceCubit>(
                builder: (context, state) {
                  if (state is SearchMoviesState) {
                    List<Movie> searchedMovies = state.searchedMovies;
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 17,
                      ),
                      child: ListView.builder(
                          // physics: const ClampingScrollPhysics(),
                          itemCount: state.searchedMovies.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<MovieDetailCubit>()
                                      .fetchTrendingMovieDetail(
                                        searchedMovies[index].id!.toDouble(),
                                      );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailPage(
                                        movie: searchedMovies[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ImageWidget(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${searchedMovies[index].poster}',
                                          iconSize: 22,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              160,
                                          child: Text(
                                            searchedMovies[index].title ?? '',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        SearchedRowWidget(
                                          icon: Icons.star_border_outlined,
                                          dataDisplay: Text(
                                            "  ${searchedMovies[index].rating!.toStringAsFixed(1)}",
                                          ),
                                          iconSize: 16,
                                          iconColor: Colors.amber,
                                        ),
                                        const SizedBox(height: 10),
                                        SearchedRowWidget(
                                          icon: Icons.calendar_month_outlined,
                                          iconSize: 16,
                                          dataDisplay: Text(
                                            "  ${searchedMovies[index].releaseDate?.formatDate() ?? '-'}",
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  } else if (state is LoadingMovieState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ErrorMovieState) {
                    return Center(child: Text(state.errorMessage));
                  } else {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.confirmation_number_sharp,
                            size: 32,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Search your favourite Movies",
                          ),
                        ],
                      ),
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchedRowWidget extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final Widget dataDisplay;
  final double widthSizedBox;
  final MainAxisAlignment mainAxisAlignment;

  const SearchedRowWidget({
    super.key,
    required this.icon,
    this.iconSize,
    this.iconColor,
    required this.dataDisplay,
    this.widthSizedBox = 0.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(
          icon,
          size: iconSize ?? 20,
          color: iconColor ?? Colors.white,
        ),
        SizedBox(width: widthSizedBox),
        dataDisplay,
      ],
    );
  }
}
