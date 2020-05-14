import 'package:location/location.dart';

class LocationService {
  Location location = new Location();

  Future<bool> isServiceEnabled() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    return Future.value(serviceEnabled);
  }

  Future<bool> hasPermission() async {
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.value(false);
      }
    }
    return Future.value(true);
  }

  Future<LocationData> getLocation() async {
    if (await isServiceEnabled() && await hasPermission()) {
      return await location.getLocation();
    }
    return Future.value(null);
  }
}