import 'package:geolocator/geolocator.dart';

class GeoLocationServices {
  Future<String> getPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return "location-disabled";
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "permission-denied";
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return "permission-denied-permanent";
    }
    return 'permission-granted';
  }

  Future<Position> getPosition() {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

GeoLocationServices geoLocationServices = GeoLocationServices();
