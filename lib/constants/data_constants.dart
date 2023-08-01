import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DataConstants {
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const apiKey = '2f524b9d4ecc59568226e745cef4ffe0';
  static const String readToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjUyNGI5ZDRlY2M1OTU2ODIyNmU3NDVjZWY0ZmZlMCIsInN1YiI6IjYzNmU0MWM2ZDdmYmRhMDBlN2I3Nzc4OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pIhLyoiTyNqDfoc0RQqNHVRyb8ZxcsZzDTcD1u29WsI';
}

extension DoubleExtensions on double {
  double reduceToOneDecimal() {
    final truncatedValue = (this * 10).truncateToDouble();
    return truncatedValue / 10;
  }
}

extension StringExtensions on String {
  String formatDate() {
    final parts = split('-');
    if (parts.length == 3) {
      final year = parts[0];
      final month = parts[1];
      final day = parts[2];
      return '$day-$month-$year';
    }
    return this;
  }
}

const List<Widget> movieDetailPageTabs = [
  Text(
    "Recommended",
  ),
  Text(
    "Similar",
  ),
  Text(
    "Reviews",
  ),
  Text(
    "Where to watch",
  ),
];

const List<ButtonSegment<int>> buttonSegments = [
  ButtonSegment(
    value: 0,
    label: Text("Movies"),
    icon: Icon(Icons.movie_outlined),
    enabled: true,
  ),
  ButtonSegment(
    value: 1,
    label: Text("Tv Shows"),
    icon: Icon(Icons.tv_rounded),
    enabled: true,
  ),
];

final Map<int, Widget> segmentedButtonChildren = {
  0: const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: 8),
      Icon(Icons.movie_rounded),
      Text("Movies"),
      SizedBox(width: 8),
    ],
  ),
  1: const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: 10),
      Icon(Icons.tv_rounded),
      SizedBox(width: 10),
      Text("Tv Shows"),
      SizedBox(width: 10),
    ],
  ),
};

void showErrorMessage({required String msg, Color? color}) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    backgroundColor: color ?? Colors.red,
  );
}

void showSuccessMessage(String msg, Color color) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    backgroundColor: color,
  );
}
