import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/constants/theme_constants.dart';
import 'package:movies_app/screens/home_screen/main_navigation_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSplashScreen(
        splash: 'assets/logo/movieflix.png',
        nextScreen: const MainNavigationScreen(),
        backgroundColor: AppColors.blackColor,
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
