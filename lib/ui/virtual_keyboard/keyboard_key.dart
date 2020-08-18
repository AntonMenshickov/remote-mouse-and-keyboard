part of virtual_keyboard;

class KeyboardKey extends StatefulWidget {
  KeyboardKey(this.keyDescription, this.onStateChange);

  final KeyDescription keyDescription;

  final void Function(KeyboardButtonStatus key) onStateChange;

  @override
  _KeyboardKeyState createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
  set alt(bool value) {
    setState(() {
      widget.keyDescription.altMode = value;
    });
  }

  bool get alt => widget.keyDescription.altMode;

  KeyboardLayout get layout => widget.keyDescription.layout;

  KeyDescription get keyDescription => widget.keyDescription;
  void Function(KeyboardButtonStatus key) get onStateChange => widget.onStateChange;

  @override
  Widget build(BuildContext context) {
    final BorderSide keyBorder = const BorderSide(color: Colors.white10, width: 0);
    return Expanded(
      flex: keyDescription.size,
      child: Listener(
        onPointerDown: (PointerDownEvent details) => _onKeyDown(),
        onPointerUp: (PointerUpEvent details) => _onKeyUp(),
        child: MouseRegion(
          onExit: (PointerExitEvent event) => _onKeyUp(),
          child: Container(
            decoration: BoxDecoration(
                border: Border(right: keyBorder, bottom: keyBorder),
                color: keyDescription.down ? Colors.white12 : Colors.transparent),
            child: InkWell(
              child: KeyPresentation(symbols: keyDescription.keySymbols, alt: alt),
              onLongPress: _onKeyLongPress,
            ),
          ),
        ),
      ),
    );
  }

  _onKeyDown() {
    HapticFeedback.vibrate();
    setState(() {
      if (keyDescription.hold) {
        keyDescription.hold = false;
        keyDescription.down = false;
        return;
      } else {
        keyDescription.down = true;
      }
      onStateChange(
          KeyboardButtonStatus(keyCode: keyDescription.value, state: keyDescription.state));
      if (keyDescription.allowRepeat) {
        keyDescription.startRepeat(() {
          onStateChange(KeyboardButtonStatus(keyCode: keyDescription.value, state: KeyState.down));
          onStateChange(KeyboardButtonStatus(keyCode: keyDescription.value, state: KeyState.up));
        });
      }
    });
  }

  _onKeyUp() {
    HapticFeedback.vibrate();
    if (keyDescription.hold) {
      keyDescription.hold = false;
      return;
    }
    setState(() {
      keyDescription.down = false;
      onStateChange(KeyboardButtonStatus(keyCode: keyDescription.value));
    });
  }

  _onKeyLongPress() {
    if (!keyDescription.sticky) {
      return;
    }
    HapticFeedback.heavyImpact();
    setState(() {
      keyDescription.hold = true;
      onStateChange(
          KeyboardButtonStatus(keyCode: keyDescription.value, state: keyDescription.state));
    });
  }
}
