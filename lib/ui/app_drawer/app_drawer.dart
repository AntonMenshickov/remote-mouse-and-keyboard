import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:remote/utils/ws.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer(
      {Key key,
      this.mouseSensitivity,
      this.scrollSensitivity,
      this.host,
      this.pass,
      this.onReconnectPressed,
      this.status,
      this.onMouseSensitivityChanged,
      this.onScrollSensitivityChanged,
      this.onHostChanged,
      this.onPassChanged,
      this.onDisconnectPressed})
      : super(key: key);

  final double mouseSensitivity;
  final void Function(double) onMouseSensitivityChanged;
  final double scrollSensitivity;
  final void Function(double) onScrollSensitivityChanged;
  final void Function() onReconnectPressed;
  final void Function() onDisconnectPressed;
  final ConnectionStatus status;
  final String host;
  final String pass;
  final Function(String) onHostChanged;
  final Function(String) onPassChanged;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  TextEditingController hostStringContoller;
  TextEditingController passStringContoller;

  @override
  initState() {
    hostStringContoller = TextEditingController(text: widget.host);
    passStringContoller = TextEditingController(text: widget.pass);
    super.initState();
  }

  void showHostChangeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Enter server address"),
          content: TextField(
            controller: hostStringContoller,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Connect"),
              onPressed: () {
                setState(() {
                  widget.onHostChanged(hostStringContoller.text);
                  widget.onReconnectPressed();
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void showPasswordChangeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Enter password if you know it"),
          content: TextField(
            controller: passStringContoller,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                setState(() {
                  widget.onPassChanged(passStringContoller.text);
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  onScanPressed() async {
    String cameraScanResult = await scanner.scan();
    if (cameraScanResult.startsWith('ws://')) {
      setState(() {
        hostStringContoller.text = cameraScanResult;
        widget.onHostChanged(hostStringContoller.text);
        widget.onReconnectPressed();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String readableStatus = 'Unknow';
    switch (widget.status) {
      case ConnectionStatus.connected:
        readableStatus = 'Connected';
        break;
      case ConnectionStatus.connecting:
        readableStatus = 'Connecting...';
        break;
      case ConnectionStatus.disconnected:
        readableStatus = 'Disconnected';
        break;
    }
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
              onTap: showHostChangeDialog,
              title: Text(readableStatus),
              subtitle: Text(hostStringContoller.text),
              trailing: IconButton(
                  onPressed: onScanPressed,
                  icon: SvgPicture.asset(
                    'assets/images/qr_code_scanner.svg',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ))),
          ListTile(
            onTap: showPasswordChangeDialog,
            title: Text('Password'),
            subtitle: Text(passStringContoller.text),
          ),
          ListTile(
            title: Text('Mouse sentivity'),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                  child: Slider(
                    onChanged: widget.onMouseSensitivityChanged,
                    value: widget.mouseSensitivity,
                    max: 10,
                    min: 0.1,
                  ),
                ),
                Container(
                    width: 30,
                    child: Text(widget.mouseSensitivity.toStringAsFixed(1))),
              ],
            ),
          ),
          ListTile(
            title: Text('Scroll sentivity'),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                  child: Slider(
                    onChanged: widget.onScrollSensitivityChanged,
                    value: widget.scrollSensitivity,
                    max: 10,
                    min: 0.1,
                  ),
                ),
                Container(
                    width: 30,
                    child: Text(widget.scrollSensitivity.toStringAsFixed(1))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
