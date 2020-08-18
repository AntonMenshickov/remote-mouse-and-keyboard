part of virtual_keyboard;


class PasswordEvent {
  final EventType eventType = EventType.password;
  final String password;

  PasswordEvent(String e)
      : password = e;

  PasswordEvent.fromJson(Map<String, dynamic> json)
      : password = json['password'];

  Map<String, dynamic> toJson() => {
        'eventType': eventType.toString().split('.')[1],
        'password': password,
      };
}
