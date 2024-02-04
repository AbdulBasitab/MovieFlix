// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  final int selectedIndex;
  final bool isNavBarVisible;
  final bool isDataFetched;
  const NavigationState({
    this.isNavBarVisible = true,
    required this.selectedIndex,
    required this.isDataFetched,
  });

  NavigationState copyWith({
    int? selectedIndex,
    bool? isNavBarVisible,
    bool? isDataFetched,
  }) {
    return NavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isNavBarVisible: isNavBarVisible ?? this.isNavBarVisible,
      isDataFetched: isDataFetched ?? this.isDataFetched,
    );
  }

  @override
  List<Object> get props => [selectedIndex, isNavBarVisible, isDataFetched];
}

abstract class NavigationEvent {}

class ChangeSelectedIndex extends NavigationEvent {
  final int index;
  ChangeSelectedIndex({
    required this.index,
  });
}

class SetIsNavBarVisible extends NavigationEvent {
  final bool value;
  SetIsNavBarVisible({
    required this.value,
  });
}
