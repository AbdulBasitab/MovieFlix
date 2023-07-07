import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(NavigationState(selectedIndex: 0, isDataFetched: false)) {
    on<ChangeSelectedIndex>(
        (event, emit) => changeSelectedIndex(emit, event.index));
  }
  void changeSelectedIndex(Emitter<NavigationState> emit, int selectedIndex) {
    emit(state.copyWith(selectedIndex: selectedIndex, isDataFetched: true));
  }
}
