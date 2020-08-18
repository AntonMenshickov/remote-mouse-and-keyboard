part of virtual_keyboard;

class KeyDescription {
  KeyDescription({
    List<List<dynamic>> keyLayouts,
    this.value,
    this.size = 10,
    this.allowRepeat = true,
    this.sticky = false,
    this.keyCode,
  }) {
    layouts = Map();
    if (keyLayouts == null || keyLayouts.isEmpty) {
      return;
    }
    int i = 0;
    keyLayouts.forEach((List<dynamic> layoutData) {
      final KeyboardLayout keyboardLayout = KeyboardLayout.values[i];
      layouts.putIfAbsent(keyboardLayout, () => layoutData);
      i++;
    });
  }

  Map<KeyboardLayout, List<dynamic>> layouts;
  KeyboardLayout layout = KeyboardLayout.EN;
  final String value;
  final int keyCode;
  final int size;
  final bool allowRepeat;
  final bool sticky;
  bool hold = false;
  bool altMode = false;
  bool down = false;
  Timer _repeatTimer;

  KeyState get state => down ? KeyState.down : KeyState.up;

  Pair<dynamic, dynamic> get keySymbols {
    List<dynamic> result;
    if (layouts.containsKey(layout)) {
      result = layouts[layout];
    } else {
      result = layouts.values.toList()[0];
    }
    return Pair(first: result[0], second: (result.length > 1 ? result[1] : null));
  }

  startRepeat(void Function() callback, {int msToStartRepeat = 1000}) {
    Timer(Duration(milliseconds: msToStartRepeat), () {
      if (!down) {
        return;
      }
      Timer.periodic(Duration(milliseconds: 200), (Timer timer) {
        _repeatTimer = timer;
        if (!down) {
          return timer.cancel();
        }
        callback();
      });
    });
  }

  stopRepeat() {
    if (_repeatTimer != null) {
      _repeatTimer.cancel();
    }
  }

  bool get repeating {
    return _repeatTimer != null;
  }
}
