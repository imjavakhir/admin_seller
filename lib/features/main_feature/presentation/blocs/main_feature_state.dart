part of 'main_feature_bloc.dart';

class MainFeatureState extends Equatable {
  final int selectedIndex;
  final Seller seller;
  final bool switchValue;
  const MainFeatureState(
      {this.selectedIndex = 0,
      this.seller = Seller.auto,
      this.switchValue = false});

  MainFeatureState copyWith(
      {final int? selectedIndex,
      final Seller? seller,
      final bool? switchValue}) {
    // debugPrint('Error ------------- $error');
    return MainFeatureState(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        seller: seller ?? this.seller,
        switchValue: switchValue ?? this.switchValue);
  }

  @override
  List<Object> get props => [selectedIndex, seller, switchValue];
}
