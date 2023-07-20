import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/seller/data/client_info_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class SocketService {
  void connect(String logToken);

  void disconnect();

  void emitEvent(String eventName, dynamic data);
  void offEvent(String eventName);
  void onEvent(String eventName, void Function(dynamic) callback);
}

class SocketServiceImpl implements SocketService {
  late IO.Socket socket;
  final remoteTest = 'http://64.226.90.160:9999';
  final remote = 'http://64.226.90.160:3000/';

  @override
  void connect(String logToken) {
    socket = IO.io(
        remote,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({'token': logToken})
            .disableAutoConnect()
            .build());

    socket.connect();

    print('new-socket-connect---------}');
  }

  @override
  void disconnect() {
    if (socket.connected) {
      socket.disconnect();
      print('disconnected-------------------------------------------------}');
    }
  }

  @override
  void emitEvent(String eventName, dynamic data) {
    if (socket.connected) {
      socket.emit(eventName, data);
      print(data);
    }
  }

  @override
  void onEvent(String eventName, void Function(dynamic) callback) {
    socket.on(eventName, callback);
  }

  @override
  void offEvent(String eventName) {
    socket.off(eventName);
  }
}

//eskisi

IO.Socket? socket;

class SocketIOService {
  final remoteTest = 'http://64.226.90.160:9999';
  final remote = 'http://64.226.90.160:3000/';
  final local = 'http://192.168.100.214:3000/';
  final List<ClientInfo?> clientInfos = [];
  void connectSocket() async {
    final logToken = await AuthLocalDataSource().getLogToken();

    final fcmTokenLocal = await AuthLocalDataSource().getFcmToken();
    socket = IO.io(
        remote,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({'token': logToken})
            .disableAutoConnect()
            .build());

    socket!.connect();
    socket!.on('new-order', (data) {
      clientInfos.add(ClientInfo.fromJson(data));
      print('clientinfos----------$clientInfos');
      print('--------------------------Received response: $data');
    });
    socket!.onConnect((_) {
      print('connected--------------------------------');
      print('--------------------------${socket!.connected}');
      if (socket == null) {
        print('nobullllll--------');
      }
    });
  }

  void sendnotification(String sellerId, String details) {
    if (socket != null) {
      socket!.emit('new-visit', {"details": details, "seller": sellerId});
      Fluttertoast.showToast(
        msg: 'Успешно отправлено',
        backgroundColor: AppColors.grey,
        timeInSecForIosWeb: 2,
        gravity: ToastGravity.CENTER,
        fontSize: 16,
        textColor: AppColors.white,
      );
      print('sended');
    } else {}
  }

  void disconnectSocket() {
    if (socket != null) {
      socket!.disconnect();
      print('diconccecd--------------------------${socket!.disconnected}');
    }

    // socket!.onDisconnect((_) {
    //   print('disconnnect----------------------');
    // });
  }
}
