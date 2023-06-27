import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/seller/data/client_info_model.dart';
import 'package:admin_seller/features/seller/repository/seller_repo.dart';
import 'package:admin_seller/services/socket_io_client_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seller_event.dart';
part 'seller_state.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {
  SellerBloc(this._socketService)
      : super(SellerState(clientInfoList: const [])) {
    on<ClientInfoListEvent>(_clientInfoListEvent);
    on<GetClientsFromApi>(_getClientsFromApi);
    on<WhereFromEvent>(_whereFromEvent);
    on<ClearVisits>(_clearVisits);
    on<SavePauseInfo>(_savePauseInfo);
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

    emit(SellerState(clientInfoList: event.clientInfosList));
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
}
