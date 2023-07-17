import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_bar_state.dart';


class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {

  BottomNavigationBarCubit() : super(const BottomNavigationBarState(ActiveIcon.icon1));

  void setActiveIcon(ActiveIcon activeIcon) async {
    emit(BottomNavigationBarState(activeIcon));
  }

}
