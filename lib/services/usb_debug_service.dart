import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class UsbDebugService {

  static const MethodChannel _channel =
  MethodChannel('usb_debug_checker');

  static Future<bool>
  isUsbDebuggingEnabled() async {

    if (kDebugMode) {
      return false;
    }

    try {

      final bool enabled =
      await _channel.invokeMethod(
        'isUsbDebuggingEnabled',
      );

      return enabled;

    } catch (e) {

      print(
        "Error USB Debug: $e",
      );

      return false;
    }
  }
}