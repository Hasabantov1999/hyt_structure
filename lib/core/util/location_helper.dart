import 'package:geolocator/geolocator.dart';

class LocationHelper {
  Position? lastPosition;
    static final LocationHelper instance = LocationHelper._internal();

  factory LocationHelper() => instance;

  LocationHelper._internal();
  void init() async {
    lastPosition = await Geolocator.getLastKnownPosition();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final status = await Geolocator.getCurrentPosition();
    lastPosition = status;
    return status;
  }
}
