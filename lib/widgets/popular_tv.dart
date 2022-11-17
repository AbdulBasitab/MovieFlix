import 'package:flutter/material.dart';
import 'package:movies_app/models/popular_tv_model.dart';
import '../screens/tv_detail_page.dart';
import '../services/api_handler.dart';

class PopularTvPage extends StatefulWidget {
  const PopularTvPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PopularTv>>(
      future: ApiHandler().fetchPopularTv(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: GridView.builder(
              itemCount: snapshot.data?.length,
              shrinkWrap: false,
              padding: EdgeInsets.only(top: 15, left: 9, right: 9),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 130,
                crossAxisSpacing: 30,
                mainAxisSpacing: 11,
                mainAxisExtent: 240,
              ),
              itemBuilder: (BuildContext ctx, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TvDetailPage(
                              tvpopularid:
                                  snapshot.data![index].popTvId!.toDouble(),
                            ),
                          ),
                        );
                      },
                      child: Stack(alignment: Alignment.topRight, children: [
                        Container(
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                // ignore: prefer_interpolation_to_compose_strings
                                'https://image.tmdb.org/t/p/w500' +
                                    snapshot.data![index].popTvPoster
                                        .toString(),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_rounded,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                blurRadius: 20,
                                offset: Offset(0, 2.0),
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 45,
                      child: Text(
                        snapshot.data?[index].popTvTitle ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Text("Loading...");
      },
    );
  }
}
