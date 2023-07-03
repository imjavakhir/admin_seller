import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/models/seller_model/sellers_model.dart';
import 'package:admin_seller/features/seller/data/client_info_model.dart';
import 'package:admin_seller/features/seller/repository/seller_repo.dart';
import 'package:admin_seller/features/seller_admin/repository/seller_admin_repo.dart';
import 'package:admin_seller/services/socket_io_client_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'seller_event.dart';
part 'seller_state.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {
  SellerBloc(this._socketService)
      : super(SellerState(
          sellerList: [],
          clientInfoList: const [],
        )) {
    on<ClientInfoListEvent>(_clientInfoListEvent);
    on<GetClientsFromApi>(_getClientsFromApi);
    on<WhereFromEvent>(_whereFromEvent);
    on<ClearVisits>(_clearVisits);
    on<SavePauseInfo>(_savePauseInfo);
    on<ShareClient>(_shareClient);
    on<GetSellersEvent>(_getSellersEvent);
    on<ShareSelectedSeller>(_shareSelectedSeller);
  }

  final GlobalKey<AnimatedListState> key = GlobalKey();

  final SellerRepository _sellerRepository = SellerRepository();
  final SocketService _socketService;
  bool _isSocketConnected = false;
  List<ClientInfo?> visits = [];
  Future<void> _clientInfoListEvent(
      ClientInfoListEvent event, Emitter<SellerState> emit) async {
    final logToken = await AuthLocalDataSource().getLogToken();
    // final apiVisits = await ApiService().getAllUserVisits();
    // final newList = List<ClientInfo>.from(state.clientInfoList);

    if (!_isSocketConnected) {
      _socketService.connect(logToken!);

      _isSocketConnected = true;
    }

    if (_isSocketConnected) {
      _socketService.offEvent('new-order');
      _socketService.onEvent('new-order', (data) {
        // key.currentState!
        //     .insertItem(0, duration: const Duration(milliseconds: 600));
        visits.insert(0, clientInfoFromJson(data));

        debugPrint('yangi klient ------------${clientInfoFromJson(data)}');

        add(
          ClientInfoListEvent(visits),
        );
      });
    }

    emit(SellerState(clientInfoList: event.clientInfosList, sellerList: []));
  }

  Future<void> _getClientsFromApi(
      GetClientsFromApi event, Emitter<SellerState> emit) async {
    visits = await _sellerRepository.getAllUserVisits();
    final value = await AuthLocalDataSource().getUserPause();
    emit(state.copyWith(
        clientInfoList: visits.reversed.toList(), isPaused: value));
  }

  void _whereFromEvent(WhereFromEvent event, Emitter<SellerState> emit) {
    emit(state.copyWith(whereFrom: event.whereFrom));
  }

  Future<void> _clearVisits(
      ClearVisits event, Emitter<SellerState> emit) async {
    emit(state.copyWith(showLoading: true, selectedIndex: event.index));
    await _sellerRepository.sendEmptySelling(id: event.id);
    visits = await _sellerRepository.getAllUserVisits();
    final value = await AuthLocalDataSource().getUserPause();

    emit(state.copyWith(
        clientInfoList: visits.reversed.toList(),
        showLoading: false,
        isPaused: value));
  }

  Future<void> _savePauseInfo(
      SavePauseInfo event, Emitter<SellerState> emit) async {
    await _sellerRepository.changePause(isPaused: !state.isPaused);
    AuthLocalDataSource().saveUserPause(!state.isPaused);
    final value = await AuthLocalDataSource().getUserPause();

    emit(state.copyWith(
      isPaused: value,
    ));
  }

  void _shareClient(ShareClient event, Emitter<SellerState> emit) async {
    _socketService.emitEvent('share-visit',
        {"seller": event.sellerId, "notification": event.notificationId});
    Fluttertoast.showToast(
      msg: 'Успешно отправлено',
      backgroundColor: AppColors.grey,
      timeInSecForIosWeb: 2,
      gravity: ToastGravity.CENTER,
      fontSize: 16,
      textColor: AppColors.white,
    );
  }

  final SellerAdminRepository _sellerAdminRepository = SellerAdminRepository();
  void _getSellersEvent(
      GetSellersEvent event, Emitter<SellerState> emit) async {
    emit(state.copyWith(showLoadingBottomSheet: true));
    final sellerList = await _sellerAdminRepository.getSellers();
    emit(state.copyWith(sellerList: sellerList, showLoadingBottomSheet: false));
    debugPrint(state.sellerList.first!.fullname!);
  }

  void _shareSelectedSeller(
      ShareSelectedSeller event, Emitter<SellerState> emit) {
    emit(state.copyWith(selectedSeller: event.selectedSeller));
    debugPrint(state.selectedSeller!.fullname!);
  }
}
