import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/screens/home_screen.dart';

import 'cubit/api_cubit/api_service_cubit.dart';
import 'cubit/fav_cubit/favourite_cubit.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MoviesCubit()),
        BlocProvider(create: (_) => TvShowsCubit()),
        BlocProvider(create: (_) => PopularTvDetailCubit()),
        BlocProvider(create: (_) => MovieDetailCubit()),
        BlocProvider(create: (_) => FavouriteMoviesShowsCubit()),
      ],
      child: MaterialApp(
        title: "MovieFlix",
        color: Colors.white,
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark, primaryColor: Colors.blue.shade800),
      ),
    );
  }
}
