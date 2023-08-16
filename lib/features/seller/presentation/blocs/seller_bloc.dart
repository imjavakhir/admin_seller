import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/models/seller_model/sellers_model.dart';
import 'package:admin_seller/features/main_feature/data/models/usermodel/hive_usermodel.dart';
import 'package:admin_seller/features/seller/data/ack_data_model.dart';
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
    on<AcceptVisitEvent>(_acceptVisitEvent);
    on<DeclineVisitEvent>(_declineVisitEvent);
  }

  final GlobalKey<AnimatedListState> key = GlobalKey();

  final SellerRepository _sellerRepository = SellerRepository();

  final SocketService _socketService;
  final ScrollController scrollController = ScrollController();
  bool _isSocketConnected = false;
  List<ClientInfo?> visits = [];
  List<HelpClientInfo?> helpVisits = [];

  void _acceptVisitEvent(AcceptVisitEvent event, Emitter<SellerState> emit) {
    _socketService.emitEventAck('accept-visit', event.data, (value) {
      debugPrint("${AckDataModel.fromJson(value).isAccepted}-------accepted");
    });
  }

  void _declineVisitEvent(DeclineVisitEvent event, Emitter<SellerState> emit) {
    _socketService.emitEventAck('cancel-visit', event.data, (value) {
      debugPrint("${AckDataModel.fromJson(value).isCanceled}-------canceled");
    });
  }

  void _changeReportStatus(
      ChangeReportStatus event, Emitter<SellerState> emit) {
    emit(state.copyWith(isReported: !state.isReported));
  }

  Future<void> _clientInfoListEvent(
      ClientInfoListEvent event, Emitter<SellerState> emit) async {
    final logToken = await AuthLocalDataSource().getLogToken();
    debugPrint("${logToken}_____________socketBloc");

    if (!_isSocketConnected) {
      _socketService.connect(logToken!);

      debugPrint(logToken);
      _isSocketConnected = true;
    }

    if (_isSocketConnected) {
      _socketService.offEvent('new-order');
      _socketService.onEvent('new-order', (data) {
        // key.currentState!
        //     .insertItem(0, duration: const Duration(milliseconds: 600));
        // scrollController.animateTo(
        //   scrollController.position.maxScrollExtent,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeOut,
        // );
        // scrollController.animateTo(
        //   scrollController.position.maxScrollExtent,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeOut,
        // );

        visits.add(ClientInfo.fromJson(data));
        // scrollController.animateTo(1.0,
        //     curve: Curves.easeIn, duration: const Duration(milliseconds: 300));

        debugPrint(
            'yangi klient ------------${ClientInfo.fromJson(data).sentAt}====${ClientInfo.fromJson(data).details}');
        // debugPrint(DateTime.now().toString());
        // debugPrint(DateTime.fromMillisecondsSinceEpoch(
        //         ClientInfo.fromJson(data).sentAt!)
        //     .toString());
        // debugPrint(
        //     "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(ClientInfo.fromJson(data).sentAt!)).inSeconds}-----------");

        add(
          ClientInfoListEvent(visits),
        );

        // for (int i = 0; i < visits.length; i++) {
        //   debugPrint(
        //       "[${DateTime.fromMillisecondsSinceEpoch(visits[i]!.sentAt!).toString()}]");
        // }
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
    emit(state.copyWith(clientInfoList: visits, isPaused: value));
  }

  void _whereFromEvent(WhereFromEvent event, Emitter<SellerState> emit) {
    emit(state.copyWith(whereFrom: event.whereFrom));
  }

  Future<void> _clearVisits(
      ClearVisits event, Emitter<SellerState> emit) async {
    emit(state.copyWith(showLoading: true, selectedIndex: event.index));
    await _sellerRepository.sendEmptySelling(
        id: event.id, report: event.report, sharedId: event.sharedId);

    final value = await AuthLocalDataSource().getUserPause();
    visits = await _sellerRepository.getAllUserVisits();

    // debugPrint(visits.first!.sentAt!.toString());
    // debugPrint(visits.first!.isAccepted!.toString());
    // debugPrint(visits.first!.isCanceled!.toString());
    // debugPrint(visits.first!.details!.toString());

    emit(state.copyWith(
        clientInfoList: visits, showLoading: false, isPaused: value));
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

    emit(SellerState(clientInfoList: visits, sellerList: [], helpClients: []));
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
    emit(SellerState(clientInfoList: visits, sellerList: [], helpClients: []));
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
    _isSocketConnected = false;

    emit(state);
    debugPrint('soccketDisconnected');
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
