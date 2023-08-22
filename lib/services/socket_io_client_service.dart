import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/seller/data/client_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class SocketService {
  void connect(String logToken);

  void disconnect();
  void emitEventAck(
      String eventName, dynamic data, ValueChanged receiveAckData);
  void emitEvent(String eventName, dynamic data);
  void offEvent(String eventName);
  void onEvent(String eventName, void Function(dynamic) callback);
}

class SocketServiceImpl implements SocketService {
  late IO.Socket _socket;
  final mongoUrl = 'http://64.226.90.160:5555';
  final localTestUrl = 'http://192.168.1.140:9999';
  final remoteTest = 'http://64.226.90.160:9999';
  final remote = 'http://64.226.90.160:3000/';

  @override
  void connect(String logToken) async {
    debugPrint("${logToken}_____________before connecting socket--------");
    final options = IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableForceNewConnection()
        .setQuery({'token': logToken})
        .disableAutoConnect()
        .build();
    _socket = IO.io(localTestUrl, options);

    _socket.connect();

    _socket.onConnect((_) {
      debugPrint('Connection established');
    });
    // _socket.onDisconnect((_) => debugPrint('Connection Disconnection'));
    // _socket.onConnectError((err) => debugPrint(err.toString()));
    // _socket.onError((err) => debugPrint(err));
    // _socket.on('javohir', (data) {
    //   debugPrint(data + "    response from socket");
    // });
  }

  @override
  void disconnect() {
    if (_socket.connected) {
      // socket.dispose();
      // debugPrint("disposed--------------------");
      _socket.disconnect();
      _socket.dispose();

      _socket.onDisconnect((data) => debugPrint('disconnected from socket'));
      debugPrint(
          'disconnected-------------------------------------------------}');
    }
  }

  @override
  void emitEvent(String eventName, dynamic data) {
    if (_socket.connected) {
      _socket.emit(eventName, data);
      debugPrint(data);
    }
  }

  @override
  void onEvent(String eventName, void Function(dynamic) callback) {
    _socket.on(eventName, callback);
  }

  @override
  void offEvent(String eventName) {
    if (_socket.connected) {
      _socket.off(eventName);
    }
  }

  @override
  void emitEventAck(eventName, data, valueChanged) {
    _socket.emitWithAck(eventName, data, ack: valueChanged);
  }
}

//eskisi

IO.Socket? socket;

class SocketIOService {
  final mongoUrl = 'http://64.226.90.160:5555';
  final localTestUrl = 'http://192.168.1.140:9999';
  final remoteTest = 'http://64.226.90.160:9999';
  final remote = 'http://64.226.90.160:3000/';
  final local = 'http://192.168.100.214:3000/';
  final List<ClientInfo?> clientInfos = [];
  void connectSocket() async {
    final logToken = await AuthLocalDataSource().getLogToken();
    debugPrint("${logToken}_____________socket");

    socket = IO.io(
        localTestUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNewConnection()
            .setQuery({'token': logToken})
            .disableAutoConnect()
            .build());

    socket!.connect();
    debugPrint("socket_connected");
    socket!.on('javohir', (data) {
      debugPrint(data + "    response from socket");
    });
    // socket!.on('new-order', (data) {
    //   clientInfos.add(ClientInfo.fromJson(data));
    //   print('clientinfos----------$clientInfos');
    //   print('--------------------------Received response: $data');
    // });
    // socket!.onConnect((_) {
    //   print('connected--------------------------------');
    // });
  }

  void sendnotification(String sellerId, String details) {
    if (socket != null) {
      socket!.emit('new-visit-2', {"details": details, "seller": sellerId});
      Fluttertoast.showToast(
        msg: 'Успешно отправлено',
        backgroundColor: AppColors.grey,
        timeInSecForIosWeb: 2,
        gravity: ToastGravity.CENTER,
        fontSize: 16,
        textColor: AppColors.white,
      );
      debugPrint('sended');
    } else {}
  }

  void sendnotificationAck(
      {required String sellerId,
      required String clientId,
      required ValueChanged receiveAckData}) {
    if (socket != null) {
      socket!.emitWithAck(
          'force-sent',
          {
            "visit": clientId,
            "seller": sellerId,
          },
          ack: receiveAckData);
      Fluttertoast.showToast(
        msg: 'Успешно переадресовона',
        backgroundColor: AppColors.grey,
        timeInSecForIosWeb: 2,
        gravity: ToastGravity.CENTER,
        fontSize: 16,
        textColor: AppColors.white,
      );
      debugPrint('sended');
    } else {}
  }

  void disconnectSocket() {
    if (socket != null) {
      socket!.disconnect();
      debugPrint('diconccecd--------------------------${socket!.disconnected}');
    }

    // socket!.onDisconnect((_) {
    //   print('disconnnect----------------------');
    // });
  }
}
