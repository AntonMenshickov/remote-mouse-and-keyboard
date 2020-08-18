part of virtual_keyboard;

class KeyboardButtonStatus {
  KeyboardButtonStatus({@required this.keyCode, this.state = KeyState.up});

  final String keyCode;
  final KeyState state;
}
