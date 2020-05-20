import 'package:distance/distance.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
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

  double locationBetweenInMeters(double latitude1, double longitude1, double latitude2, double longitude2) {
    return SphericalUtil.computeDistanceBetween(
      LatLng(latitude1, longitude1),
      LatLng(latitude2, longitude2)
    );
  }

  double locationBetweenInMiles(double latitude1, double longitude1, double latitude2, double longitude2) {
    return Distance(
      meters: locationBetweenInMeters(latitude1, longitude1, latitude2, longitude2).round()
    ).inMiles;
  }
}