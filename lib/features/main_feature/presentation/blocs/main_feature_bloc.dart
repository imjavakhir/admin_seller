import 'package:admin_seller/app_const/app_exports.dart';

part 'main_feature_event.dart';
part 'main_feature_state.dart';

class MainFeatureBloc extends Bloc<MainFeatureEvent, MainFeatureState> {
  MainFeatureBloc() : super(const MainFeatureState()) {
    on<OnPageChangedEvent>(_onPageChangedEvent);
  }
  void _onPageChangedEvent(
      OnPageChangedEvent event, Emitter<MainFeatureState> emit) {
    emit(state.copyWith(selectedIndex: event.selectedIndex));
  }
}
