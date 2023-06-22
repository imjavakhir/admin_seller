import 'package:admin_seller/features/accept_online/data/models/user_unverified_model.dart';
import 'package:admin_seller/features/accept_online/repository/accept_online_repo.dart';
import 'package:admin_seller/services/api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'accept_online_event.dart';
part 'accept_online_state.dart';

class AcceptOnlineBloc extends Bloc<AcceptOnlineEvent, AcceptOnlineState> {
  AcceptOnlineBloc() : super(const AcceptOnlineState(userOnlineModelList: [])) {
    on<GetUsersUnverifiedEvent>(_getUsersUnverifiedEvent);
    on<AcceptUserEvent>(_acceptUserEvent);
  }

  AcceptOnlineRepository _acceptOnlineRepository = AcceptOnlineRepository();

  void _getUsersUnverifiedEvent(
      GetUsersUnverifiedEvent event, Emitter<AcceptOnlineState> emit) async {
    final userOnlineModelList = await _acceptOnlineRepository.getAllUnverified();
    emit(AcceptOnlineState(userOnlineModelList: userOnlineModelList));
  }

  Future<void> _acceptUserEvent(
      AcceptUserEvent event, Emitter<AcceptOnlineState> emit) async {
    if (state.userOnlineModelList.isNotEmpty) {
      await _acceptOnlineRepository
          .verifyUser(seller: state.userOnlineModelList[event.index]!.id!);
    }

   
  }
}
