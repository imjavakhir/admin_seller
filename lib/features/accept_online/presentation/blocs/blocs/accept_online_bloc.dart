import 'package:admin_seller/app_const/app_exports.dart';

part 'accept_online_event.dart';
part 'accept_online_state.dart';

class AcceptOnlineBloc extends Bloc<AcceptOnlineEvent, AcceptOnlineState> {
  AcceptOnlineBloc() : super(AcceptOnlineState()) {
    on<GetUsersUnverifiedEvent>(_getUsersUnverifiedEvent);
    on<AcceptUserEvent>(_acceptUserEvent);
  }

  final AcceptOnlineRepository _acceptOnlineRepository =
      AcceptOnlineRepository();

  Future<void> _getUsersUnverifiedEvent(
      GetUsersUnverifiedEvent event, Emitter<AcceptOnlineState> emit) async {
    emit(AcceptOnlineStateLoading());
    final userOnlineModelList =
        await _acceptOnlineRepository.getAllUnverified();

    emit(AcceptOnlineStateLoaded(userUnverifiedList: userOnlineModelList));
  }

  Future<void> _acceptUserEvent(
      AcceptUserEvent event, Emitter<AcceptOnlineState> emit) async {
    // emit(state.copyWith(loading: true, selectedItem: event.index));
    await _acceptOnlineRepository.verifyUser(seller: event.id);
    final userOnlineModelList =
        await _acceptOnlineRepository.getAllUnverified();
    // emit(state.copyWith(loading: false));
    emit(AcceptOnlineStateLoaded(userUnverifiedList: userOnlineModelList));
  }
}
