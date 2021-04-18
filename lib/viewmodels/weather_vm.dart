import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as l;
import 'package:weather_ui/models/weather_model.dart';
import 'package:weather_ui/values/constants.dart';

class WeatherViewModel extends ChangeNotifier {
  String _currentAddress;
  String get currentAddress => _currentAddress;

  l.Location location = l.Location();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  WeatherData weatherData;

  Position position;

  Dio _dio = Dio();

  void getCurrentLocation(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    bool _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission _permissionStatus;

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      notifyListeners();
    }

    if (_serviceEnabled) {
      _permissionStatus = await Geolocator.checkPermission();

      if (_permissionStatus == LocationPermission.denied ||
          _permissionStatus == LocationPermission.deniedForever) {
        await Geolocator.requestPermission().then((event) async {
          if (event == LocationPermission.always ||
              event == LocationPermission.whileInUse) {
            position = await Geolocator.getCurrentPosition();

            _getAddress(position.latitude, position.longitude).then((value) {
              _currentAddress = value.first.locality ?? 'Unknown location';
              notifyListeners();
            });
            getWeatherDetails(context, position.latitude, position.longitude);
          }
        });
      } else {
        position = await Geolocator.getCurrentPosition();
        _getAddress(position.latitude, position.longitude).then((value) {
          _currentAddress = value.first.locality ?? 'Unknown location';
          notifyListeners();
        });
        getWeatherDetails(context, position.latitude, position.longitude);
      }
    }
  }

  Future<List<Placemark>> _getAddress(double lat, double long) async {
    List<Placemark> add = await placemarkFromCoordinates(lat, long);
    Placemark placemark = add[0];

    return add;
  }

  Future<void> getWeatherDetails(
      BuildContext context, double lat, double long) async {
    _dio.options.connectTimeout = 30000;
    _dio.options.receiveTimeout = 30000;
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    try {
      String url =
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=hourly,minutely,alerts&appid=$APP_ID';

      print(url);
      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        _hasError = false;
        notifyListeners();
        weatherData = WeatherData.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.toString());
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
