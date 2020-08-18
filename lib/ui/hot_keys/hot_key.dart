import 'package:flutter/material.dart';
import 'package:remote/ui/virtual_keyboard/key_state.dart';
import 'package:remote/ui/virtual_keyboard/virtual_keyboard.dart';

class HotKey extends StatelessWidget {
  final Widget child;
  final void Function(KeyboardEvent) onPressed;
  final ValueKey<List<KeyDescription>> key;

  HotKey({this.child = const Icon(Icons.play_circle_filled), @required this.onPressed, this.key});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => _keyCombinationPress(this.key.value),
      child: child,
    );
  }

  _keyCombinationPress(List<KeyDescription> keys) {
    keys.forEach((KeyDescription key) =>
        onPressed(KeyboardEvent(KeyboardButtonStatus(keyCode: key.value, state: KeyState.down))));
    keys.forEach((KeyDescription key) =>
        onPressed(KeyboardEvent(KeyboardButtonStatus(keyCode: key.value, state: KeyState.up))));
  }
}
