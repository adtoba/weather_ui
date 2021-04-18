import 'package:flutter/foundation.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class LocationVm extends ChangeNotifier {
  String _currentAddress;
  String get currentAddress => _currentAddress;

  Location location = Location();
  LocationData currentPosition;

  void getLocation() async {
    bool _serviceEnabled;

    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.requestService();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentPosition = await location.getLocation();

    _getAddress(currentPosition.latitude, currentPosition.longitude)
        .then((value) {
      _currentAddress = '${value.first.addressLine}';
      print(value.first.addressLine);
      notifyListeners();
    });
  }

  Future<List<Address>> _getAddress(double lat, double long) async {
    final coordinates = new Coordinates(lat, long);

    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    return add;
  }
}
