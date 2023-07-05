// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'navigation_bloc.dart';

class NavigationState {
  final int selectedIndex;
  NavigationState({
    required this.selectedIndex,
  });

  NavigationState copyWith({
    int? selectedIndex,
  }) {
    return NavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
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
