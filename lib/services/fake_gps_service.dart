import 'package:geolocator/geolocator.dart';

class FakeGpsService {

  static Future<bool> detectFakeGps() async {

    bool enabled =
    await Geolocator.isLocationServiceEnabled();

    if (!enabled) {
      return false;
    }

    LocationPermission permission =
    await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission =
      await Geolocator.requestPermission();
    }

    Position position =
    await Geolocator.getCurrentPosition();

    return position.isMocked;
  }
}