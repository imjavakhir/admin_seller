part of 'main_feature_bloc.dart';

abstract class MainFeatureEvent extends Equatable {
  const MainFeatureEvent();

  @override
  List<Object> get props => [];
}


class OnPageChangedEvent extends MainFeatureEvent {
  final int selectedIndex;

  const OnPageChangedEvent({required this.selectedIndex});
  
}

class OnSellerChangeEvent extends MainFeatureEvent {
 final Seller seller;

  const OnSellerChangeEvent(this.seller);

 
  
}


