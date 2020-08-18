import 'package:remote/ui/mouse_buttons/mouse_button.dart';
import 'package:remote/ui/mouse_buttons/mouse_button_state.dart';

class MouseButtonStatus {
  final MouseButton button;
  MouseButtonState state;

  MouseButtonStatus(this.button, {this.state = MouseButtonState.up});

  MouseButtonStatus.fromJson(Map<String, dynamic> json)
      : button = MouseButton.values.firstWhere((e) => e.toString().split('.')[1] == json['button']),
        state =
            MouseButtonState.values.firstWhere((e) => e.toString().split('.')[1] == json['state']);

  Map<String, dynamic> toJson() => {
        'button': button.toString().split('.')[1],
        'state': state.toString().split('.')[1],
      };
}
