import 'dart:async';

import 'package:flutter/services.dart';
import 'package:remote/config.dart';
import 'package:remote/utils/ws.dart';

class Env {
  static Future<void> setPortrait() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  static Future<void> setLandscape() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  static Future<void> resetOrientation() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
  }

  static Future<void> setFullscreen() {
    return SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Ws _websocket;

  Ws get websocket => _websocket;

  String get websocketStatus {
    switch (_websocket.status) {
      case ConnectionStatus.connected:
        return 'Connected';
      case ConnectionStatus.connecting:
        return 'Connecting...';
      case ConnectionStatus.disconnected:
        return 'Disconnected';
      default:
        return 'Unknow';
    }
  }

  void connectWebsocket(
      String host, Function(ConnectionStatus) onStatusUpdated, void Function(dynamic) onMessage) {
    if (_websocket == null) {
      _websocket = Ws(
          host: Config.defaultHostURLString,
          onStatusUpdated: (ConnectionStatus status) {
            onStatusUpdated(status);
          });
    }
    _websocket.host = host;
    _websocket.connect(onMessage);
  }
}
