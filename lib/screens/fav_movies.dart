import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FavMovies extends StatefulWidget {
  const FavMovies({Key? key}) : super(key: key);

  @override
  State<FavMovies> createState() => _FavMoviesState();
}

class _FavMoviesState extends State<FavMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Movies'),
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
      ),
    );
  }
}
