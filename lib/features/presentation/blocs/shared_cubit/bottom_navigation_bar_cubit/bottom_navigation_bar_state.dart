part of 'bottom_navigation_bar_cubit.dart';

enum ActiveIcon{
  icon1,
  icon2,
  icon3,
  icon4,
  icon5,
}

class BottomNavigationBarState extends Equatable {
  final ActiveIcon activeIcon;

  const BottomNavigationBarState(this.activeIcon);

  @override
  List<Object?> get props => [activeIcon];
}
