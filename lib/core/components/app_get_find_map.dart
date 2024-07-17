
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class GetFindInMap {
 static  Future<LatLng?> getFindAddress(String address) async {
    LatLng? addressLatLng;
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;
        addressLatLng = LatLng(latitude, longitude);
      } else {}
    } catch (e) {
      return null;
    }
    return addressLatLng;
  }
}
