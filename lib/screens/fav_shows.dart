import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../states/favourite_provider.dart';

class FavShows extends StatefulWidget {
  const FavShows({Key? key}) : super(key: key);

  @override
  State<FavShows> createState() => _FavShowsState();
}

class _FavShowsState extends State<FavShows> {
  @override
  Widget build(BuildContext context) {
    final favtv = context.watch<Favourite>().favMovies;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Shows'),
        backgroundColor: Colors.blue.shade900,
        elevation: 2,
        toolbarHeight: 65,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 20,
          right: 15,
          bottom: 10,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 130,
            mainAxisExtent: 240,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: favtv.length,
          itemBuilder: (BuildContext context, int index) {
            final currentfavtvshow = favtv[index];
            return Column(
              children: [
                Stack(
                  //alignment: Alignment.topRight,
                  children: [
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
                                currentfavtvshow.image.toString(),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 7,
                      left: 77,
                      right: 10,
                      bottom: 140,
                      child: IconButton(
                        onPressed: () {
                          if (favtv.contains(currentfavtvshow)) {
                            Provider.of<Favourite>(context, listen: false);
                            context
                                .read<Favourite>()
                                .removefromfav(currentfavtvshow);
                          } else {
                            Provider.of<Favourite>(context, listen: false);
                            context
                                .read<Favourite>()
                                .addtofav(currentfavtvshow);
                          }
                        },
                        icon: Icon(
                          Icons.favorite_rounded,
                          color: favtv.contains(currentfavtvshow)
                              ? Colors.red
                              : Colors.white,
                          shadows: const [
                            Shadow(
                              color: Colors.black45,
                              blurRadius: 20,
                              offset: Offset(0, 2.0),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 45,
                  child: Text(
                    currentfavtvshow.title ?? '',
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
      ),
    );
  }
}
