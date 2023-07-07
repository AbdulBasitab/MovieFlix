// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'navigation_bloc.dart';

class NavigationState {
  final int selectedIndex;
  final bool isDataFetched;
  NavigationState({
    required this.selectedIndex,
    required this.isDataFetched,
  });

  NavigationState copyWith({
    int? selectedIndex,
    bool? isDataFetched,
  }) {
    return NavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isDataFetched: isDataFetched ?? this.isDataFetched,
    );
  }
}

abstract class NavigationEvent {}

class ChangeSelectedIndex extends NavigationEvent {
  final int index;
  ChangeSelectedIndex({
    required this.index,
  });
}
