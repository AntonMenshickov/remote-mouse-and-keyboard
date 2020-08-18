//import 'package:sensors/sensors.dart';

import 'package:remote/ui/mouse_buttons/mouse_button_status.dart';
import 'package:remote/ui/types/event_type.dart';

class MouseEvent {
  final EventType eventType = EventType.mouse;
  final double dx;
  final double dy;
  final List<MouseButtonStatus> buttons;
  final double scroll;

  MouseEvent(this.dx, this.dy, this.buttons, this.scroll);

  MouseEvent.fromJson(Map<String, dynamic> json)
      : dx = json['dx'],
        dy = json['dy'],
        buttons = json['buttons'],
        scroll = json['scroll'];

  Map<String, dynamic> toJson() => {
        'eventType': eventType.toString().split('.')[1],
        'dx': dx,
        'dy': dy,
        'buttons': buttons,
        'scroll': scroll,
      };
}
