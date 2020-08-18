import 'package:flutter/material.dart';
import 'package:remote/ui/hot_keys/hot_key.dart';
import 'package:remote/ui/virtual_keyboard/virtual_keyboard.dart';

class HotKeys extends StatefulWidget {
  final void Function(KeyboardEvent) onHotKeyPressed;
  final void Function() onKeyboardToggle;
  final double height;

  HotKeys(
      {Key key,
      @required this.onHotKeyPressed,
      @required this.height,
      @required this.onKeyboardToggle})
      : super();

  @override
  _HotKeysState createState() => _HotKeysState();
}

class _HotKeysState extends State<HotKeys> {
  List<Widget> _hotKeys;

  @override
  void initState() {
    _hotKeys = [
      HotKey(
        key: ValueKey([KeyDescription(value: 'keyboardToggle')]),
        child: Icon(Icons.keyboard),
        onPressed: widget.onHotKeyPressed,
      ),
      HotKey(
        key: ValueKey([KeyDescription(value: 'numericKeyboardToggle')]),
        child: Icon(Icons.dialpad),
        onPressed: widget.onHotKeyPressed,
      ),
      HotKey(
        key: ValueKey([
          KeyDescription(value: 'control'),
          KeyDescription(value: 'Z'),
        ]),
        child: Icon(Icons.undo),
        onPressed: widget.onHotKeyPressed,
      ),
      HotKey(
        key: ValueKey([
          KeyDescription(value: 'control'),
          KeyDescription(value: 'Y'),
        ]),
        child: Icon(Icons.redo),
        onPressed: widget.onHotKeyPressed,
      ),
      HotKey(
        key: ValueKey([
          KeyDescription(value: 'control'),
          KeyDescription(value: 'A'),
        ]),
        child: Icon(Icons.select_all),
        onPressed: widget.onHotKeyPressed,
      ),
      HotKey(
        key: ValueKey([
          KeyDescription(value: 'control'),
          KeyDescription(value: 'X'),
        ]),
        child: Icon(Icons.content_cut),
        onPressed: widget.onHotKeyPressed,
      ),
      HotKey(
        key: ValueKey([
          KeyDescription(value: 'control'),
          KeyDescription(value: 'C'),
        ]),
        child: Icon(Icons.content_copy),
        onPressed: widget.onHotKeyPressed,
      ),
      HotKey(
        key: ValueKey([
          KeyDescription(value: 'control'),
          KeyDescription(value: 'V'),
        ]),
        child: Icon(Icons.content_paste),
        onPressed: widget.onHotKeyPressed,
      ),
      HotKey(
        key: ValueKey([KeyDescription(value: 'audio_mute')]),
        child: Icon(Icons.volume_off),
        onPressed: widget.onHotKeyPressed,
      ),
      HotKey(
        key: ValueKey([KeyDescription(value: 'audio_vol_down')]),
        child: Icon(Icons.volume_down),
        onPressed: widget.onHotKeyPressed,
      ),
      HotKey(
        key: ValueKey([KeyDescription(value: 'audio_vol_up')]),
        child: Icon(Icons.volume_up),
        onPressed: widget.onHotKeyPressed,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(left: 2, right: 2),
          child: Container(
            height: widget.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_left,
                  size: 20,
                  color: Colors.white.withOpacity(0.1),
                ),
                Icon(
                  Icons.arrow_right,
                  size: 20,
                  color: Colors.white.withOpacity(0.1),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: widget.height,
          color: Colors.white.withOpacity(0.1),
          alignment: Alignment.topCenter,
          child: ReorderableListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10),
            onReorder: _onReorder,
            children: _hotKeys,
          ),
        ),
      ],
    );
  }

  _onReorder(int oldIndex, int newIndex) {
    _hotKeys.insert(newIndex, _hotKeys.removeAt(oldIndex));
  }
}
