part of 'directionality_cubit.dart';

class DirectionalityState extends Equatable {
  final TextDirection direction;
  final bool isLtr;

  const DirectionalityState(this.direction, this.isLtr);

  @override
  List<Object?> get props => [direction, isLtr];
}

