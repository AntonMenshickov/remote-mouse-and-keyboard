part of virtual_keyboard;

/// Virtual Keyboard widget.
class VirtualKeyboard extends StatefulWidget {
  final List<List<KeyDescription>> keys;
  final Function(KeyboardEvent event) onKeyEvent;
  final void Function() onHide;
  final String currentLanguage;

  VirtualKeyboard({
    Key key,
    @required this.onKeyEvent,
    this.onHide,
    @required this.keys,
    this.currentLanguage,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VirtualKeyboardState();
  }
}

/// Holds the state for Virtual Keyboard class.
class _VirtualKeyboardState extends State<VirtualKeyboard> {
  Function onKeyDown;
  Function onKeyUp;

  List<List<KeyDescription>> get keys => widget.keys;

  List<KeyDescription> get keysDescriptions => keys.expand((i) => i).toList();

  final Map<String, KeyboardLayout> layoutBindings = {
    'en-US': KeyboardLayout.EN,
    'ru-RU': KeyboardLayout.RU
  };

  String currentLanguage = 'en-US';

  set layout(KeyboardLayout layout) {
    keysDescriptions.forEach((KeyDescription k) => k.layout = layout);
  }

  get layout {
    return layoutBindings.containsKey(currentLanguage) ? layoutBindings[currentLanguage] : null;
  }

  @override
  void initState() {
    if (layoutBindings.containsKey(widget.currentLanguage)) {
      setState(() {
        currentLanguage = widget.currentLanguage;
        layout = layoutBindings[currentLanguage];
      });
    }
    super.initState();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    if (layoutBindings.containsKey(widget.currentLanguage)) {
      setState(() {
        currentLanguage = widget.currentLanguage;
        layout = layoutBindings[currentLanguage];
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: keysLayout(),
    );
  }

  Widget keysLayout() => Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(keys.length, (int rowNum) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / keys.length,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  keys[rowNum].length,
                  (int keyNum) {
                    KeyDescription keyDescription = keys[rowNum][keyNum];
                    Widget keyWidget;
                    keyWidget = KeyboardKey(keyDescription, onKeyStateChange);
                    return keyWidget;
                  },
                ),
              ),
            );
          }),
        ),
      );

  altMode(bool value) {
    setState(() {
      keysDescriptions.forEach((KeyDescription k) => k.altMode = value);
    });
  }

  onKeyStateChange(KeyboardButtonStatus key) {
    switch (key.keyCode) {
      case 'hide':
        if (key.state == KeyState.up) {
          return widget.onHide();
        }
        return;
        break;
      case 'layout_change':
        if (key.state == KeyState.down) {
          return switchLayout();
        } else {
          return;
        }
        break;
      case 'shift':
        altMode(key.state == KeyState.down);
        break;
    }
    widget.onKeyEvent(KeyboardEvent(key));
  }

  switchLayout() {
    final layoutBindingsKeys = layoutBindings.keys.toList();
    int index = 0;
    setState(() {
      currentLanguage = layoutBindingsKeys.firstWhere((String v) {
        bool match = layoutBindingsKeys[index == 0 ? layoutBindingsKeys.length - 1 : index - 1] ==
            currentLanguage;
        index = index + 1;
        return match;
      }, orElse: () => 'en-US');
      layout = layoutBindings[currentLanguage];
    });
  }
}
