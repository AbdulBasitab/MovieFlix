import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:movies_app/constants/data_constants.dart';
import 'package:movies_app/constants/theme_constants.dart';
import 'components/watchlist_movies_widget.dart';
import 'components/watchlist_shows_widget.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // int selectedSegment = buttonSegments.first.value;

  int currentSelection = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _controller.view, curve: Curves.easeIn);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          // int sensitivity = 8;
          if (details.primaryVelocity! > 0) {
            // Right Swipe
            setState(() {
              currentSelection = 0;
            });
          } else if (details.primaryVelocity! < 0) {
            // left swipe
            setState(() {
              currentSelection = 1;
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Watchlist',
              style: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.blue.shade900,
            elevation: 2,
            toolbarHeight: 65,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 20,
              right: 15,
              bottom: 10,
            ),
            child: Column(
              children: [
                MaterialSegmentedControl(
                  children: segmentedButtonChildren,
                  selectionIndex: currentSelection,
                  borderColor: AppColors.secondaryColor,
                  selectedColor: AppColors.secondaryColor,
                  unselectedColor: Colors.black,
                  selectedTextStyle: GoogleFonts.raleway(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  unselectedTextStyle: GoogleFonts.raleway(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  borderWidth: 1.4,
                  borderRadius: 32.0,
                  verticalOffset: 10,
                  onSegmentTapped: (int index) {
                    setState(() {
                      currentSelection = index;
                    });
                  },
                ),
                const SizedBox(height: 35),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    switchInCurve: accelerateEasing,
                    switchOutCurve: decelerateEasing,
                    child: (currentSelection == 0)
                        ? WatchlistMoviesWidget(animation: _animation)
                        : WatchlistShowsWidget(animation: _animation),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
