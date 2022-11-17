import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FavShows extends StatefulWidget {
  const FavShows({Key? key}) : super(key: key);

  @override
  State<FavShows> createState() => _FavShowsState();
}

class _FavShowsState extends State<FavShows> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Shows'),
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
      ),
    );
  }
}
