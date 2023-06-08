import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/api_cubit/api_service_cubit.dart';
import '../../cubit/api_cubit/api_service_cubit_state.dart';

class TvDetailPage extends StatefulWidget {
  final double showId;
  const TvDetailPage({
    Key? key,
    required this.showId,
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
      ),
      body: BlocBuilder<PopularTvDetailCubit, ApiServiceCubit>(
          builder: (context, snapshot) {
        if (snapshot is PopularMovieDetailState) {
          final popTv = snapshot.popularTvDetail;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    if (popTv.tvBackdrop != null)
                      Image(
                        height: 235,
                        width: MediaQuery.of(context).size.width,
                        image: NetworkImage(
                          // ignore: prefer_interpolation_to_compose_strings
                          'https://image.tmdb.org/t/p/w500' +
                              popTv.tvBackdrop.toString(),
                        ),
                      ),
                    if (popTv.tvBackdrop == null)
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
                    popTv.tvTitle.toString(),
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
                      popTv.firstairDate.toString(),
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
                      popTv.seasons.toString(),
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
                      popTv.episodes.toString(),
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
                      popTv.rating!.toStringAsFixed(1).toString(),
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
                    if (popTv.genres != null && popTv.genres!.length == 1)
                      Text(
                        popTv.genres!.elementAt(0).name.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (popTv.genres!.length == 2 || popTv.genres!.length > 2)
                      (Row(
                        children: [
                          Text(
                            popTv.genres!.elementAt(0).name.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('  ,  '),
                          Text(
                            popTv.genres!.elementAt(1).name.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )),
                    if (popTv.genres!.isEmpty == true) (const Text('')),
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
                      popTv.status.toString(),
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
                    popTv.tvDescription.toString(),
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
