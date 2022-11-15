import 'package:flutter/material.dart';
import 'package:movies_app/widgets/trending_movies.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          foregroundColor: Colors.white70,
          title: Text('MovieFlix'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 15, bottom: 5, left: 5),
              child: Text(
                'Trending Movies',
                style: GoogleFonts.raleway(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TrendingMoviesPage(),
          ],
        ),
      ),
    );
  }
}
