import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_ui/viewmodels/weather_vm.dart';

final weatherVm = ChangeNotifierProvider((ref) => WeatherViewModel());
