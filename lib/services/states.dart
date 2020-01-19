import 'package:equatable/equatable.dart';

abstract class ServiceState extends Equatable { }

class DidLoadingState extends ServiceState {

  @override
  String toString() => '[DidLoadingState]';

  @override
  List<Object> get props => null;
}

class DidSuccessState<T> extends ServiceState {
  final T result;

  DidSuccessState(this.result);

  @override
  String toString() => 'Success: { result: $result }';

  @override
  List<Object> get props => [result];
}

class DidFailureState extends ServiceState {
  final String error;
  DidFailureState(this.error);

  @override
  String toString() => 'Failure: { error: $error }';

  @override
  List<Object> get props => [error];
}

class DidInitState extends ServiceState {

  @override
  String toString() => 'Initial State';

  @override
  List<Object> get props => null;
}

class APIResult {
  int code;
  String message;
}

class APIDetailResult extends APIResult {
  dynamic data;
}

class APIListResult extends APIResult {
  List<dynamic> data;
}
