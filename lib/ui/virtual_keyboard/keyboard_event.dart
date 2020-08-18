part of virtual_keyboard;

class KeyboardEvent {
  final EventType eventType = EventType.keyboard;
  final String key;
  final KeyState state;

  KeyboardEvent(KeyboardButtonStatus e)
      : key = e.keyCode,
        state = e.state;

  KeyboardEvent.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        state = json['state'];

  Map<String, dynamic> toJson() => {
        'eventType': eventType.toString().split('.')[1],
        'key': key,
        'state': state.toString().split('.')[1],
      };
}
