import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:weather_ui/models/weather_model.dart';
import 'package:weather_ui/values/constants.dart';

class WeatherViewModel extends ChangeNotifier {
  String _currentAddress;
  String get currentAddress => _currentAddress;

  Location location = Location();
  LocationData currentPosition;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  WeatherData weatherData;

  Dio _dio = Dio();

  void getLocation(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

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
      _currentAddress = '${value.first.locality}';
      if (_currentAddress != null) {
        getWeatherDetails(
            context, currentPosition.latitude, currentPosition.longitude);
      }
      notifyListeners();
    });
  }

  Future<List<Address>> _getAddress(double lat, double long) async {
    final coordinates = new Coordinates(lat, long);

    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    return add;
  }

  Future<void> getWeatherDetails(
      BuildContext context, double lat, double long) async {
    try {
      Response response = await _dio.get(
          '$BASE_URL/data/2.5/onecall?lat=$lat&lon=$long&exclude=hourly,minutely,alerts&appid=$APP_ID');

      if (response.statusCode == 200) {
        weatherData = WeatherData.fromJson(response.data);
        notifyListeners();
      } else {
        return null;
      }
    } on DioError catch (e) {
      _hasError = true;
      notifyListeners();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('$e'),
            );
          });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
