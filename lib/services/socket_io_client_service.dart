import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket? socket;

class SocketIOService {
  final remote = 'http://64.226.90.160:3000/';
  final local = 'http://192.168.100.214:3000/';

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
    socket!.onConnect((_) {
      print('connected');
      print('--------------------------${socket!.connected}');
      if (socket == null) {
        print('nobullllll--------');
      }
    });
    // if (logToken != null) {
    // } else {
    //   if (kDebugMode) {
    //     print('errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
    //   }
    // }
  }

  void sendnotification(String sellerId, String details) {
    if (socket != null) {
      socket!.emit('new-visit', {"details": details, "seller": sellerId});
      print('sended');
    } else {}
  }

  void disconnectSocket() {
    socket!.disconnect();
    print('diconccecd--------------------------${socket!.disconnected}');
    // socket!.onDisconnect((_) {
    //   print('disconnnect----------------------');
    // });
  }
}
