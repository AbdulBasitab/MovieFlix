import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:movies_app/constants/theme_constants.dart';
import 'package:movies_app/screens/splash_screen/splash_screen.dart';
import 'package:movies_app/services/isar_service.dart';
import 'bloc/api_bloc/api_service_bloc.dart';
import 'bloc/watchlist_bloc/watchlist_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.isarDBInit();
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
        BlocProvider(create: (_) => WatchlistBloc()),
        BlocProvider(create: (_) => NavigationBloc()),
      ],
      child: MaterialApp(
        title: "MovieFlix",
        restorationScopeId: 'root',
        color: Colors.white,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme(),
        // ThemeData(
        //     brightness: Brightness.dark, primaryColor: Colors.blue.shade800),
      ),
    );
  }
}
