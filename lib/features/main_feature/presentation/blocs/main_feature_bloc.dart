import 'package:admin_seller/features/main_feature/presentation/pages/home/admin_seller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_feature_event.dart';
part 'main_feature_state.dart';

class MainFeatureBloc extends Bloc<MainFeatureEvent, MainFeatureState> {
  MainFeatureBloc() : super(const MainFeatureState()) {
    on<OnPageChangedEvent>(_onPageChangedEvent);
    on<OnSellerChangeEvent>(_onSellerChangeEvent);
    on<OnlineChangedEvent>(_onOnlineChangedEvent);
  }
  void _onPageChangedEvent(
      OnPageChangedEvent event, Emitter<MainFeatureState> emit) {
    emit(state.copyWith(selectedIndex: event.selectedIndex));
  }

  void _onSellerChangeEvent(
      OnSellerChangeEvent event, Emitter<MainFeatureState> emit) {
    emit(state.copyWith(seller: event.seller));
  }

  void _onOnlineChangedEvent(
      OnlineChangedEvent event, Emitter<MainFeatureState> emit) {
    emit(state.copyWith(switchValue: event.switchValue));
  }
}
