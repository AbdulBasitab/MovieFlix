import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movies_app/bloc/search_bloc/search_bloc.dart' as searchbloc;
import 'package:movies_app/constants/data_constants.dart';
import 'package:movies_app/common_widgets/image_widget.dart';
import 'package:movies_app/common_widgets/searchbar_widget.dart';
import '../../models/movie/movie.dart';
import '../movie_detail_screen/movie_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController searchBarController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // searchFocusNode.requestFocus();
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _controller.view, curve: Curves.easeIn);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    searchBarController.dispose();
    searchFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: FadeTransition(
            opacity: _animation,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomMaterial3SearchBar(
                      controller: searchBarController,
                      onChanged: (query) {
                        context
                            .read<searchbloc.SearchBloc>()
                            .add(searchbloc.SearchMovies(searchQuery: query));
                      },
                      onClear: () {
                        searchBarController.clear();
                      },
                      focusNode: searchFocusNode,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: BlocBuilder<searchbloc.SearchBloc,
                      searchbloc.SearchState>(
                    builder: (context, state) {
                      if (state.searchedMovies.isNotEmpty &&
                          searchBarController.text.isNotEmpty) {
                        List<Movie> searchedMovies = state.searchedMovies;
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 17,
                          ),
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: searchedMovies.length,
                              itemBuilder: (context, index) {
                                return Hero(
                                  tag: 'movieCard3$index',
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        onTap: () {
                                          //TODO: Also implement search for tv shows
                                          context.read<MovieDetailBloc>().add(
                                              FetchMovieDetail(
                                                  movieKey:
                                                      searchedMovies[index]
                                                          .id!));
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailPage(
                                                movie: searchedMovies[index],
                                                heroTag: 'movieCard3$index',
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.black),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                                    searchedMovies[index]
                                                            .title ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                SearchedRowWidget(
                                                  icon: Icons.star_rate_rounded,
                                                  dataDisplay: Text(
                                                    "  ${searchedMovies[index].rating!.toStringAsFixed(1)}",
                                                  ),
                                                  iconSize: 18,
                                                  iconColor: Colors.amber,
                                                ),
                                                const SizedBox(height: 10),
                                                SearchedRowWidget(
                                                  icon: Icons
                                                      .calendar_month_outlined,
                                                  iconSize: 18,
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
                                    ),
                                  ),
                                );
                              }),
                        );
                      } else if (state.dataStatus ==
                          searchbloc.DataStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.dataStatus ==
                              searchbloc.DataStatus.error &&
                          searchBarController.text.isNotEmpty) {
                        return Center(
                            child:
                                Text(state.errorMessage ?? 'No movies found'));
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/movie.png',
                                //scale: 1,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "🔍 Find any movies you want to watch.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
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
