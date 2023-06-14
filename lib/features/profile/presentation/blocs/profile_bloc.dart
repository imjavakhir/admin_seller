import 'package:admin_seller/features/main_feature/data/data_src/hive_local_data_src.dart';
import 'package:admin_seller/features/profile/data/models/user_online_model.dart';
import 'package:admin_seller/services/api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<OnlineChangedEvent>(_onOnlineChangedEvent);
    on<GetUserOnlineModelEvent>(_getUserOnlineModelEvent);
    on<CheckUserEvent>(_checkUserEvent);
  }

  void _onOnlineChangedEvent(
      OnlineChangedEvent event, Emitter<ProfileState> emit) async {
    await ApiService().changeUserOnlineInfo(isOnline: !state.switchValue);
    emit(state.copyWith(switchValue: event.switchValue));
  }

  Future<void> _getUserOnlineModelEvent(
      GetUserOnlineModelEvent event, Emitter<ProfileState> emit) async {
    final userOnlineModel = await ApiService().getUserOnlineInfo();
    emit(ProfileState(userOnlineModel: userOnlineModel));
  }

  Future<void> _checkUserEvent(
      CheckUserEvent event, Emitter<ProfileState> emit) async {
    final user = HiveDataSource().box.values.toList().first;
    print(user.type);

    if (user.type == 'seller_admin') {
      emit(const ProfileState(isAdmin: true));
    } else {
      emit(const ProfileState(isAdmin: false));
    }
  }
}
