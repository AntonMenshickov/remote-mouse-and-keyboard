import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as closeStatus;
import 'package:web_socket_channel/web_socket_channel.dart';

enum ConnectionStatus {
  connected,
  connecting,
  disconnected,
}

class Ws<T> {
  Ws({host = '', Function(ConnectionStatus) onStatusUpdated}) {
    _host = host;
    _onStatusUpdated = onStatusUpdated;
  }

  String _host;

  Function(ConnectionStatus) _onStatusUpdated;

  WebSocketChannel _channel;

  ConnectionStatus _connectionStatus = ConnectionStatus.disconnected;

  ConnectionStatus get status => _connectionStatus;

  set host(String value) {
    _host = value;
  }

  set _status(ConnectionStatus s) {
    _connectionStatus = s;
    if (_onStatusUpdated != null) {
      _onStatusUpdated(s);
    }
  }

  void send(dynamic data) {
    _channel.sink.add(jsonEncode(data));
  }

  Future close() async {
    return _channel.sink
        .close(closeStatus.normalClosure)
        .then((_) => _status = ConnectionStatus.disconnected);
  }

  void connect(void Function(dynamic) onMessage) async {
    if (_connectionStatus == ConnectionStatus.connected) {
      try {
        await close();
      } catch (e) {
        print(e);
      }
    }
    _channel =
        IOWebSocketChannel.connect(_host, pingInterval: Duration(seconds: 1));
    _status = ConnectionStatus.connecting;
    _channel.stream.listen((data) {
      _status = ConnectionStatus.connected;
      onMessage(data);
    }, onDone: () {
      _status = ConnectionStatus.disconnected;
    });
  }
}
