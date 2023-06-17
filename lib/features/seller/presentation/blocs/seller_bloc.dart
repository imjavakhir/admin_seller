import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/seller/data/client_info_model.dart';
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
    on<ConnectSocket>(_connectSocket);
  }
  List<ClientInfo?> newList = [];
  final SocketService _socketService;
  bool _isSocketConnected = false;
  Future<void> _connectSocket(
      ConnectSocket event, Emitter<SellerState> emit) async {}

  Future<void> _clientInfoListEvent(
      ClientInfoListEvent event, Emitter<SellerState> emit) async {
    final logToken = await AuthLocalDataSource().getLogToken();

    if (_isSocketConnected == false) {
      _socketService.connect(logToken!);
      _isSocketConnected = true;
    }
    if (_isSocketConnected) {
      _socketService.onEvent('new-order', (data) {
        debugPrint(
            'yangi klient ------------${clientInfoFromJson(data).details}');

        final newList = List<ClientInfo>.from(
            state.clientInfoList); // Create a new list from the existing state

        newList.add(clientInfoFromJson(data));
        print('list length----------------${newList.length}');

        add(ClientInfoListEvent(newList));

        // emit(SellerState(clientInfoList: newList));
      });
    }

    emit(SellerState(clientInfoList: event.clientInfosList));
  }
}
