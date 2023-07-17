import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties = const <dynamic>[];

  const Failure([properties]);

  @override
  List<dynamic> get props => properties;
}

class ServerFailure extends Failure {}

class ConnectionFailure extends Failure {}

class DatabaseFailure extends Failure {}

class SharedPreferencesFailure extends Failure {}

class CacheFailure extends Failure {}

