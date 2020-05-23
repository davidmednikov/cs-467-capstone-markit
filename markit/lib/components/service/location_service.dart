import 'package:distance/distance.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class LocationService {

  Future<Position> getLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
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