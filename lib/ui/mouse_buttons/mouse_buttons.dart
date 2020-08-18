import 'package:flutter/material.dart';
import 'package:remote/ui/mouse_buttons/mouse_button.dart';
import 'package:remote/ui/mouse_buttons/mouse_button_state.dart';
import 'package:remote/ui/mouse_buttons/mouse_button_status.dart';
import 'package:remote/ui/mouse_buttons/mouse_event.dart';

final List<MouseButtonStatus> buttons = [
  MouseButtonStatus(MouseButton.left),
  MouseButtonStatus(MouseButton.middle),
  MouseButtonStatus(MouseButton.right),
];

class MouseButtons extends StatefulWidget {
  final void Function(MouseEvent) onMouseEvent;

  MouseButtons({@required this.onMouseEvent});

  @override
  _MouseButtonsState createState() => _MouseButtonsState();
}

class _MouseButtonsState extends State<MouseButtons> with SingleTickerProviderStateMixin {
  final double _mouseButtonsHeight = 80;

  List<Widget> mouseButtons;

  @override
  Widget build(BuildContext context) {
    if (mouseButtons == null) {
      mouseButtons = buttons
          .map((b) => Expanded(
                flex: b.button == MouseButton.middle ? 1 : 2,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(right: BorderSide(width: 1, color: Colors.white12))),
                  child: GestureDetector(
                    onTapDown: (TapDownDetails d) {
                      b.state = MouseButtonState.down;
                      widget.onMouseEvent(MouseEvent(0, 0, [b], 0));
                    },
                    onTapUp: (TapUpDetails d) {
                      b.state = MouseButtonState.up;
                      widget.onMouseEvent(MouseEvent(0, 0, [b], 0));
                    },
                    onTapCancel: () {
                      b.state = MouseButtonState.up;
                      widget.onMouseEvent(MouseEvent(0, 0, [b], 0));
                    },
                  ),
                ),
              ))
          .toList();
    }
    return Container(
      height: _mouseButtonsHeight,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 3, color: Colors.white)),
        color: Colors.blueGrey[800],
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: mouseButtons),
    );
  }
}
