import 'package:geolocator/geolocator.dart';

class Location{
  var lat;
  var long;

  Future<void> getLocation() async
  {
    var status = await Geolocator.checkPermission();
    if (status == LocationPermission.denied) {
      // Request permission from the user
      status = await Geolocator.requestPermission();
    }
    if (status == LocationPermission.whileInUse) {
      // Get the device's location
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position);
      lat=position.latitude;
      long=position.longitude;
    } else {
      print('Please allow location permission');
    }
  }
}