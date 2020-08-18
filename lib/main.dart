import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remote/config.dart';
import 'package:remote/ui/app_drawer/app_drawer.dart';
import 'package:remote/ui/hot_keys/hot_keys.dart';
import 'package:remote/ui/mouse_buttons/mouse_buttons.dart';
import 'package:remote/ui/mouse_buttons/mouse_event.dart';
import 'package:remote/ui/track_pad/track_pad.dart';
import 'package:remote/ui/virtual_keyboard/key_state.dart';
import 'package:remote/ui/virtual_keyboard/virtual_keyboard.dart';
import 'package:remote/utils/env.dart';
import 'package:remote/utils/ws.dart';

void main() async {
  runApp(MyApp(env: Env()));
}

class MyApp extends StatelessWidget {
  MyApp({@required this.env});

  final Env env;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remote keyboard and mouse',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey, brightness: Brightness.dark),
      home: MyHomePage(env: this.env),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.env}) : super(key: key);

  final Env env;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  static final int refreshRate = 10;
  static final double hotkeysHeight = 40;

  bool keyboardVisible = false;
  ConnectionStatus websocketConnectionStatus = ConnectionStatus.disconnected;
  double mouseSensitivity = 3;
  double scrollSensitivity = 3;
  String host = Config.defaultHostURLString;
  String pass = '';
  String language = 'en-US';
  List<List<KeyDescription>> _keys = full;

  _MyHomePageState() {
    Env.setPortrait();
    Env.setFullscreen();
  }

  @override
  void initState() {
    connectAndListen();
    super.initState();
  }

  connectAndListen() async {
    widget.env.connectWebsocket(host, (ConnectionStatus s) {
      widget.env.websocket.send(PasswordEvent(this.pass));
      setState(() {
        websocketConnectionStatus = s;
      });
    }, (dynamic data) {
      try {
        Map<String, dynamic> message = jsonDecode(data.toString());
        switch (message['eventType']) {
          case 'language':
            if (message['language'] != language) {
              setState(() {
                language = message['language'];
              });
            }
            break;
          case 'alert':
            this._showAlert(message['message']);
            break;
          default:
            print(message);
            break;
        }
      } catch (e) {
        throw e;
      }
    });
  }

  Future<void> _showAlert(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  AppBar get appBar => keyboardVisible
      ? null
      : AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 16,
          title: Text(widget.env?.websocketStatus ?? ''),
        );

  Widget get bottomBar => keyboardVisible ? null : buildMouseButtons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.blueGrey[900],
      key: _drawerKey,
      drawer: AppDrawer(
        host: host,
        onHostChanged: (String value) => setState(() {
          host = value;
        }),
        onPassChanged: (String value) => setState(() {
          pass = value;
        }),
        mouseSensitivity: mouseSensitivity,
        scrollSensitivity: scrollSensitivity,
        onMouseSensitivityChanged: (double v) => setState(() {
          mouseSensitivity = v;
        }),
        onScrollSensitivityChanged: (double v) => setState(() {
          scrollSensitivity = v;
        }),
        onReconnectPressed: reconnectWebsocket,
        status: websocketConnectionStatus,
      ),
      body: _buildBody(),
      bottomNavigationBar: bottomBar,
    );
  }

  Widget _buildBody() =>
      Container(child: keyboardVisible ? _buildKeyboard() : _buildTrackPad());

  Widget _buildTrackPad() => Stack(children: <Widget>[
        TrackPad(
          onMouseEvent: _onMouseEvent,
          scrollSensitivity: scrollSensitivity,
          mouseSensitivity: mouseSensitivity,
          refreshRate: refreshRate,
        ),
        _buildHotKeys(),
      ]);

  Widget buildMouseButtons() => MouseButtons(
        onMouseEvent: _onMouseEvent,
      );

  Widget _buildHotKeys() {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, hotkeysHeight),
      child: HotKeys(
        height: hotkeysHeight,
        onHotKeyPressed: _onKeyEvent,
        onKeyboardToggle: () {},
      ),
    );
  }

  _buildKeyboard() => keyboardVisible
      ? Container(
          alignment: Alignment.bottomCenter,
          child: Container(
              color: Colors.blueGrey[500],
              child: VirtualKeyboard(
                onKeyEvent: _onKeyEvent,
                onHide: toggleKeyboard,
                keys: _keys,
                currentLanguage: language,
              )),
        )
      : Container();

  reconnectWebsocket() {
    if (widget.env.websocket.status == ConnectionStatus.connected)
      widget.env.websocket.close();
    connectAndListen();
  }

  _onMouseEvent(MouseEvent event) {
    widget.env.websocket.send(event);
  }

  toggleKeyboard() {
    (() => !keyboardVisible ? Env.setLandscape() : Env.setPortrait())().then(
      (value) => setState(() {
        keyboardVisible = !keyboardVisible;
      }),
    );
  }

  _onKeyEvent(KeyboardEvent event) async {
    if (event.key == 'numericKeyboardToggle' || event.key == 'keyboardToggle') {
      if (event.state == KeyState.down) {
        return;
      }
      await Env.resetOrientation();
      if (event.key == 'numericKeyboardToggle' && !keyboardVisible) {
        await Env.setPortrait();
      }
      if (event.key == 'keyboardToggle' && !keyboardVisible) {
        await Env.setLandscape();
      }
      setState(() {
        _keys = event.key == 'numericKeyboardToggle' ? numbers : full;
        keyboardVisible = !keyboardVisible;
      });
      return;
    }
    widget.env.websocket.send(event);
  }

  @override
  void dispose() {
    SystemChrome.restoreSystemUIOverlays();
    widget.env.websocket.close();
    super.dispose();
  }
}
