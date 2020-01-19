import 'package:bloc/bloc.dart';
import 'package:sm_flutter/models/user.dart';
import 'package:sm_flutter/services/api_service.dart';
import 'package:sm_flutter/services/events.dart';
import 'package:sm_flutter/services/states.dart';

class UserBloc extends Bloc<ServiceEvent, ServiceState> {
  @override
  ServiceState get initialState => DidInitState();

  @override
  Stream<ServiceState> mapEventToState(ServiceEvent event) async* {
    if (event is GetDetailUserEvent) {
      yield DidLoadingState();
      try {
        APIDetailResult result = await APIService.getUserFromAPI(event.id);
        yield DidSuccessState<User>(result.data);
      } catch (error) {
        final didFailure = DidFailureState(error.toString());
        didFailure.toString();
        yield didFailure;
      }
    }
  }

}

class GetDetailUserEvent extends ServiceEvent {
  final int id;
  GetDetailUserEvent(this.id);

  @override
  List<Object> get props => [id];
}
