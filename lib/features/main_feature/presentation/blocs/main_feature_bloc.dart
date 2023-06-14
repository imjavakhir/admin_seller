import 'package:admin_seller/features/seller_admin/presentation/pages/admin_seller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_feature_event.dart';
part 'main_feature_state.dart';

class MainFeatureBloc extends Bloc<MainFeatureEvent, MainFeatureState> {
  MainFeatureBloc() : super(const MainFeatureState()) {
    on<OnPageChangedEvent>(_onPageChangedEvent);
    on<OnSellerChangeEvent>(_onSellerChangeEvent);
  }
  void _onPageChangedEvent(
      OnPageChangedEvent event, Emitter<MainFeatureState> emit) {
    emit(state.copyWith(selectedIndex: event.selectedIndex));
  }

  void _onSellerChangeEvent(
      OnSellerChangeEvent event, Emitter<MainFeatureState> emit) {
    emit(state.copyWith(seller: event.seller));
  }
}
