import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/seller/data/client_info_model.dart';
import 'package:admin_seller/services/api_service.dart';
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
  }

  final SocketService _socketService;
  bool _isSocketConnected = false;

  Future<void> _clientInfoListEvent(
      ClientInfoListEvent event, Emitter<SellerState> emit) async {
    final logToken = await AuthLocalDataSource().getLogToken();
    final apiVisits = await ApiService().getAllUserVisits();
    // final newList = List<ClientInfo>.from(state.clientInfoList);

    if (!_isSocketConnected) {
      _socketService.connect(logToken!);
      _isSocketConnected = true;
    }

    if (_isSocketConnected) {
      _socketService.onEvent('new-order', (data) {
        debugPrint('yangi klient ------------${clientInfoFromJson(data)}');
        apiVisits.add(clientInfoFromJson(data));

        final reversedList = apiVisits.reversed.toList();
        add(ClientInfoListEvent(reversedList));
      });
    }

    emit(SellerState(clientInfoList: event.clientInfosList));
  }

  Future<void> _getClientsFromApi(
      GetClientsFromApi event, Emitter<SellerState> emit) async {
    final apiVisits = await ApiService().getAllUserVisits();
    emit(state.copyWith(clientInfoList: apiVisits.reversed.toList()));
  }

  void _whereFromEvent(WhereFromEvent event, Emitter<SellerState> emit) {
    emit(state.copyWith(whereFrom: event.whereFrom));
  }
}
