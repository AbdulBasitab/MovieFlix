import 'package:flutter/material.dart';

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

List<Widget> movieDetailPageTabs = const [
  Text("Recommended"),
  Text("Similar"),
  Text("Reviews"),
  Text("Where to watch")
];
