import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants/theme_constants.dart';
import 'package:movies_app/screens/home_screen/bottom_nav_bar.dart';

import 'cubit/api_cubit/api_service_bloc.dart';
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
        BlocProvider(create: (_) => ApiServiceBloc()),
        BlocProvider(create: (_) => TvShowsCubit()),
        BlocProvider(create: (_) => PopularTvDetailCubit()),
        BlocProvider(create: (_) => MovieDetailCubit()),
        BlocProvider(create: (_) => FavouriteMoviesShowsCubit()),
        BlocProvider(create: (_) => SearchMoviesShowCubit()),
        BlocProvider(create: (_) => SimilarMoviesCubit()),
        BlocProvider(create: (_) => RecommendedMoviesCubit()),
        BlocProvider(create: (_) => MovieReviewsCubit()),
        BlocProvider(create: (_) => MovieWatchProviderCubit()),
      ],
      child: MaterialApp(
        title: "MovieFlix",
        restorationScopeId: 'root',
        color: Colors.white,
        home: const BottomNavBar(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme(),
        // ThemeData(
        //     brightness: Brightness.dark, primaryColor: Colors.blue.shade800),
      ),
    );
  }
}
