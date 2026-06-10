import 'dart:async';

class SessionService {
  static Timer? _timer;

  static void startSession({
    required Function onTimeout,
    int seconds = 5,
  }) {
    _timer?.cancel();

    _timer = Timer(
      Duration(seconds: seconds),
          () => onTimeout(),
    );
  }

  static void resetSession({
    required Function onTimeout,
    int seconds = 5,
  }) {
    _timer?.cancel();

    startSession(
      onTimeout: onTimeout,
      seconds: seconds,
    );
  }

  static void stopSession() {
    _timer?.cancel();
  }
}