import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/bloc/api_bloc/api_service_bloc.dart';
import 'package:movies_app/constants/data_constants.dart';
import 'package:movies_app/widgets/image_widget.dart';
import '../../bloc/fav_cubit/favourite_cubit.dart';
import '../../models/tv_show/tv_show.dart';

class TvDetailPage extends StatefulWidget {
  final TvShow tvShow;
  const TvDetailPage({
    Key? key,
    required this.tvShow,
  }) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    var favCubit = context.watch<FavouriteMoviesShowsCubit>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          title: Text(
            "Details",
            style: GoogleFonts.raleway(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                favCubit.addFavShow(widget.tvShow);
              },
              icon: Icon(
                (favCubit.isShowFavorited(widget.tvShow))
                    ? Icons.bookmark_added_rounded
                    : Icons.bookmark_outline_rounded,
                size: 26,
                color: (favCubit.isShowFavorited(widget.tvShow))
                    ? Colors.amber.shade500
                    : Colors.white,
              ),
            ),
          ],
        ),
        body: BlocBuilder<ApiServiceBloc, ApiServiceState>(
            builder: (context, state) {
          if (state.popularTvDetail != null &&
              state.dataStatus == DataStatus.success) {
            final tvShow = state.popularTvDetail;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      if (widget.tvShow.backdrop != null)
                        ImageWidget(
                          height: 235,
                          width: double.infinity,
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${widget.tvShow.backdrop}',
                        ),
                      if (widget.tvShow.backdrop == null)
                        const Text('Error Loading Image'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 18,
                      bottom: 12,
                    ),
                    child: Text(
                      widget.tvShow.title.toString(),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Release Date:  ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Text(
                        widget.tvShow.firstairDate!.formatDate().toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 70,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Seasons:  ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Text(
                        tvShow?.seasons.toString() ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 180,
                      ),
                      const Text(
                        'Episodes:  ',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        tvShow?.episodes.toString() ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 0),
                        child: Text(
                          'Rating:  ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Text(
                        widget.tvShow.rating!.toStringAsFixed(1).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          'Genre:  ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      if (tvShow?.genres != null && tvShow?.genres!.length == 1)
                        Text(
                          tvShow?.genres!.elementAt(0).name.toString() ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (tvShow?.genres!.length == 2 ||
                          tvShow!.genres!.length > 2)
                        (Row(
                          children: [
                            Text(
                              tvShow?.genres!.elementAt(0).name.toString() ??
                                  '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('  ,  '),
                            Text(
                              tvShow?.genres!.elementAt(1).name.toString() ??
                                  '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )),
                      if (tvShow?.genres!.isEmpty == true) (const Text('')),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          'Status:  ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Text(
                        tvShow?.status.toString() ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      widget.tvShow.description.toString(),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            );
          } else if (state.dataStatus == DataStatus.error &&
              state.popularTvDetail == null) {
            return Center(child: Text(state.errorMessage ?? ''));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
