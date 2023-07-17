

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';

abstract class UseCase<T, P>{
  /// Future<T> call(P param);
  Future<Either<Failure, T>> call(P params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
