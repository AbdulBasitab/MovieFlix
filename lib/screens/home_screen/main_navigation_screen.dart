import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:movies_app/constants/theme_constants.dart';
import 'package:movies_app/screens/home_screen/home_screen.dart';
import 'package:movies_app/screens/watchlist_screen/watchlist_screen.dart';
import 'package:movies_app/screens/search_screen/search_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  // bool _isVisible = true;
  ScrollController hideNavigationBarController = ScrollController();

  @override
  void initState() {
    super.initState();
    hideNavigationBarController.addListener(() {
      if (hideNavigationBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        context.read<NavigationBloc>().add(SetIsNavBarVisible(value: false));
      }
      if (hideNavigationBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        context.read<NavigationBloc>().add(SetIsNavBarVisible(value: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(scrollController: hideNavigationBarController),
      const SearchScreen(),
      const WatchlistScreen(),
    ];
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) => SafeArea(
        top: false,
        child: Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              if (state.selectedIndex == 0) {
                return true;
              } else {
                context
                    .read<NavigationBloc>()
                    .add(ChangeSelectedIndex(index: 0));
                return false;
              }
            },
            child: screens[state.selectedIndex],
          ),
          bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            height: state.isNavBarVisible ? 60 : 0,
            child: state.isNavBarVisible
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 50),
                    height: state.isNavBarVisible ? 60 : 0,
                    child: state.isNavBarVisible
                        ? BottomAppBar(
                            height: 60,
                            child: BottomNavigationBar(
                              items: const [
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.home_filled),
                                  label: "Home",
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.search_rounded),
                                  label: "Search",
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.bookmark_border_rounded),
                                  label: "Watchlist",
                                ),
                              ],
                              currentIndex: state.selectedIndex,
                              onTap: (value) {
                                context
                                    .read<NavigationBloc>()
                                    .add(ChangeSelectedIndex(index: value));
                              },
                              backgroundColor: AppColors.primaryColor,
                              selectedItemColor: AppColors.secondaryColor,
                              unselectedItemColor: AppColors.tertiaryColor,
                              unselectedLabelStyle:
                                  AppTextStyles.unselectedItemTextStyle(),
                              selectedLabelStyle:
                                  AppTextStyles.selectedItemTextStyle(),
                            ),
                          )
                        : Container(
                            color: Colors.transparent,
                            width: MediaQuery.sizeOf(context).width,
                          ),
                  )
                : Container(
                    color: Colors.transparent,
                    width: MediaQuery.sizeOf(context).width,
                  ),
          ),
        ),
      ),
    );
  }
}
