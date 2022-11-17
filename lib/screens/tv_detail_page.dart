import 'package:flutter/material.dart';
import 'package:movies_app/models/populartv_detail.dart';
import '../services/api_handler.dart';

class TvDetailPage extends StatefulWidget {
  final double tvpopularid;
  TvDetailPage({
    Key? key,
    required this.tvpopularid,
  }) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<PopularTvDetailModel>(
          future: ApiHandler().fetchPopularTvDetail(widget.tvpopularid),
          builder: (context, snapshot) {
            //print(snapshot.data);
            print(snapshot.error);
            // print(snapshot.data?.genres.elementAt(1).name.toString());
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      if (snapshot.data!.tvBackdrop != null)
                        Image(
                          height: 235,
                          width: MediaQuery.of(context).size.width,
                          image: NetworkImage(
                            // ignore: prefer_interpolation_to_compose_strings
                            'https://image.tmdb.org/t/p/w500' +
                                snapshot.data!.tvBackdrop.toString(),
                          ),
                        ),
                      if (snapshot.data!.tvBackdrop == null)
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
                      snapshot.data!.tvTitle.toString(),
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
                        snapshot.data!.firstairDate.toString(),
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
                        snapshot.data!.seasons.toString(),
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
                        snapshot.data!.episodes.toString(),
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
                        snapshot.data!.rating!.toStringAsFixed(1).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
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
                      if (snapshot.data!.genres != null &&
                          snapshot.data!.genres!.length == 1)
                        Text(
                          snapshot.data!.genres!.elementAt(0).name.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (snapshot.data!.genres!.length == 2 ||
                          snapshot.data!.genres!.length > 2)
                        (Row(
                          children: [
                            Text(
                              snapshot.data!.genres!
                                  .elementAt(0)
                                  .name
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('  ,  '),
                            Text(
                              snapshot.data!.genres!
                                  .elementAt(1)
                                  .name
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )),
                      if (snapshot.data!.genres!.isEmpty == true) (Text('')),
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
                        snapshot.data!.status.toString(),
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
                      snapshot.data!.tvDescription.toString(),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return const Text('Loading');
            }
          }),
    );
  }
}
