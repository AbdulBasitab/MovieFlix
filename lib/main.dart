import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movies_app/bloc/movie_reviews_bloc/movie_reviews_bloc.dart';
import 'package:movies_app/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:movies_app/bloc/popular_shows_bloc/popular_shows_bloc.dart';
import 'package:movies_app/bloc/recommended_movies_bloc/recommended_movies_bloc.dart';
import 'package:movies_app/bloc/search_bloc/search_bloc.dart';
import 'package:movies_app/bloc/similar_movies_bloc/similar_movies_bloc.dart';
import 'package:movies_app/bloc/trending_movies_bloc/trending_movies_bloc.dart';
import 'package:movies_app/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:movies_app/bloc/watch_provider_bloc/watch_provider_bloc.dart';
import 'package:movies_app/bloc/watchlist_bloc/watchlist_bloc.dart';
import 'package:movies_app/constants/theme_constants.dart';
import 'package:movies_app/repositories/movie_repository.dart';
import 'package:movies_app/repositories/tv_show_repository.dart';
import 'package:movies_app/screens/splash_screen/splash_screen.dart';
import 'package:movies_app/services/isar_service.dart';
import 'package:movies_app/utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  await serviceLocator<IsarService>().isarDBInit();
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieRepository = serviceLocator<MovieRepository>();
    final tvShowRepository = serviceLocator<TvShowRepository>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MovieReviewsBloc(movieRepository: movieRepository),
        ),
        BlocProvider(
          create: (_) => WatchlistBloc(
              movieRepository: movieRepository,
              tvShowRepository: tvShowRepository),
        ),
        BlocProvider(
          create: (_) => MovieDetailBloc(
              movieRepository: serviceLocator<MovieRepository>()),
        ),
        BlocProvider(
          create: (_) => TvDetailBloc(tvShowRepository: tvShowRepository),
        ),
        BlocProvider(
          create: (_) => TrendingMoviesBloc(movieRepository: movieRepository),
        ),
        BlocProvider(
          create: (_) => PopularShowsBloc(tvShowRepository: tvShowRepository),
        ),
        BlocProvider(
          create: (_) => SearchBloc(
            movieRepository: movieRepository,
            tvShowRepository: tvShowRepository,
          ),
        ),
        BlocProvider(
          create: (_) =>
              RecommendedMoviesBloc(movieRepository: movieRepository),
        ),
        BlocProvider(
          create: (_) => SimilarMoviesBloc(movieRepository: movieRepository),
        ),
        BlocProvider(
          create: (_) => WatchProviderBloc(movieRepository: movieRepository),
        ),
        BlocProvider(create: (_) => NavigationBloc()),
      ],
      child: MaterialApp(
        title: "MovieFlix",
        restorationScopeId: 'root',
        color: Colors.white,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme(),
      ),
    );
  }
}
