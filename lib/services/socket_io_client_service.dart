import 'package:admin_seller/app_const/app_exports.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

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
  late io.Socket _socket;
  final mongoUrl = 'http://64.226.90.160:5555';
  final localTestUrl = 'http://192.168.1.140:9999';
  final remoteTest = 'http://64.226.90.160:9999';
  final remote = 'http://64.226.90.160:3000/';
  final sellingLocal = 'http://192.168.1.140:9999';

  @override
  void connect(String logToken) async {
    debugPrint("${logToken}_____________before connecting socket--------");
    final options = io.OptionBuilder()
        .setTransports(['websocket'])
        .enableForceNewConnection()
        .setQuery({'token': logToken})
        .disableAutoConnect()
        .build();
    _socket = io.io(sellingLocal, options);

    _socket.connect();

    _socket.onConnect((_) {
      debugPrint('Connection established');
    });
  }

  @override
  void disconnect() {
    if (_socket.connected) {
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

io.Socket? socket;

class SocketIOService {
  final mongoUrl = 'http://64.226.90.160:5555';
  final localTestUrl = 'http://192.168.1.140:9999';
  final remoteTest = 'http://64.226.90.160:9999';
  final remote = 'http://64.226.90.160:3000/';
  final local = 'http://192.168.100.214:3000/';
  final sellingLocal = 'http://192.168.1.140:9999';
  final List<ClientInfo?> clientInfos = [];
  void connectSocket() async {
    final logToken = await AuthLocalDataSource().getLogToken();
    debugPrint("${logToken}_____________socket");

    socket = io.io(
        sellingLocal,
        io.OptionBuilder()
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
  }
}
