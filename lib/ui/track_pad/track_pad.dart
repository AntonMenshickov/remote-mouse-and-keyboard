import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remote/ui/mouse_buttons/mouse_button.dart';
import 'package:remote/ui/mouse_buttons/mouse_button_state.dart';
import 'package:remote/ui/mouse_buttons/mouse_button_status.dart';
import 'package:remote/ui/mouse_buttons/mouse_event.dart';

class TrackPad extends StatefulWidget {
  TrackPad({
    @required this.onMouseEvent,
    this.mouseSensitivity = 1,
    this.scrollSensitivity = 1,
    this.refreshRate = 15,
  });

  final void Function(MouseEvent) onMouseEvent;
  final double mouseSensitivity;
  final double scrollSensitivity;
  final int refreshRate;

  @override
  _TrackPadState createState() => _TrackPadState();
}

class _TrackPadState extends State<TrackPad> {
  static final double _scrollWidth = 30;
  int _dragStart = 0;
  bool _isDragging = false;
  bool _isMoving = false;

  @override
  Widget build(BuildContext context) => Stack(children: <Widget>[
        GestureDetector(
          onPanUpdate: _onMove(),
          onTapDown: _onPointerDown,
          onTapUp: _onPointerUp,
          onTap: _onTap,
          child: Container(
            margin: EdgeInsets.only(right: _scrollWidth),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/grid.png'),
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
        ),
        GestureDetector(
          onVerticalDragUpdate: _onScroll(),
          child: Container(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.white.withOpacity(0.1),
              width: _scrollWidth,
            ),
          ),
        )
      ]);

  _onMove() {
    double dxAccum = 0;
    double dyAccum = 0;
    Timer timer;
    return (DragUpdateDetails details) {
      if (_dragStart == 2) {
        _isDragging = true;
        _dragStart = 0;
        widget.onMouseEvent(MouseEvent(
            0,
            0,
            [MouseButtonStatus(MouseButton.left, state: MouseButtonState.down)],
            0));
      }
      dxAccum += details.delta.dx * widget.mouseSensitivity;
      dyAccum += details.delta.dy * widget.mouseSensitivity;
      _isMoving = true;
      if (timer == null) {
        timer = Timer(Duration(milliseconds: widget.refreshRate), () {
          widget.onMouseEvent(MouseEvent(dxAccum, dyAccum, [], 0));
          dxAccum = 0;
          dyAccum = 0;
          timer = null;
          _isMoving = false;
        });
      }
    };
  }

  _onScroll() {
    double scroll = 0;
    Timer timer;
    return (DragUpdateDetails details) {
      scroll += details.delta.dy * widget.scrollSensitivity;
      if (timer == null) {
        timer = Timer(Duration(milliseconds: widget.refreshRate), () {
          if (scroll != 0) {
            widget.onMouseEvent(MouseEvent(0, 0, [], scroll));
          }
          scroll = 0;
          timer = null;
        });
      }
    };
  }

  _onPointerDown(TapDownDetails event) {
    _dragStart += 1;
    Timer(Duration(milliseconds: 500), () {
      _dragStart = 0;
    });
  }

  _onPointerUp(TapUpDetails event) {
    if (_dragStart == 2) {
      _dragStart = 0;
    }
    if (_isDragging) {
      _isDragging = false;
      widget.onMouseEvent(MouseEvent(
          0,
          0,
          [MouseButtonStatus(MouseButton.left, state: MouseButtonState.up)],
          0));
    }
  }

  _onTap() {
    if (!_isDragging && !_isMoving) {
      widget.onMouseEvent(MouseEvent(
          0,
          0,
          [MouseButtonStatus(MouseButton.left, state: MouseButtonState.down)],
          0));
      widget.onMouseEvent(MouseEvent(
          0,
          0,
          [MouseButtonStatus(MouseButton.left, state: MouseButtonState.up)],
          0));
    }
  }
}
