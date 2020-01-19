import 'package:bloc/bloc.dart';

enum RandomBlocEnum { reset, setNull }

class RandomBloc extends Bloc<int, String> {
  @override
  String get initialState => "Random Number";

  @override
  Stream<String> mapEventToState(int event) async* {
    yield "Random Number $event";
  }
}

class ResetBloc extends Bloc<RandomBlocEnum, String> {
  @override
  String get initialState => "-";

  @override
  Stream<String> mapEventToState(RandomBlocEnum event) async* {
    if (event == RandomBlocEnum.reset) {
      if (state == '-') {
        yield "Reset Text";
      } else {
        yield "-";
      }
    } else {
      yield "";
    }
  }
}
