import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants/data_constants.dart';
import 'package:movies_app/models/tv_show.dart';
import '../../cubit/api_cubit/api_service_cubit.dart';
import '../../cubit/api_cubit/api_service_cubit_state.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Details",
          style: TextStyle(
            fontSize: 21,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<PopularTvDetailCubit, ApiServiceCubit>(
          builder: (context, snapshot) {
        if (snapshot is PopularMovieDetailState) {
          final tvShow = snapshot.popularTvDetail;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    if (widget.tvShow.backdrop != null)
                      Image(
                        height: 235,
                        width: MediaQuery.of(context).size.width,
                        image: NetworkImage(
                          // ignore: prefer_interpolation_to_compose_strings
                          'https://image.tmdb.org/t/p/w500' +
                              widget.tvShow.backdrop.toString(),
                        ),
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
                      tvShow.seasons.toString(),
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
                      tvShow.episodes.toString(),
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
                    if (tvShow.genres != null && tvShow.genres!.length == 1)
                      Text(
                        tvShow.genres!.elementAt(0).name.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (tvShow.genres!.length == 2 || tvShow.genres!.length > 2)
                      (Row(
                        children: [
                          Text(
                            tvShow.genres!.elementAt(0).name.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('  ,  '),
                          Text(
                            tvShow.genres!.elementAt(1).name.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )),
                    if (tvShow.genres!.isEmpty == true) (const Text('')),
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
                      tvShow.status.toString(),
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
        } else if (snapshot is ErrorMovieState) {
          return const Center(child: Text('Error'));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
