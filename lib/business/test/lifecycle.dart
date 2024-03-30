import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class LifeCycle {
  void demo() {
    late final AppLifecycleListener _listener;
    late AppLifecycleState? _state;

    _state = SchedulerBinding.instance.lifecycleState;
    _listener = AppLifecycleListener(
      onShow: () {
        debugPrint("UserPage > > > > > > : onShow");
      },
      onResume: () {
        debugPrint("UserPage > > > > > > : onResume");
      },
      onHide: () {
        debugPrint("UserPage > > > > > > : onHide");
      },
      onInactive: () {
        debugPrint("UserPage > > > > > > : onInactive");
      },
      onPause: () {
        debugPrint("UserPage > > > > > > : onPause");
      },
      onDetach: () {
        debugPrint("UserPage > > > > > > : onDetach");
      },
      onRestart: () {
        debugPrint("UserPage > > > > > > : onRestart");
      },
// This fires for each state change. Callbacks above fire only for
// specific state transitions.
      onStateChange: (value) {},
    );
  }
}
