import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(const NavigationState(
            isNavBarVisible: true, selectedIndex: 0, isDataFetched: false)) {
    on<ChangeSelectedIndex>(
        (event, emit) => changeSelectedIndex(emit, event.index));
    on<SetIsNavBarVisible>((event, emit) {
      return setIsNavBarVisible(event.value, emit);
    });
  }
  void changeSelectedIndex(Emitter<NavigationState> emit, int selectedIndex) {
    emit(state.copyWith(selectedIndex: selectedIndex, isDataFetched: true));
  }

  void setIsNavBarVisible(bool value, Emitter<NavigationState> emit) {
    emit(state.copyWith(isNavBarVisible: value));
  }
}
