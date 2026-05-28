import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/events/base_event.dart';
import 'package:gym_buddy/interface/user_interaction.interface.dart';

class UserInteractionTracker implements UserInteraction {
  Amplitude? amplitude;

  void init(Amplitude amp) {
    amplitude = amp;
  }

  static UserInteractionTracker instance = UserInteractionTracker._();

  UserInteractionTracker._();

  factory UserInteractionTracker() {
    return instance;
  }

  factory UserInteractionTracker.init(Amplitude amp) {
    instance.init(amp);
    return instance;
  }

  @override
  void buttonClick(String buttonName, {Map<String, dynamic>? properties}) {
    amplitude?.track(BaseEvent(buttonName, eventProperties: properties));
  }

  @override
  void navigation(
    String fromPageName,
    String toPageName, {
    Map<String, dynamic>? properties,
  }) {
    amplitude?.track(
      BaseEvent(
        'navigation:$fromPageName->$toPageName',
        eventProperties: {'from': fromPageName, 'to': toPageName},
      ),
    );
  }

  @override
  void onScreen(String pageName, {Map<String, dynamic>? properties}) {
    amplitude?.track(
      BaseEvent('on_screen:$pageName', eventProperties: properties),
    );
  }

  @override
  void onTap(String content, {Map<String, dynamic>? properties}) {
    amplitude?.track(BaseEvent('tap', eventProperties: {'content': content}));
  }
}
