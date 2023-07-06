import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/models/seller_model/sellers_model.dart';
import 'package:admin_seller/features/main_feature/data/models/usermodel/hive_usermodel.dart';
import 'package:admin_seller/features/seller/data/client_info_model.dart';
import 'package:admin_seller/features/seller/repository/seller_repo.dart';
import 'package:admin_seller/features/seller_admin/repository/seller_admin_repo.dart';
import 'package:admin_seller/services/socket_io_client_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

part 'seller_event.dart';
part 'seller_state.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {
  SellerBloc(this._socketService)
      : super(SellerState(
            sellerList: [], clientInfoList: const [], helpClients: [])) {
    on<ClientInfoListEvent>(_clientInfoListEvent);
    on<GetClientsFromApi>(_getClientsFromApi);
    on<WhereFromEvent>(_whereFromEvent);
    on<ClearVisits>(_clearVisits);
    on<SavePauseInfo>(_savePauseInfo);
    on<ShareClient>(_shareClient);
    on<GetSellersEvent>(_getSellersEvent);
    on<ShareSelectedSeller>(_shareSelectedSeller);
    on<DisconnectSocket>(_disconnectSocket);
    on<ConnectSocket>(_connectSocket);
    on<ShareClientBUtton>(_sharedClientButton);
    on<HelpShareClient>(_helpShareClient);
    on<HelpNotifications>(_helpNotifications);
    on<ChangeReportStatus>(_changeReportStatus);
  }

  final GlobalKey<AnimatedListState> key = GlobalKey();

  final SellerRepository _sellerRepository = SellerRepository();

  final SocketService _socketService;
  bool _isSocketConnected = false;
  List<ClientInfo?> visits = [];
  List<HelpClientInfo?> helpVisits = [];

  void _changeReportStatus(
      ChangeReportStatus event, Emitter<SellerState> emit) {
    emit(state.copyWith(isReported: !state.isReported));
  }

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

    emit(SellerState(
        clientInfoList: event.clientInfosList,
        sellerList: [],
        helpClients: []));
  }

  Future<void> _getClientsFromApi(
      GetClientsFromApi event, Emitter<SellerState> emit) async {
    emit(state.copyWith(loadingdata: true));
    visits = await _sellerRepository.getAllUserVisits();

    final value = await AuthLocalDataSource().getUserPause();
    emit(state.copyWith(loadingdata: false));
    emit(state.copyWith(
        clientInfoList: visits.reversed.toList(), isPaused: value));
  }

  void _whereFromEvent(WhereFromEvent event, Emitter<SellerState> emit) {
    emit(state.copyWith(whereFrom: event.whereFrom));
  }

  Future<void> _clearVisits(
      ClearVisits event, Emitter<SellerState> emit) async {
    emit(state.copyWith(showLoading: true, selectedIndex: event.index));
    await _sellerRepository.sendEmptySelling(id: event.id,report: event.report);
    visits = await _sellerRepository.getAllUserVisits();
    final value = await AuthLocalDataSource().getUserPause();

    emit(state.copyWith(
        clientInfoList: visits.reversed.toList(),
        showLoading: false,
        isPaused: value));
  }

  Future<void> _savePauseInfo(
      SavePauseInfo event, Emitter<SellerState> emit) async {
    AuthLocalDataSource().saveUserPause(state.isPaused);
    await _sellerRepository.changePause(isPaused: !state.isPaused);
    AuthLocalDataSource().saveUserPause(!state.isPaused);
    final value = await AuthLocalDataSource().getUserPause();

    emit(state.copyWith(
      isPaused: value,
    ));
  }

  Future<void> _shareClient(
      ShareClient event, Emitter<SellerState> emit) async {
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
    visits = await _sellerRepository.getAllUserVisits();

    emit(SellerState(
        clientInfoList: visits.reversed.toList(),
        sellerList: [],
        helpClients: []));
  }

  Future<void> _helpShareClient(
      HelpShareClient event, Emitter<SellerState> emit) async {
    _socketService.emitEvent('new-help',
        {"seller": event.sellerId, "notification": event.notificationId});

    Fluttertoast.showToast(
      msg: 'Успешно отправлено',
      backgroundColor: AppColors.grey,
      timeInSecForIosWeb: 2,
      gravity: ToastGravity.CENTER,
      fontSize: 16,
      textColor: AppColors.white,
    );
    visits = await _sellerRepository.getAllUserVisits();
    emit(state.copyWith(loadingdata: true));
    emit(SellerState(
        clientInfoList: visits.reversed.toList(),
        sellerList: [],
        helpClients: []));
    emit(state.copyWith(loadingdata: false));
  }

  final SellerAdminRepository _sellerAdminRepository = SellerAdminRepository();
  void _getSellersEvent(
      GetSellersEvent event, Emitter<SellerState> emit) async {
    emit(state.copyWith(showLoadingBottomSheet: true));
    final sellerList = await _sellerAdminRepository.getSellers();

    final hiveUserBox = Hive.box<UserModelHive>('User');
    final user = hiveUserBox.values.toList().cast<UserModelHive>();
    sellerList.removeWhere((item) => item!.fullname == user.first.fullName);
    emit(state.copyWith(sellerList: sellerList, showLoadingBottomSheet: false));

    // debugPrint(state.sellerList.first!.fullname!);
  }

  void _shareSelectedSeller(
      ShareSelectedSeller event, Emitter<SellerState> emit) async {
    emit(state.copyWith(selectedSeller: event.selectedSeller));

    debugPrint(state.selectedSeller!.fullname!);
  }

  void _disconnectSocket(DisconnectSocket event, Emitter<SellerState> emit) {
    _socketService.disconnect();
    emit(state);
  }

  void _connectSocket(ConnectSocket event, Emitter<SellerState> emit) async {
    final logToken = await AuthLocalDataSource().getLogToken();
    if (!_isSocketConnected) {
      _socketService.connect(logToken!);

      _isSocketConnected = true;
    }
  }

  void _sharedClientButton(ShareClientBUtton event, Emitter<SellerState> emit) {
    emit(state.copyWith(
        isShared: !state.isShared,
        selectedIndex: event.shareIndex,
        selectedSeller:
            Sellers(id: '', fullname: 'Не выбрали продавца', phoneNumber: '')));
  }

  Future<void> _helpNotifications(
      HelpNotifications event, Emitter<SellerState> emit) async {
    final logToken = await AuthLocalDataSource().getLogToken();
    // final apiVisits = await ApiService().getAllUserVisits();
    // final newList = List<ClientInfo>.from(state.clientInfoList);

    if (!_isSocketConnected) {
      _socketService.connect(logToken!);

      _isSocketConnected = true;
    }

    if (_isSocketConnected) {
      _socketService.offEvent('new-help-client');
      _socketService.onEvent('new-help-client', (data) {
        // key.currentState!
        //     .insertItem(0, duration: const Duration(milliseconds: 600));
        helpVisits.insert(0, helpclientInfoFromJson(data));

        debugPrint(
            'notification klient ------------${helpVisits.last!.details}');

        add(
          HelpNotifications(helpVisits),
        );
      });
    }

    emit(SellerState(
        helpClients: event.helpClients, sellerList: [], clientInfoList: []));
  }
}
